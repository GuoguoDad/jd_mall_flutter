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

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  final MineController c = Get.put(MineController());
  final LoginController loginController = Get.put(LoginController());
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
                  infoHeader(context, _pageScrollY, loginController),
                  orderCard(context),
                  singleLineMenu(context, c),
                  tabList(context, c, onTabChange: (obj) => handleTabChange(obj))
                ];
              },
              onlyOneScrollInBody: true,
              body: Obx(() {
                List<TabInfo> tabs = c.menuTabInfo.value.tabList ?? [];
                String currentTab = c.currentTab.value;

                return PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    if (isTabClick) return;
                    c.changeCurrentTab(tabs[index].code!);
                  },
                  children: tabs.map((e) => KeepAliveWrapper(child: PageGoodsList("mine_tab_${e.code!}", currentTab, physics))).toList(),
                );
              }),
            ),
            floatingActionButton: ValueListenableBuilder<bool>(
              builder: (BuildContext context, bool value, Widget? child) {
                return backTop(value, _scrollController);
              },
              valueListenable: _showBackTop,
            ),
          );
        },
      ),
    );
  }

  void handleTabChange(Map obj) {
    isTabClick = true;
    c.changeCurrentTab(obj["code"]);

    int tabIndex = obj["tabs"].indexWhere((element) => element.code == obj["code"]);
    _pageController.animateToPage(tabIndex, duration: const Duration(milliseconds: 200), curve: Curves.linear).then((value) => isTabClick = false);
  }
}
