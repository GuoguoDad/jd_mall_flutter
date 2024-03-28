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
import 'package:jd_mall_flutter/view/page/home/home_controller.dart';
import 'package:jd_mall_flutter/view/page/home/widget/adv_img.dart';
import 'package:jd_mall_flutter/view/page/home/widget/gallery_list.dart';
import 'package:jd_mall_flutter/view/page/home/widget/menu_slider.dart';
import 'package:jd_mall_flutter/view/page/home/widget/search_header.dart';
import 'package:jd_mall_flutter/view/page/home/widget/tab_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) => onPageScroll(notification, context),
      child: EasyRefresh.builder(
        controller: HomeController.to.freshController,
        header: classicHeader,
        clipBehavior: Clip.none,
        onRefresh: () => HomeController.to.refreshPage(
          () => easyRefreshSuccess(HomeController.to.freshController),
          () => easyRefreshFail(HomeController.to.freshController),
        ),
        childBuilder: (context, physics) {
          return Scaffold(
            body: ExtendedNestedScrollView(
              physics: physics,
              controller: HomeController.to.scrollController,
              pinnedHeaderSliverHeightBuilder: () => getStatusHeight(context) + 44 + 54,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  const HeaderLocator.sliver(clearExtent: false),
                  searchHeader(context),
                  galleryList(context),
                  advBanner(context),
                  menuSlider(context),
                  tabList(context)
                ];
              },
              onlyOneScrollInBody: true,
              body: Obx(() {
                var tabs = HomeController.to.homePageInfo.value.tabList ?? [];
                String currentTab = HomeController.to.currentTab.value;

                return PageView(
                  controller: HomeController.to.pageController,
                  onPageChanged: (index) {
                    if (HomeController.to.isTabClick.value) return;
                    HomeController.to.changeCurrentTab(tabs[index].code!);
                  },
                  children: tabs.map((e) => KeepAliveWrapper(child: PageGoodsList("home_tab_${e.code!}", currentTab, physics))).toList(),
                );
              }),
            ),
            floatingActionButton: Obx(() => backTop(HomeController.to.showBackTop.value, HomeController.to.scrollController)),
          );
        },
      ),
    );
  }

  bool onPageScroll(ScrollNotification notification, BuildContext context) {
    int depth = notification.depth;
    double distance = notification.metrics.pixels;
    if (depth == 0) {
      HomeController.to.recordPageY(distance);
    }
    if (depth == 2) {
      HomeController.to.setShowBackTop(distance > getScreenHeight(context));
    }
    return false;
  }
}
