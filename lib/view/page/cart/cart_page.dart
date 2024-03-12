// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:jd_mall_flutter/view/page/cart/cart_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/component/back_to_top.dart';
import 'package:jd_mall_flutter/component/loading_widget.dart';
import 'package:jd_mall_flutter/view/page/cart/widget/cart_goods.dart';
import 'package:jd_mall_flutter/view/page/cart/widget/cart_header.dart';
import 'package:jd_mall_flutter/view/page/cart/widget/condition.dart';
import 'package:jd_mall_flutter/view/page/cart/widget/goods_list.dart';
import 'package:jd_mall_flutter/view/page/cart/widget/probably_like.dart';
import 'package:jd_mall_flutter/view/page/cart/widget/total_settlement.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController c = Get.put(CartController());
  late final ScrollController _scrollController;
  late final RefreshController _refreshController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _refreshController = RefreshController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        cartHeader(context),
        Expanded(
          child: Obx(() {
            bool isLoading = c.isLoading.value;

            return isLoading
                ? loadingWidget(context)
                : Scaffold(
                    backgroundColor: CommonStyle.colorF3F3F3,
                    body: SmartRefresher(
                      controller: _refreshController,
                      physics: const BouncingScrollPhysics(),
                      enablePullUp: true,
                      header: const ClassicHeader(spacing: 10, height: 58),
                      onRefresh: () => c.refreshPage(() => refreshSuccess(_refreshController), () => refreshFail(_refreshController)),
                      onLoading: () => c.loadNextPage(() => loadMoreSuccess(_refreshController), () => loadMoreFail(_refreshController)),
                      child: CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          condition(context),
                          cartGoods(context, c),
                          probablyLike(context),
                          goodsList(context, c),
                        ],
                      ),
                    ),
                    floatingActionButton: BackToTop(_scrollController),
                  );
          }),
        ),
        totalSettlement(context, c)
      ],
    );
  }
}
