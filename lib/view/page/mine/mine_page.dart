// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_refresh/easy_refresh.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/easy_refresh_util.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/back_top.dart';
import 'package:jd_mall_flutter/component/keep_alive_wrapper.dart';
import 'package:jd_mall_flutter/component/loading_widget.dart';
import 'package:jd_mall_flutter/component/page_goods_list.dart';
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';
import 'package:jd_mall_flutter/view/page/login/login_controller.dart';
import 'package:jd_mall_flutter/view/page/mine/mine_controller.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/info_header.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/order_card.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/single_line_menu.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/tab_list.dart';

class MinePage extends StatelessWidget {
  MinePage({super.key});

  final MineController c = Get.put(MineController());
  final LoginController lc = Get.put(LoginController());

  late final EasyRefreshController _freshController = EasyRefreshController(controlFinishRefresh: true);
  late final ScrollController _scrollController = ScrollController();
  late final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    double statusHeight = getStatusHeight(context);

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        double distance = notification.metrics.pixels;
        if (notification.depth == 0) {
          c.recordPageY(distance);
        }
        if (notification.depth == 2) {
          c.setShowBackTop(distance > getScreenHeight(context));
        }
        return false;
      },
      child: EasyRefresh.builder(
        controller: _freshController,
        header: classicHeader,
        onRefresh: () => c.refreshPage(() => easyRefreshSuccess(_freshController), () => easyRefreshFail(_freshController)),
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
                  infoHeader(context),
                  orderCard(context),
                  singleLineMenu(context),
                  tabList(context, _pageController)
                ];
              },
              onlyOneScrollInBody: true,
              body: Obx(() {
                List<TabInfo> tabs = c.menuTabInfo.value.tabList ?? [];
                String currentTab = c.currentTab.value;

                return PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    if (c.isTabClick.value) return;
                    c.changeCurrentTab(tabs[index].code!);
                  },
                  children: tabs.map((e) => KeepAliveWrapper(child: PageGoodsList("mine_tab_${e.code!}", currentTab, physics))).toList(),
                );
              }),
            ),
            floatingActionButton: Obx(() => backTop(c.showBackTop.value, _scrollController)),
          );
        },
      ),
    );
  }
}
