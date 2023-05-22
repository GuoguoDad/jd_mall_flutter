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

double bannerHeight = 100;
//二级分类item宽度
double scrollTabItemWidth = 82;
//二级分类item间距
double tabItemMarginRight = 8;
late double rWidth, bWidth;
//gridview的item宽和高一样
double thirdCateItemHeight = 0;
//groupGridview的分组头高度
double sectionHeight = 30;

Widget rightGroupList(BuildContext context) {
  ScrollController leftScrollController = ScrollController();
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

      final keys = <GlobalKey>[];
      for (var element in secondCateList) {
        keys.add(GlobalKey(debugLabel: 'section_${element.categoryCode}'));
      }

      var topBanImg = headUrl != ""
          ? CachedNetworkImage(
              width: bWidth,
              height: bannerHeight,
              imageUrl: headUrl,
              placeholder: (context, url) => assetImage("images/default.png", bWidth, bannerHeight),
              errorWidget: (context, url, error) => assetImage("images/default.png", bWidth, bannerHeight),
              fit: BoxFit.cover,
            )
          : Container();

      var secondScrollTabCategory = Container(
          width: bWidth,
          height: 32,
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: ListView.builder(
              controller: leftScrollController,
              itemCount: secondCateList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                bool isSelect = selectSecondCategoryInfo?.categoryCode == secondCateList[index].categoryCode;

                return GestureDetector(
                    onTap: () {
                      // store.dispatch(SelectSecondCategoryAction(secondCateList[index]));
                      //滚动当前选中的item至中间
                      leftScrollController.animateTo(calc2Left(context, index, secondCateList.length),
                          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);

                      // //滚动分组三级分类
                      // gridViewController.animateTo(calc2top(context, index, secondCateList),
                      //     duration: const Duration(milliseconds: 200), curve: Curves.linear);

                      //滚动分组三级分类
                      final keyRenderObject = keys[index].currentContext?.findAncestorRenderObjectOfType<RenderSliverToBoxAdapter>();
                      if (keyRenderObject != null) {
                        // 点击的时候不让滚动影响tab
                        gridViewController.position
                            .ensureVisible(keyRenderObject, duration: const Duration(milliseconds: 300), curve: Curves.easeIn)
                            .then((value) {});
                      }
                    },
                    child: Container(
                      height: 32,
                      width: scrollTabItemWidth,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: index + 1 != secondCateList.length ? tabItemMarginRight : 0),
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
      var groupThirdCategoryList = WidgetsVisibilityProvider(
          child: Expanded(
              child: WidgetsVisibilityListener(
                  listener: (BuildContext context, WidgetsVisibilityEvent event) {
                    int firstVisibleIndex = event.positionDataList!.isNotEmpty ? event.positionDataList[0].data : 0;
                    SecondCateList firstVisibleItem = secondCateList[firstVisibleIndex];

                    //如果不是当前选中的二级分类
                    if (firstVisibleItem.categoryCode != selectSecondCategoryInfo?.categoryCode) {
                      store.dispatch(SelectSecondCategoryAction(firstVisibleItem));
                      leftScrollController.animateTo(calc2Left(context, firstVisibleIndex, secondCateList.length),
                          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
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
                                placeholder: (context, url) => assetImage("images/default.png", bWidth, bannerHeight),
                                errorWidget: (context, url, error) => assetImage("images/default.png", bWidth, bannerHeight),
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
                              height: sectionHeight,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(secondCateList[section].categoryName!,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))))))));

      return Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [topBanImg, secondScrollTabCategory, groupThirdCategoryList],
        ),
      );
    },
  );
}

double calc2Left(BuildContext context, int index, int total) {
  //展示宽度，即ListView展示宽度
  double displayWidth = bWidth;
  //item距离ListView左边距离
  double item2Left = (scrollTabItemWidth + tabItemMarginRight) * index;
  //item总宽度
  double totalItemWidth = (scrollTabItemWidth + tabItemMarginRight) * total - tabItemMarginRight;

  //所需滚动距离
  double toLeft = item2Left < displayWidth / 2 ? 0.0 : item2Left - displayWidth / 2 + scrollTabItemWidth / 2;
  //如果滚动距离大于 ListView item总宽度 减掉 展示宽度，则只能滚动item总宽度 减掉 展示宽度
  if (toLeft > totalItemWidth - displayWidth) {
    toLeft = totalItemWidth - displayWidth;
  }
  return toLeft;
}

// double calc2top(BuildContext context, int index, List<SecondCateList> secondCateList) {
//   EdgeInsets mfp = MediaQueryData.fromView(View.of(context)).padding;
//   //展示高度，即GroupGridView展示高度
//   double displayHeight = MediaQuery.of(context).size.height - 50 - mfp.top - 56 - mfp.bottom - bannerHeight - 52;
//
//   //groupGridview 所有item总高度
//   double totalHeight = 0;
//   for (var element in secondCateList) {
//     int cateChildren = element.cateList!.length;
//     int rowNum = cateChildren ~/ 3 + (cateChildren % 3 > 0 ? 1 : 0);
//
//     totalHeight += rowNum * thirdCateItemHeight + sectionHeight;
//   }
//   //需要向上滚动距离
//   double toTop = 0;
//   List<SecondCateList> secondCate = secondCateList.sublist(0, index);
//   for (var element in secondCate) {
//     int totalChildren = element.cateList!.length;
//     int rowNum = totalChildren ~/ 3 + (totalChildren % 3 > 0 ? 1 : 0);
//
//     toTop += rowNum * thirdCateItemHeight + sectionHeight;
//   }
//   if (toTop < 0) {
//     toTop = 0;
//   }
//   if (toTop > totalHeight - displayHeight - sectionHeight) {
//     toTop = totalHeight - displayHeight - sectionHeight;
//   }
//
//   return toTop;
// }
