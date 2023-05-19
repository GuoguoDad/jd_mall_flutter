import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/util/color_util.dart';
import 'package:jd_mall_flutter/page/category/redux/category_page_action.dart';

import '../../../common/widget/image/asset_image.dart';
import '../../../models/second_group_category_info.dart';
import '../../../redux/app_state.dart';

double scrollTabItemWidth = 82;
double tabItemMarginRight = 8;
late double rWidth, bWidth;

Widget rightGroupList(BuildContext context) {
  ScrollController scrollController = ScrollController();
  rWidth = MediaQuery.of(context).size.width * 2 / 3;
  bWidth = rWidth - 28;
  double bannerHeight = 100;

  return StoreBuilder<AppState>(
    onInit: (store) {
      store.dispatch(InitDataAction());
    },
    builder: (context, store) {
      CateList? selectSecondCategoryInfo = store.state.categoryPageState.selectSecondCategoryInfo;
      SecondGroupCategoryInfo? secondGroupCategoryInfo = store.state.categoryPageState.secondGroupCategoryInfo;
      String headUrl = secondGroupCategoryInfo?.bannerUrl ?? "";
      List<CateList> cateList = secondGroupCategoryInfo?.cateList ?? [];

      return Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            headUrl != ""
                ? CachedNetworkImage(
                    width: bWidth,
                    height: bannerHeight,
                    imageUrl: headUrl,
                    placeholder: (context, url) => assetImage("images/default.png", bWidth, bannerHeight),
                    errorWidget: (context, url, error) => assetImage("images/default.png", bWidth, bannerHeight),
                    fit: BoxFit.cover,
                  )
                : Container(),
            Container(
                width: bWidth,
                height: 32,
                margin: const EdgeInsets.only(top: 8),
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: cateList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      bool isSelect = selectSecondCategoryInfo?.categoryCode == cateList[index].categoryCode;

                      return GestureDetector(
                          onTap: () {
                            store.dispatch(SelectSecondCategoryAction(cateList[index]));
                            scrollController.animateTo(calc2Left(context, index, cateList.length),
                                duration: const Duration(milliseconds: 200), curve: Curves.linear);
                          },
                          child: Container(
                            height: 32,
                            width: scrollTabItemWidth,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(right: index + 1 != cateList.length ? tabItemMarginRight : 0),
                            decoration: BoxDecoration(
                              color: ColorUtil.hex2Color(isSelect ? "#F2E9E2" : "#F1F1F2"),
                              borderRadius: const BorderRadius.all(Radius.circular(14)),
                              border: Border.all(color: ColorUtil.hex2Color(isSelect ? "#AD1440" : "#EFEFF0"), width: 1),
                            ),
                            child: Text(
                              cateList[index].categoryName!,
                              style: TextStyle(color: ColorUtil.hex2Color(isSelect ? "#AD1440" : "#3E3F40")),
                            ),
                          ));
                    }))
          ],
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
