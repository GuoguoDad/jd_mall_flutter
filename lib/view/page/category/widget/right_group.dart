// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/group_grid_view.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/component/no_shadow_scroll_behavior.dart';
import 'package:jd_mall_flutter/generated/assets.dart';
import 'package:jd_mall_flutter/models/second_group_category_info.dart';
import 'package:jd_mall_flutter/view/page/category/category_controller.dart';

late double rWidth, bWidth;
//gridview的item宽和高一样
double thirdCateItemHeight = 0;

Widget rightGroupList(BuildContext context) {
  //右侧占屏幕三分之二
  rWidth = getScreenWidth(context) * 2 / 3;

  //gridview的item宽和高一样
  double thirdCateItemWidth = rWidth / 3;
  thirdCateItemHeight = thirdCateItemWidth;

  //右侧内容宽度
  bWidth = rWidth - 28;

  return Obx(() {
    bool isTabClicked = CategoryController.to.isTabClicked.value;
    SecondCateList? selectSecondCategoryInfo = CategoryController.to.selectSecondCategoryInfo.value;
    SecondGroupCategoryInfo? secondGroupCategoryInfo = CategoryController.to.secondGroupCategoryInfo.value;
    String headUrl = secondGroupCategoryInfo.bannerUrl ?? "";
    List<SecondCateList> secondCateList = secondGroupCategoryInfo.secondCateList ?? [];

    final secondKeys = <GlobalKey>[];
    for (var element in secondGroupCategoryInfo.secondCateList ?? []) {
      secondKeys.add(GlobalKey(debugLabel: 'second_${element.categoryCode}'));
    }

    final keys = <GlobalKey>[];
    for (var element in secondCateList) {
      keys.add(GlobalKey(debugLabel: 'section_${element.categoryCode}'));
    }

    void tabScrollToMiddle(int index) {
      double toLeft = 0;
      double total = 0;
      if (index != 0) {
        int newIndex = index - 1;
        for (int i = 0; i < secondCateList.length; i++) {
          RenderBox? box = secondKeys[i].currentContext?.findAncestorRenderObjectOfType<RenderBox>();
          if (box != null) {
            double w = box.size.width;
            total += w;
            if (i <= newIndex) {
              toLeft += w;
            }
          }
        }
        toLeft = toLeft - bWidth / 2;
        if (toLeft < 0) toLeft = 0;
        if (toLeft > total - bWidth) toLeft = total - bWidth;
      }
      CategoryController.to.rightScrollController.animateTo(toLeft, duration: const Duration(milliseconds: 300), curve: Curves.linear);
    }

    List<Widget> widgets = [];
    //二级分类上面的图片
    if (headUrl != "") {
      widgets.add(
        CachedNetworkImage(
          width: bWidth,
          height: 100,
          imageUrl: headUrl,
          placeholder: (context, url) => assetImage(Assets.imagesDefault, bWidth, 100),
          errorWidget: (context, url, error) => assetImage(Assets.imagesDefault, bWidth, 100),
          fit: BoxFit.cover,
        ),
      );
    }

    //二级分类滚动列表
    widgets.add(
      Container(
        width: bWidth,
        height: 32,
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: ListView.builder(
          controller: CategoryController.to.rightScrollController,
          itemCount: secondCateList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            bool isSelect = selectSecondCategoryInfo.categoryCode == secondCateList[index].categoryCode;

            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                //如果不是当前选中的二级分类
                if (selectSecondCategoryInfo.categoryCode != secondCateList[index].categoryCode) {
                  //滚动二级分类至中间
                  tabScrollToMiddle(index);
                  //选中二级分类
                  CategoryController.to.selectSecondCategory(secondCateList[index], true);

                  //滚动三级分类
                  RenderSliverToBoxAdapter? keyRenderObject = keys[index].currentContext?.findAncestorRenderObjectOfType<RenderSliverToBoxAdapter>();
                  if (keyRenderObject != null) {
                    CategoryController.to.gridViewController.position
                        .ensureVisible(keyRenderObject, duration: const Duration(milliseconds: 300), curve: Curves.linear)
                        .then((value) => CategoryController.to.setTabClicked(false));
                  }
                }
              },
              child: SecondCategoryItem(secondKeys: secondKeys, secondCateList: secondCateList, isSelect: isSelect, index: index),
            );
          },
        ),
      ),
    );

    //三级分组Gridview列表
    widgets.add(
      Expanded(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification.depth == 0) {
              if (isTabClicked) return false;

              int newIndex = findFirstVisibleItemIndex(keys);
              if (selectSecondCategoryInfo.categoryCode != secondCateList[newIndex].categoryCode) {
                //滚动二级分类至中间
                tabScrollToMiddle(newIndex);
                //选中二级分类
                CategoryController.to.selectSecondCategory(secondCateList[newIndex], false);
              }
            }
            return false;
          },
          child: GroupGridView(
            controller: CategoryController.to.gridViewController,
            padding: EdgeInsets.zero,
            scrollBehavior: NoShadowScrollBehavior(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
            ),
            sectionCount: secondCateList.length,
            itemInSectionCount: (int section) => secondCateList[section].cateList!.length,
            itemInSectionBuilder: (BuildContext context, IndexPath indexPath) =>
                ThirdCategoryItem(thirdCateItemWidth: thirdCateItemWidth, secondCateList: secondCateList, indexPath: indexPath),
            headerForSection: (section) => GroupHeader(keys: keys, secondCateList: secondCateList, section: section),
          ),
        ),
      ),
    );

    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: widgets,
        ),
      ),
    );
  });
}

