// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/goods_item.dart';
import 'package:jd_mall_flutter/view/page/cart/cart_controller.dart';

double width = 0;

Widget goodsList(BuildContext context, CartController c) {
  width = (getScreenWidth(context) - 20) / 2;

  return Obx(() {
    var goodsList = c.goodsPageInfo.value.goodsList ?? [];

    return SliverMasonryGrid.count(
      childCount: goodsList.length,
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 0,
      itemBuilder: (context, index) => goodsItem(context, goodsList[index], width),
    );
  });
}
