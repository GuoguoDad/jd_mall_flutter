// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:jd_mall_flutter/view/page/cart/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

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
  State<CartPage> createState() => CartPageState();
}


class CartPageState extends State<CartPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartProvider>().initCartGoodsData();
    });
  }

  @override
  void dispose() {
    context.read<CartProvider>().refreshController.dispose();
    context.read<CartProvider>().scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CartHeader(),
        Expanded(
          child: Scaffold(
            backgroundColor: CommonStyle.colorF3F3F3,
            body: SmartRefresher(
              controller: context.read<CartProvider>().refreshController,
              physics: const BouncingScrollPhysics(),
              enablePullUp: true,
              header: const ClassicHeader(spacing: 10, height: 58),
              onRefresh: () => context.read<CartProvider>().refreshPage(
                    () => refreshSuccess(context.read<CartProvider>().refreshController),
                    () => refreshFail(context.read<CartProvider>().refreshController),
              ),
              onLoading: () => context.read<CartProvider>().loadNextPage(
                    () => loadMoreSuccess(context.read<CartProvider>().refreshController),
                    () => loadMoreFail(context.read<CartProvider>().refreshController),
              ),
              child: CustomScrollView(
                controller: context.read<CartProvider>().scrollController,
                slivers: [
                  TopCondition(),
                  CartGoodsList(),
                  ProbablyLikeHeader(),
                  ProbablyLikeGoods(),
                ],
              ),
            ),
            floatingActionButton: BackToTop(context.read<CartProvider>().scrollController),
          ),
        ),
        TotalSettlement()
      ],
    );
  }
}