class SecondCategoryItem extends StatelessWidget {
  const SecondCategoryItem({super.key, required this.secondKeys, required this.secondCateList, required this.isSelect, required this.index});

  final List<GlobalKey<State<StatefulWidget>>> secondKeys;
  final List<SecondCateList> secondCateList;
  final bool isSelect;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      key: secondKeys[index],
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 15, right: 15),
      margin: EdgeInsets.only(right: index + 1 != secondCateList.length ? 8 : 0),
      decoration: BoxDecoration(
        color: isSelect ? CommonStyle.selectBgColor : CommonStyle.greyBgColor2,
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        border: Border.all(color: isSelect ? CommonStyle.themeColor : CommonStyle.greyBgColor2, width: 1),
      ),
      child: Text(
        secondCateList[index].categoryName!,
        style: TextStyle(color: isSelect ? CommonStyle.themeColor : CommonStyle.primaryColor),
      ),
    );
  }
}

class GroupHeader extends StatelessWidget {
  const GroupHeader({super.key, required this.keys, required this.secondCateList, required this.section});

  final List<GlobalKey<State<StatefulWidget>>> keys;
  final List<SecondCateList> secondCateList;
  final int section;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: keys[section],
      height: 30,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        secondCateList[section].categoryName!,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class ThirdCategoryItem extends StatelessWidget {
  const ThirdCategoryItem({super.key, required this.thirdCateItemWidth, required this.secondCateList, required this.indexPath});

  final IndexPath indexPath;
  final double thirdCateItemWidth;
  final List<SecondCateList> secondCateList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: thirdCateItemWidth,
      height: thirdCateItemHeight,
      child: Column(
        children: [
          CachedNetworkImage(
            width: 58,
            height: 58,
            imageUrl: secondCateList[indexPath.section].cateList![indexPath.index].iconUrl!,
            placeholder: (context, url) => assetImage(Assets.imagesDefault, 58, 58),
            errorWidget: (context, url, error) => assetImage(Assets.imagesDefault, 58, 58),
            fit: BoxFit.fill,
          ),
          Container(
            height: 24,
            margin: const EdgeInsets.only(top: 4),
            child: Text(
              secondCateList[indexPath.section].cateList![indexPath.index].categoryName!,
              style: TextStyle(fontSize: 12, color: CommonStyle.color777677),
            ),
          )
        ],
      ),
    );
  }
}

int findFirstVisibleItemIndex(List<GlobalKey<State<StatefulWidget>>> keys) {
  int i = 0;
  for (; i < keys.length; i++) {
    //滚动三级分类
    RenderSliverToBoxAdapter? keyRenderObject = keys[i].currentContext?.findAncestorRenderObjectOfType<RenderSliverToBoxAdapter>();
    if (keyRenderObject != null) {
      //距离CustomScrollView顶部距离， 上滚出可视区域变为0
      final dy = (keyRenderObject.parentData as SliverPhysicalParentData).paintOffset.dy;
      if (dy > 10) {
        break;
      }
    }
  }
  final newIndex = i == 0 ? 0 : i - 1;
  return newIndex;
}
