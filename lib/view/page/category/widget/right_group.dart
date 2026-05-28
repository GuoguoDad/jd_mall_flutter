// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/group_grid_view.dart';
import 'package:jd_mall_flutter/component/image/extend_image_network.dart';
import 'package:jd_mall_flutter/component/no_shadow_scroll_behavior.dart';
import 'package:jd_mall_flutter/models/second_group_category_info.dart';
import 'package:jd_mall_flutter/view/page/category/category_provider.dart';
import 'package:provider/provider.dart';

//右侧占屏幕三分之二
double rWidth = getScreenWidth() * 2 / 3;

//gridview的item宽和高一样
double thirdCateItemWidth = rWidth / 3;
double thirdCateItemHeight = thirdCateItemWidth;

//右侧内容宽度
double bWidth = rWidth - 28;

class RightGroupList extends StatefulWidget {
  final ScrollController rightScrollController;
  final ScrollController gridViewController;
  const RightGroupList(this.rightScrollController, this.gridViewController, {super.key});

  @override
  State<RightGroupList> createState() => RightGroupListState();
}

class RightGroupListState extends State<RightGroupList> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 10),
        child: Consumer<CategoryProvider>(
            builder: (context, provider, child) {

              bool isTabClicked = provider.isTabClicked;
              SecondCateList? selectSecondCategoryInfo = provider.selectSecondCategoryInfo;
              SecondGroupCategoryInfo? secondGroupCategoryInfo = provider.secondGroupCategoryInfo;
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
                widget.rightScrollController.animateTo(toLeft, duration: const Duration(milliseconds: 300), curve: Curves.linear);
              }


              return Column(
                children: [
                  ExtendImageNetwork(url: headUrl,
                    width: bWidth,
                    height: 100,
                    cache: true,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: bWidth,
                    height: 32,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: ListView.builder(
                      controller: widget.rightScrollController,
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
                              provider.selectSecondCategory(secondCateList[index], true);

                              //滚动三级分类
                              RenderSliverToBoxAdapter? keyRenderObject = keys[index].currentContext?.findAncestorRenderObjectOfType<RenderSliverToBoxAdapter>();
                              if (keyRenderObject != null) {
                                widget.gridViewController.position
                                    .ensureVisible(keyRenderObject, duration: const Duration(milliseconds: 300), curve: Curves.linear)
                                    .then((value) => provider.setTabClicked(false));
                              }
                            }
                          },
                          child: SecondCategoryItem(secondKeys: secondKeys, secondCateList: secondCateList, isSelect: isSelect, index: index),
                        );
                      },
                    ),
                  ),
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
                            provider.selectSecondCategory(secondCateList[newIndex], false);
                          }
                        }
                        return false;
                      },
                      child: GroupGridView(
                        controller: widget.gridViewController,
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
                ],
              );
            }
        ),
      ),
    );
  }
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
          ExtendImageNetwork(url: secondCateList[indexPath.section].cateList![indexPath.index].iconUrl!,
            width: 58,
            height: 58,
            cache: true,
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
