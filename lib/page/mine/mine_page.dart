import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/page/mine/widget/info_header.dart';
import 'package:jd_mall_flutter/page/mine/widget/order-card.dart';
import 'package:jd_mall_flutter/page/mine/widget/single_line_menu.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/common/widget/back_to_top.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/page/mine/redux/mine_page_action.dart';
import 'package:jd_mall_flutter/page/mine/widget/tab_list.dart';
import 'package:jd_mall_flutter/page/mine/widget/goods_list.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  static const String name = "/mine";

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(onInit: (store) {
      store.dispatch(InitPageAction());
    }, builder: (context, store) {
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification.depth == 0) {
              double distance = notification.metrics.pixels;
              store.dispatch(ChangePageScrollYAction(distance));
            }
            return false;
          },
          child: Container(
              color: CommonStyle.colorF5F5F5,
              child: Scaffold(
                body: SmartRefresher(
                  controller: _refreshController,
                  enablePullUp: true,
                  onRefresh: () async {
                    store.dispatch(RefreshAction(() => refreshSuccess(_refreshController), () => refreshFail(_refreshController)));
                  },
                  onLoading: () async {
                    store.dispatch(LoadMoreAction(store.state.minePageState.pageNum + 1, () => loadMoreSuccess(_refreshController),
                        () => loadMoreFail(_refreshController)));
                  },
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [infoHeader(context), orderCard(context), singleLineMenu(context), tabList(context), goodsList(context)],
                  ),
                ),
                floatingActionButton: BackToTop(_scrollController),
              )));
    });
  }
}
