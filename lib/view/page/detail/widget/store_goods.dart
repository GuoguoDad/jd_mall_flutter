// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/goods_item.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_controller.dart';

double screenWidth = 0;

Widget storeGoods(BuildContext context) {
  screenWidth = getScreenWidth(context);

  return Obx(
    () {
      double width = (getScreenWidth(context) - 20) / 2;
      List<GoodsList>? goodsList = DetailController.to.goodsPageInfo.value.goodsList ?? [];

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
