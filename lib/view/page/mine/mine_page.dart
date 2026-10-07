// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_refresh/easy_refresh.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/easy_refresh_util.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/back_top.dart';
import 'package:jd_mall_flutter/component/keep_alive_wrapper.dart';
import 'package:jd_mall_flutter/component/page_goods_list.dart';
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';
import 'package:jd_mall_flutter/view/page/mine/mine_provider.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/info_header.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/order_card.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/single_line_menu.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/tab_list.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => MinePageState();
}

class MinePageState extends State<MinePage> {
  final EasyRefreshController freshController = EasyRefreshController(controlFinishRefresh: true);
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MineProvider>().initPageData();
    });
  }

  @override
  void dispose() {
    freshController.dispose();
    scrollController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) => onPageScroll(context, notification),
      child: EasyRefresh.builder(
        controller: freshController,
        header: classicHeader,
        onRefresh: () => context.read<MineProvider>().refreshPage(
          () => easyRefreshSuccess(freshController),
          () => easyRefreshFail(freshController),
        ),
        childBuilder: (context, physics) {
          return Scaffold(
            body: ExtendedNestedScrollView(
              controller: scrollController,
              pinnedHeaderSliverHeightBuilder: () {
                return getStatusHeight() + 48 + 54;
              },
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  const HeaderLocator.sliver(clearExtent: false),
                  InfoHeader(),
                  OrderCard(),
                  SingleLineMenu(),
                  TabList(pageController),
                ];
              },
              onlyOneScrollInBody: true,
              // 只在 tab 数据 / 当前 tab 变化时重建，避免滚动时重建全部商品列表
              body: Selector<MineProvider, ({String currentTab, List<TabInfo> tabs})>(
                selector: (context, provider) => (
                  currentTab: provider.currentTab,
                  tabs: provider.menuTabInfo.tabList ?? const <TabInfo>[],
                ),
                shouldRebuild: (prev, next) => prev.currentTab != next.currentTab || !identical(prev.tabs, next.tabs),
                builder: (context, data, child) {
                  return PageView(
                    controller: pageController,
                    onPageChanged: (index) {
                      final provider = context.read<MineProvider>();
                      if (provider.isTabClick) return;
                      provider.changeCurrentTab(data.tabs[index].code!);
                    },
                    children: data.tabs
                        .map((e) => KeepAliveWrapper(child: PageGoodsList("mine_tab_${e.code!}", data.currentTab, physics)))
                        .toList(),
                  );
                },
              ),
            ),
            floatingActionButton: Selector<MineProvider, bool>(
              selector: (context, provider) => provider.showBackTop,
              shouldRebuild: (prev, next) => prev != next,
              builder: (context, showBackTop, child) => backTop(showBackTop, scrollController),
            ),
          );
        },
      ),
    );
  }

  // 屏幕高度缓存，避免滚动回调里每帧通过 navigatorContext 做 MediaQuery 查询
  late final double screenHeight = getScreenHeight();

  bool onPageScroll(BuildContext context, ScrollNotification notification) {
    double distance = notification.metrics.pixels;
    if (notification.depth == 0) {
      context.read<MineProvider>().recordPageY(distance);
    }
    if (notification.depth == 2) {
      context.read<MineProvider>().setShowBackTop(distance > screenHeight);
    }
    return false;
  }
}
