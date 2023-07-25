// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/models/primary_category_list.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/category/redux/category_page_action.dart';
import 'package:jd_mall_flutter/view/page/category/redux/category_page_state.dart';

double itemHeight = 62.0;

Widget leftCate(BuildContext context, ScrollController _scrollController) {
  return StoreBuilder<AppState>(
    builder: (context, store) {
      SelectedCategoryInfo? selectedCategoryInfo = store.state.categoryPageState.selectedCategoryInfo;
      List<CategoryInfo> list = store.state.categoryPageState.categoryList ?? [];

      Widget scrollTabList = ListView.builder(
        controller: _scrollController,
        itemCount: list.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          bool isPrev = selectedCategoryInfo?.previous?.code == list[index].code;
          bool isSelect = selectedCategoryInfo?.current?.code == list[index].code;
          bool isNext = selectedCategoryInfo?.next?.code == list[index].code;

          return GestureDetector(
            onTap: () {
              store.dispatch(SelectCategoryAction(
                  SelectedCategoryInfo(index - 1 >= 0 ? list[index - 1] : null, list[index], index + 1 <= list.length - 1 ? list[index + 1] : null)));
              _scrollController.animateTo(calc2Top(context, index, list.length), duration: const Duration(milliseconds: 200), curve: Curves.linear);
            },
            child: Container(
              height: itemHeight,
              decoration: BoxDecoration(
                color: isSelect ? Colors.white : CommonStyle.greyBgColor3,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(isPrev ? 20 : 0), topRight: Radius.circular(isNext ? 20 : 0)),
              ),
              child: Center(
                child: Text(list[index].name!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
            ),
          );
        },
      );

      return Expanded(flex: 1, child: scrollTabList);
    },
  );
}

double calc2Top(BuildContext context, int index, int total) {
  //展示高度，即ListView展示高度
  double displayHeight = getScreenHeight(context) - 50 - getStatusHeight(context) - 56 - getBottomSpace(context);
  //item距离ListView顶部距离
  double item2Top = itemHeight * index;
  //item总高度
  double totalItemHeight = itemHeight * total;

  //所需滚动距离
  double distance = item2Top < displayHeight / 2 ? 0.0 : item2Top - displayHeight / 2 + itemHeight;
  //如果滚动距离大于 ListView item总高度 减掉 展示高度，则只能滚动item总高度 减掉 展示高度
  if (distance > totalItemHeight - displayHeight) {
    distance = totalItemHeight - displayHeight;
  }
  return distance;
}
