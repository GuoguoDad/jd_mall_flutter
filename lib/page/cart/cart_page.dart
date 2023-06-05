import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/page/cart/redux/cart_page_action.dart';
import 'package:jd_mall_flutter/page/cart/widget/cart_goods.dart';
import 'package:jd_mall_flutter/page/cart/widget/cart_header.dart';
import 'package:jd_mall_flutter/page/cart/widget/condition.dart';
import 'package:jd_mall_flutter/page/cart/widget/probably_like.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../common/util/refresh_util.dart';
import '../../common/widget/back_to_top.dart';
import '../../redux/app_state.dart';
import './widget/goods_list.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  static const String name = "/cart";

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController();

  bool show2Top = false;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(onInit: (store) {
      store.dispatch(InitAction());
    }, builder: (context, store) {
      return Column(
        children: [
          Expanded(
            child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  if (notification.depth == 0) {
                    double distance = notification.metrics.pixels;
                    setState(() {
                      show2Top = distance > MediaQuery.of(context).size.height;
                    });
                  }
                  return false;
                },
                child: Scaffold(
                  backgroundColor: CommonStyle.colorF3F3F3,
                  body: SmartRefresher(
                    controller: _refreshController,
                    enablePullUp: true,
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
                        cartHeader(context),
                        condition(context),
                        cartGoods(context),
                        probablyLikeImage(context),
                        goodsList(context)
                      ],
                    ),
                  ),
                  floatingActionButton: BackToTop(
                    show: show2Top,
                    onTap: () {
                      _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInCubic);
                    },
                  ),
                )),
          ),
          Container(
            height: 58,
            color: Colors.grey,
          )
        ],
      );
    });
  }
}
