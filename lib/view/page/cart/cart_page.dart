// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/component/back_to_top.dart';
import 'package:jd_mall_flutter/component/loading_widget.dart';
import 'package:jd_mall_flutter/view/page/cart/cart_controller.dart';
import 'package:jd_mall_flutter/view/page/cart/widget/cart_goods.dart';
import 'package:jd_mall_flutter/view/page/cart/widget/cart_header.dart';
import 'package:jd_mall_flutter/view/page/cart/widget/condition.dart';
import 'package:jd_mall_flutter/view/page/cart/widget/goods_list.dart';
import 'package:jd_mall_flutter/view/page/cart/widget/probably_like.dart';
import 'package:jd_mall_flutter/view/page/cart/widget/total_settlement.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        cartHeader(),
        Expanded(
          child: Obx(() {
            bool isLoading = CartController.to.isLoading.value;
            if (isLoading) {
              return loadingWidget();
            }

            return Scaffold(
              backgroundColor: CommonStyle.colorF3F3F3,
              body: SmartRefresher(
                controller: CartController.to.refreshController,
                physics: const BouncingScrollPhysics(),
                enablePullUp: true,
                header: const ClassicHeader(spacing: 10, height: 58),
                onRefresh: () => CartController.to.refreshPage(
                  () => refreshSuccess(CartController.to.refreshController),
                  () => refreshFail(CartController.to.refreshController),
                ),
                onLoading: () => CartController.to.loadNextPage(
                  () => loadMoreSuccess(CartController.to.refreshController),
                  () => loadMoreFail(CartController.to.refreshController),
                ),
                child: CustomScrollView(
                  controller: CartController.to.scrollController,
                  slivers: [
                    condition(),
                    cartGoods(),
                    probablyLike(),
                    goodsList(),
                  ],
                ),
              ),
              floatingActionButton: BackToTop(CartController.to.scrollController),
            );
          }),
        ),
        totalSettlement(context)
      ],
    );
  }
}
