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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController c = Get.put(HomeController());
  late final EasyRefreshController _freshController;
  late final ScrollController _scrollController;
  late final PageController _pageController;

  bool isTabClick = false;
  final ValueNotifier<bool> _showBackTop = ValueNotifier<bool>(false);
  final ValueNotifier<double> _pageScrollY = ValueNotifier<double>(0);
  final ValueNotifier<String> _currentTab = ValueNotifier<String>("");

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
    _currentTab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double statusHeight = getStatusHeight(context);

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        int depth = notification.depth;
        double distance = notification.metrics.pixels;
        if (depth == 0) {
          _pageScrollY.value = distance;
        }
        if (depth == 2) {
          _showBackTop.value = distance > getScreenHeight(context);
        }
        return false;
      },
      child: EasyRefresh.builder(
        controller: _freshController,
        header: classicHeader,
        clipBehavior: Clip.none,
        onRefresh: () => c.refreshPage(() => easyRefreshSuccess(_freshController), () => easyRefreshFail(_freshController)),
        childBuilder: (context, physics) {
          return Scaffold(
            body: ExtendedNestedScrollView(
              controller: _scrollController,
              pinnedHeaderSliverHeightBuilder: () {
                return statusHeight + 44 + 54;
              },
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  const HeaderLocator.sliver(clearExtent: false),
                  searchHeader(context, _pageScrollY),
                  galleryList(context, c),
                  advBanner(context, c),
                  menuSlider(context, c),
                  tabList(context, _currentTab, c, onTabChange: (obj) => handleTabChange(obj))
                ];
              },
              onlyOneScrollInBody: true,
              body: Obx(() {
                var tabs = c.homePageInfo.value.tabList ?? [];
                String currentTab = _currentTab.value.isNotEmpty
                    ? _currentTab.value
                    : tabs.isNotEmpty
                        ? tabs[0].code!
                        : "";
                return PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    if (isTabClick) return;
                    _currentTab.value = tabs[index].code!;
                  },
                  children: tabs.map((e) => KeepAliveWrapper(child: PageGoodsList("home_tab_${e.code!}", currentTab, physics))).toList(),
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
    _currentTab.value = obj["code"];

    int tabIndex = obj["tabs"].indexWhere((element) => element.code == obj["code"]);
    _pageController.animateToPage(tabIndex, duration: const Duration(milliseconds: 200), curve: Curves.linear).then((value) => isTabClick = false);
  }
}
