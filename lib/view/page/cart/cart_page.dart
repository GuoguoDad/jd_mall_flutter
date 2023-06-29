import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/view/page/cart/redux/cart_page_action.dart';
import 'package:jd_mall_flutter/view/page/cart/widget/cart_goods.dart';
import 'package:jd_mall_flutter/view/page/cart/widget/cart_header.dart';
import 'package:jd_mall_flutter/view/page/cart/widget/condition.dart';
import 'package:jd_mall_flutter/view/page/cart/widget/probably_like.dart';
import 'package:jd_mall_flutter/view/page/cart/widget/total_settlement.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/component/back_to_top.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/cart/widget/goods_list.dart';
import 'package:jd_mall_flutter/component/loading_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  static const String name = "/cart";

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(onInit: (store) {
      store.dispatch(InitAction());
    }, builder: (context, store) {
      bool isLoading = store.state.cartPageState.isLoading;
      if (isLoading) return loadingWidget(context);

      return Column(
        children: [
          cartHeader(context),
          Expanded(
            child: Scaffold(
              backgroundColor: CommonStyle.colorF3F3F3,
              body: SmartRefresher(
                controller: _refreshController,
                enablePullUp: true,
                header: const ClassicHeader(
                  spacing: 10,
                  height: 58,
                ),
                onRefresh: () async {
                  store.dispatch(RefreshAction(() => refreshSuccess(_refreshController), () => refreshFail(_refreshController)));
                },
                onLoading: () async {
                  store.dispatch(LoadMoreAction(store.state.cartPageState.pageNum + 1, () => loadMoreSuccess(_refreshController),
                      () => loadMoreFail(_refreshController)));
                },
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    condition(context),
                    cartGoods(context),
                    probablyLikeImage(context),
                    goodsList(context),
                  ],
                ),
              ),
              floatingActionButton: BackToTop(_scrollController),
            ),
          ),
          totalSettlement(context)
        ],
      );
    });
  }
}
