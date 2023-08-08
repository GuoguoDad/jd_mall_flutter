// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_refresh/easy_refresh.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/easy_refresh_util.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/back_top.dart';
import 'package:jd_mall_flutter/component/keep_alive_wrapper.dart';
import 'package:jd_mall_flutter/component/loading_widget.dart';
import 'package:jd_mall_flutter/component/page_goods_list.dart';
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/mine/redux/mine_page_action.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/info_header.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/order_card.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/single_line_menu.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/tab_list.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  static const String name = "/mine";

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  late final EasyRefreshController _freshController;
  late final ScrollController _scrollController;
  late final PageController _pageController;

  bool isTabClick = false;
  final ValueNotifier<bool> _showBackTop = ValueNotifier<bool>(false);
  final ValueNotifier<double> _pageScrollY = ValueNotifier<double>(0);

  @override
  void initState() {
    _freshController = EasyRefreshController(controlFinishRefresh: true);
    _scrollController = ScrollController();
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _freshController.dispose();
    _scrollController.dispose();
    _pageController.dispose();
    _showBackTop.dispose();
    _pageScrollY.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double statusHeight = getStatusHeight(context);

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        double distance = notification.metrics.pixels;
        if (notification.depth == 0) {
          _pageScrollY.value = distance;
        }
        if (notification.depth == 2) {
          _showBackTop.value = distance > getScreenHeight(context);
        }
        return false;
      },
      child: StoreBuilder<AppState>(
        onInit: (store) {
          store.dispatch(InitPageAction());
        },
        builder: (context, store) {
          List<TabInfo> tabs = store.state.minePageState.menuTabInfo.tabList ?? [];
          String currentTab = store.state.minePageState.currentTab;
          bool isLoading = store.state.minePageState.isLoading;

          if (isLoading) return loadingWidget(context);

          return EasyRefresh.builder(
            controller: _freshController,
            header: classicHeader,
            onRefresh: () async {
              store.dispatch(RefreshAction(() => easyRefreshSuccess(_freshController), () => easyRefreshFail(_freshController)));
            },
            childBuilder: (context, physics) {
              return Scaffold(
                body: ExtendedNestedScrollView(
                  controller: _scrollController,
                  pinnedHeaderSliverHeightBuilder: () {
                    return statusHeight + 48 + 54;
                  },
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      const HeaderLocator.sliver(clearExtent: false),
                      infoHeader(context, _pageScrollY),
                      orderCard(context),
                      singleLineMenu(context),
                      tabList(context, onTabChange: (code) => handleTabChange(store, code, tabs))
                    ];
                  },
                  onlyOneScrollInBody: true,
                  body: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      if (isTabClick) return;
                      store.dispatch(SetCurrentTab(tabs[index].code!));
                    },
                    children: tabs.map((e) => KeepAliveWrapper(child: PageGoodsList("mine_tab_${e.code!}", currentTab, physics))).toList(),
                  ),
                ),
                floatingActionButton: ValueListenableBuilder<bool>(
                  builder: (BuildContext context, bool value, Widget? child) {
                    return backTop(value, _scrollController);
                  },
                  valueListenable: _showBackTop,
                ),
              );
            },
          );
        },
      ),
    );
  }

  void handleTabChange(Store<AppState> store, String code, List<TabInfo> tabs) {
    isTabClick = true;
    store.dispatch(SetCurrentTab(code));

    int tabIndex = tabs.indexWhere((element) => element.code == code);
    _pageController.animateToPage(tabIndex, duration: const Duration(milliseconds: 200), curve: Curves.linear).then((value) => isTabClick = false);
  }
}
