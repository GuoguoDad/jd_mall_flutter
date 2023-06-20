import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/goods_item.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/cart/redux/cart_page_state.dart';

double width = 0;

Widget goodsList(BuildContext context) {
  width = (getScreenWidth(context) - 20) / 2;

  return StoreConnector<AppState, CartPageState>(
    converter: (store) {
      return store.state.cartPageState;
    },
    builder: (context, state) {
      var goodsList = state.goodsPageInfo.goodsList ?? [];
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
