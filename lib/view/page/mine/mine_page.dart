// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_refresh/easy_refresh.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/easy_refresh_util.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/back_top.dart';
import 'package:jd_mall_flutter/component/keep_alive_wrapper.dart';
import 'package:jd_mall_flutter/component/loading_widget.dart';
import 'package:jd_mall_flutter/component/page_goods_list.dart';
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';
import 'package:jd_mall_flutter/view/page/mine/mine_provider.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/info_header.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/order_card.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/single_line_menu.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/tab_list.dart';
import 'package:provider/provider.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => MinePageState();
}

class MinePageState extends State<MinePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MineProvider>().initPageData();
    });
  }

  @override
  void dispose() {
    context.read<MineProvider>().freshController.dispose();
    context.read<MineProvider>().scrollController.dispose();
    context.read<MineProvider>().pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) => onPageScroll(context, notification),
      child: EasyRefresh.builder(
        controller: context.read<MineProvider>().freshController,
        header: classicHeader,
        onRefresh: () => context.read<MineProvider>().refreshPage(
          () => easyRefreshSuccess(context.read<MineProvider>().freshController),
          () => easyRefreshFail(context.read<MineProvider>().freshController),
        ),
        childBuilder: (context, physics) {
          return Scaffold(
            body: ExtendedNestedScrollView(
              controller: context.read<MineProvider>().scrollController,
              pinnedHeaderSliverHeightBuilder: () {
                return getStatusHeight() + 48 + 54;
              },
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  const HeaderLocator.sliver(clearExtent: false),
                  InfoHeader(),
                  OrderCard(),
                  SingleLineMenu(),
                  TabList(),
                ];
              },
              onlyOneScrollInBody: true,
              body: Consumer<MineProvider>(
                builder: (context, provider, child) {
                  List<TabInfo> tabs = provider.menuTabInfo.tabList ?? [];
                  String currentTab = provider.currentTab;

                  return PageView(
                    controller: provider.pageController,
                    onPageChanged: (index) {
                      if (provider.isTabClick) return;
                      provider.changeCurrentTab(tabs[index].code!);
                    },
                    children: tabs.map((e) => KeepAliveWrapper(child: PageGoodsList("mine_tab_${e.code!}", currentTab, physics))).toList(),
                  );
                }
              ),
            ),
            floatingActionButton: Consumer<MineProvider>(
              builder: (context, provider, child) {
                return backTop(provider.showBackTop, provider.scrollController);
              }
            ),
          );
        },
      ),
    );
  }

  bool onPageScroll(BuildContext context, ScrollNotification notification) {
    double distance = notification.metrics.pixels;
    if (notification.depth == 0) {
      context.read<MineProvider>().recordPageY(distance);
    }
    if (notification.depth == 2) {
      context.read<MineProvider>().setShowBackTop(distance > getScreenHeight());
    }
    return false;
  }
}
