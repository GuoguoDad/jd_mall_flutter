import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/page/category/redux/category_page_action.dart';
import 'package:jd_mall_flutter/common/widget/group_grid_view.dart';
import 'package:jd_mall_flutter/common/widget/image/asset_image.dart';
import 'package:jd_mall_flutter/models/second_group_category_info.dart';
import 'package:widgets_visibility_provider/widgets_visibility_provider.dart';
import '../../../redux/app_state.dart';

late double rWidth, bWidth;
//gridview的item宽和高一样
double thirdCateItemHeight = 0;

Widget rightGroupList(BuildContext context) {
  ScrollController scrollController = ScrollController();
  ScrollController gridViewController = ScrollController();

  //右侧占屏幕三分之二
  rWidth = MediaQuery.of(context).size.width * 2 / 3;

  //gridview的item宽和高一样
  double thirdCateItemWidth = rWidth / 3;
  thirdCateItemHeight = thirdCateItemWidth;

  //右侧内容宽度
  bWidth = rWidth - 28;

  return StoreBuilder<AppState>(
    onInit: (store) {
      store.dispatch(InitDataAction());
    },
    builder: (context, store) {
      SecondCateList? selectSecondCategoryInfo = store.state.categoryPageState.selectSecondCategoryInfo;
      SecondGroupCategoryInfo? secondGroupCategoryInfo = store.state.categoryPageState.secondGroupCategoryInfo;
      String headUrl = secondGroupCategoryInfo?.bannerUrl ?? "";
      List<SecondCateList> secondCateList = secondGroupCategoryInfo?.secondCateList ?? [];

      final secondKeys = <GlobalKey>[];
      for (var element in secondGroupCategoryInfo?.secondCateList ?? []) {
        secondKeys.add(GlobalKey(debugLabel: 'second_${element.categoryCode}'));
      }

      final keys = <GlobalKey>[];
      for (var element in secondCateList) {
        keys.add(GlobalKey(debugLabel: 'section_${element.categoryCode}'));
      }

      Widget topBanImg = headUrl != ""
          ? CachedNetworkImage(
              width: bWidth,
              height: 100,
              imageUrl: headUrl,
              placeholder: (context, url) => assetImage("images/default.png", bWidth, 100),
              errorWidget: (context, url, error) => assetImage("images/default.png", bWidth, 100),
              fit: BoxFit.cover,
            )
          : Container();

      Widget secondScrollTabCategory = Container(
          width: bWidth,
          height: 32,
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: ListView.builder(
              controller: scrollController,
              itemCount: secondCateList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                bool isSelect = selectSecondCategoryInfo?.categoryCode == secondCateList[index].categoryCode;

                return GestureDetector(
                    onTap: () {
                      final keyRenderObject = keys[index].currentContext?.findAncestorRenderObjectOfType<RenderSliverToBoxAdapter>();
                      if (keyRenderObject != null) {
                        gridViewController.position
                            .ensureVisible(keyRenderObject, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                      }
                    },
                    child: Container(
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
                    ));
              }));

      //使用WidgetsVisibilityProvider 、WidgetsVisibilityListener和VisibleNotifierWidget组合监听得到第一个可见元素 firstVisibleItem
      Widget groupThirdCategoryList = WidgetsVisibilityProvider(
          child: Expanded(
              child: WidgetsVisibilityListener(
                  listener: (BuildContext context, WidgetsVisibilityEvent event) {
                    int firstVisibleIndex = event.positionDataList!.isNotEmpty ? event.positionDataList[0].data : 0;
                    SecondCateList firstVisibleItem = secondCateList[firstVisibleIndex];

                    //如果不是当前选中的二级分类
                    if (firstVisibleItem.categoryCode != selectSecondCategoryInfo?.categoryCode) {
                      store.dispatch(SelectSecondCategoryAction(firstVisibleItem));

                      RenderBox? box = secondKeys[firstVisibleIndex].currentContext?.findAncestorRenderObjectOfType<RenderBox>();
                      if (box != null) {
                        Offset os = box.localToGlobal(Offset.zero);
                        double w = box.size.width;
                        //相对于父组件的x距离
                        double x = os.dx - MediaQuery.of(context).size.width / 3 - 14;

                        double rlOffset = bWidth / 2 - (x + w / 2);
                        double offset = scrollController.offset - rlOffset;
                        if (offset < 0) {
                          offset = 0;
                        }
                        scrollController.animateTo(offset, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                      }
                    }
                  },
                  child: GroupGridView(
                      controller: gridViewController,
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 0, crossAxisSpacing: 0),
                      sectionCount: secondCateList.length,
                      itemInSectionCount: (int section) => secondCateList[section].cateList!.length!,
                      itemInSectionBuilder: (BuildContext context, IndexPath indexPath) {
                        return SizedBox(
                          width: thirdCateItemWidth,
                          height: thirdCateItemHeight,
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                width: 58,
                                height: 58,
                                imageUrl: secondCateList[indexPath.section].cateList![indexPath.index].iconUrl!,
                                placeholder: (context, url) => assetImage("images/default.png", 58, 58),
                                errorWidget: (context, url, error) => assetImage("images/default.png", 58, 58),
                                fit: BoxFit.fill,
                              ),
                              Container(
                                  height: 24,
                                  margin: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    secondCateList[indexPath.section].cateList![indexPath.index].categoryName!,
                                    style: TextStyle(fontSize: 12, color: CommonStyle.color777677),
                                  ))
                            ],
                          ),
                        );
                      },
                      headerForSection: (section) => VisibleNotifierWidget(
                          data: section,
                          child: Container(
                              key: keys[section],
                              height: 30,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(secondCateList[section].categoryName!,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))))))));

      return Expanded(
          flex: 2,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [topBanImg, secondScrollTabCategory, groupThirdCategoryList],
            ),
          ));
    },
  );
}
