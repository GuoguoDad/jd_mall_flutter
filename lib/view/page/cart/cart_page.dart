// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/component/back_to_top.dart';
import 'package:jd_mall_flutter/component/loading_widget.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/cart/redux/cart_page_action.dart';
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
    return StoreBuilder<AppState>(onInit: (store) {
      store.dispatch(InitAction());
    }, builder: (context, store) {
      bool isLoading = store.state.cartPageState.isLoading;

      return Column(
        children: [
          cartHeader(context),
          Expanded(
            child: isLoading
                ? loadingWidget(context)
                : Scaffold(
                    backgroundColor: CommonStyle.colorF3F3F3,
                    body: SmartRefresher(
                      controller: _refreshController,
                      physics: const BouncingScrollPhysics(),
                      enablePullUp: true,
                      header: const ClassicHeader(
                        spacing: 10,
                        height: 58,
                      ),
                      onRefresh: () async {
                        store.dispatch(RefreshAction(() => refreshSuccess(_refreshController), () => refreshFail(_refreshController)));
                      },
                      onLoading: () async {
                        store.dispatch(LoadMoreAction(
                            store.state.cartPageState.pageNum + 1, () => loadMoreSuccess(_refreshController), () => loadMoreFail(_refreshController)));
                      },
                      child: CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          condition(context),
                          cartGoods(context),
                          probablyLike(context),
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
