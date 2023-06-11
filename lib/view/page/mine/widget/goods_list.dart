import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jd_mall_flutter/common/widget/goods_item.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/mine/redux/mine_page_state.dart';

double width = 0;

Widget goodsList(BuildContext context) {
  width = (MediaQuery.of(context).size.width - 20) / 2;

  return StoreConnector<AppState, MinePageState>(
    converter: (store) {
      return store.state.minePageState;
    },
    builder: (context, state) {
      var goodsList = state.goodsPageInfo.goodsList ?? [];
      return SliverMasonryGrid.count(
        childCount: goodsList.length,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 0,
        itemBuilder: (context, index) => goodsItem(goodsList[index], width),
      );
    },
  );
}
