import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/info_header.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/order_card.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/single_line_menu.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/mine/redux/mine_page_action.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/tab_list.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/common/util/easy_refresh_util.dart';
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';
import 'package:jd_mall_flutter/component/page_goods_list.dart';
import 'package:jd_mall_flutter/component/back_top.dart';
import 'package:jd_mall_flutter/component/skeleton/loading_skeleton.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  static const String name = "/mine";

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  EasyRefreshController freshController = EasyRefreshController(controlFinishRefresh: true);
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();

  bool isTabClick = false;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(onInit: (store) {
      store.dispatch(InitPageAction());
    }, builder: (context, store) {
      List<TabInfo> tabs = store.state.minePageState.menuTabInfo.tabList ?? [];
      bool showTop = store.state.minePageState.showBackTop;
      bool isLoading = store.state.minePageState.isLoading;

      if (isLoading) return loadingSkeleton(context);

      return Scaffold(
          body: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                double distance = notification.metrics.pixels;
                if (notification.depth == 0) {
                  store.dispatch(ChangePageScrollYAction(distance));
                }
                if (notification.depth == 2) {
                  store.dispatch(ChangeBackTopAction(distance > getScreenHeight(context)));
                }
                return false;
              },
              child: EasyRefresh.builder(
                  controller: freshController,
                  header: classicHeader,
                  onRefresh: () async {
                    store.dispatch(RefreshAction(() => easyRefreshSuccess(freshController), () => easyRefreshFail(freshController)));
                  },
                  childBuilder: (context, physics) {
                    return NestedScrollView(
                      controller: _scrollController,
                      physics: physics,
                      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                        return [
                          const HeaderLocator.sliver(clearExtent: false),
                          infoHeader(context),
                          SliverList(
                            delegate: SliverChildListDelegate([orderCard(context), singleLineMenu(context)]),
                          ),
                          tabList(context, onTabChange: (code) => handleTabChange(store, code, tabs))
                        ];
                      },
                      body: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          if (isTabClick) return;
                          store.dispatch(SetCurrentTab(tabs[index].code!));
                        },
                        children: tabs.map((e) => PageGoodsList(e.code!, physics)).toList(),
                      ),
                    );
                  })),
          floatingActionButton: backTop(showTop, _scrollController));
    });
  }

  void handleTabChange(Store<AppState> store, String code, List<TabInfo> tabs) {
    isTabClick = true;
    store.dispatch(SetCurrentTab(code));

    int tabIndex = tabs.indexWhere((element) => element.code == code);
    _pageController
        .animateToPage(tabIndex, duration: const Duration(milliseconds: 200), curve: Curves.linear)
        .then((value) => isTabClick = false);
  }
}
