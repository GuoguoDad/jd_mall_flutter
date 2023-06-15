import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/view/page/home/widget/goods_list.dart';
import 'package:jd_mall_flutter/view/page/home/widget/tab_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:jd_mall_flutter/view/page/home/widget/adv_img.dart';
import 'package:jd_mall_flutter/view/page/home/widget/gallery_list.dart';
import 'package:jd_mall_flutter/view/page/home/widget/menu_slider.dart';
import 'package:jd_mall_flutter/view/page/home/widget/search_header.dart';
import 'package:jd_mall_flutter/view/page/home/redux/home_page_action.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/common/widget/back_to_top.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String name = "/welcome";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(onInit: (store) {
      store.dispatch(InitDataAction());
    }, builder: (context, store) {
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
                store.dispatch(RefreshAction(() => refreshSuccess(_refreshController), () => refreshFail(_refreshController)));
              },
              onLoading: () async {
                store.dispatch(LoadMoreAction(store.state.homePageState.pageNum + 1, () => loadMoreSuccess(_refreshController),
                    () => loadMoreFail(_refreshController)));
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
            floatingActionButton: BackToTop(_scrollController),
          ));
    });
  }
}
