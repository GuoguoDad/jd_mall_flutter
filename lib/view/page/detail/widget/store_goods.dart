import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/goods_item.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/store/app_state.dart';

double screenWidth = 0;

Widget storeGoods(BuildContext context) {
  screenWidth = getScreenWidth(context);

  return StoreBuilder<AppState>(
    builder: (context, store) {
      double width = (getScreenWidth(context) - 20) / 2;
      List<GoodsList>? goodsList = store.state.detailPageState.goodsPageInfo.goodsList ?? [];

      return SliverMasonryGrid.count(
        childCount: goodsList.length,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 0,
        itemBuilder: (context, index) => goodsItem(context, goodsList[index], width),
      );
    },
  );
}
