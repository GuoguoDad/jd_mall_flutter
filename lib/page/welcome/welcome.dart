import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/widget/image/asset_image.dart';
import 'package:jd_mall_flutter/page/welcome/widget/goods_list.dart';
import 'package:jd_mall_flutter/page/welcome/widget/tab_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:jd_mall_flutter/page/welcome/widget/adv_img.dart';
import 'package:jd_mall_flutter/page/welcome/widget/gallery_list.dart';
import 'package:jd_mall_flutter/page/welcome/widget/menu_slider.dart';
import 'package:jd_mall_flutter/page/welcome/widget/search_header.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_action.dart';
import 'package:jd_mall_flutter/redux/app_state.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  static const String name = "/welcome";

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController();

  void refreshSuccess() {
    _refreshController.refreshCompleted();
    _refreshController.resetNoData();
  }

  void refreshFail() {
    _refreshController.refreshFailed();
    _refreshController.resetNoData();
  }

  void loadMoreSuccess() {
    _refreshController.loadComplete();
  }

  void loadMoreFail() {
    _refreshController.loadNoData();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(onInit: (store) {
      store.dispatch(InitDataAction());
    }, builder: (context, store) {
      Widget back2Top = Visibility(
          visible: _scrollController.hasClients && _scrollController.offset > MediaQuery.of(context).size.height,
          child: SizedBox(
              width: 48,
              height: 48,
              child: FloatingActionButton(
                onPressed: () {
                  _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInCubic);
                },
                backgroundColor: Colors.white,
                child: assetImage('images/ic_back_top.png', 32, 32),
              )));

      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            // depth 0 表示child包裹的第一个Widget
            if (notification.depth == 0) {
              double distance = notification.metrics.pixels;
              store.dispatch(ChangePageScrollYAction(distance));
            }
            return false;
          },
          child: Scaffold(
            body: SmartRefresher(
              controller: _refreshController,
              enablePullUp: true,
              onRefresh: () async {
                store.dispatch(RefreshAction(refreshSuccess, refreshFail));
              },
              onLoading: () async {
                store.dispatch(LoadMoreAction(store.state.welPageState.pageNum + 1, loadMoreSuccess, loadMoreFail));
              },
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  searchHeader(context),
                  galleryList(context),
                  advBanner(context),
                  menuSlider(context),
                  tabList(context),
                  goodsList(context),
                ],
              ),
            ),
            floatingActionButton: back2Top,
          ));
    });
  }
}
