// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_refresh/easy_refresh.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/easy_refresh_util.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/back_top.dart';
import 'package:jd_mall_flutter/component/keep_alive_wrapper.dart';
import 'package:jd_mall_flutter/component/loading_widget.dart';
import 'package:jd_mall_flutter/component/page_goods_list.dart';
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';
import 'package:jd_mall_flutter/view/page/mine/mine_controller.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/info_header.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/order_card.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/single_line_menu.dart';
import 'package:jd_mall_flutter/view/page/mine/widget/tab_list.dart';

class MinePage extends StatelessWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) => onPageScroll(notification),
      child: EasyRefresh.builder(
        controller: MineController.to.freshController,
        header: classicHeader,
        onRefresh: () => MineController.to.refreshPage(
          () => easyRefreshSuccess(MineController.to.freshController),
          () => easyRefreshFail(MineController.to.freshController),
        ),
        childBuilder: (context, physics) {
          return Scaffold(
            body: ExtendedNestedScrollView(
              controller: MineController.to.scrollController,
              pinnedHeaderSliverHeightBuilder: () {
                return getStatusHeight() + 48 + 54;
              },
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  const HeaderLocator.sliver(clearExtent: false),
                  infoHeader(),
                  orderCard(),
                  singleLineMenu(),
                  tabList(),
                ];
              },
              onlyOneScrollInBody: true,
              body: Obx(() {
                List<TabInfo> tabs = MineController.to.menuTabInfo.value.tabList ?? [];
                String currentTab = MineController.to.currentTab.value;

                return PageView(
                  controller: MineController.to.pageController,
                  onPageChanged: (index) {
                    if (MineController.to.isTabClick.value) return;
                    MineController.to.changeCurrentTab(tabs[index].code!);
                  },
                  children: tabs.map((e) => KeepAliveWrapper(child: PageGoodsList("mine_tab_${e.code!}", currentTab, physics))).toList(),
                );
              }),
            ),
            floatingActionButton: Obx(() => backTop(MineController.to.showBackTop.value, MineController.to.scrollController)),
          );
        },
      ),
    );
  }

  bool onPageScroll(ScrollNotification notification) {
    double distance = notification.metrics.pixels;
    if (notification.depth == 0) {
      MineController.to.recordPageY(distance);
    }
    if (notification.depth == 2) {
      MineController.to.setShowBackTop(distance > getScreenHeight());
    }
    return false;
  }
}
