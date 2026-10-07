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
// 加前缀避免与 widget TabList 同名冲突
import 'package:jd_mall_flutter/models/home_page_info.dart' as model;
import 'package:jd_mall_flutter/view/page/home/home_provider.dart';
import 'package:jd_mall_flutter/view/page/home/widget/adv_img.dart';
import 'package:jd_mall_flutter/view/page/home/widget/gallery_list.dart';
import 'package:jd_mall_flutter/view/page/home/widget/menu_slider.dart';
import 'package:jd_mall_flutter/view/page/home/widget/search_header.dart';
import 'package:jd_mall_flutter/view/page/home/widget/tab_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final EasyRefreshController freshController = EasyRefreshController(controlFinishRefresh: true);
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().initPageData();
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
        onRefresh: () => context.read<HomeProvider>().refreshPage(
          () => easyRefreshSuccess(freshController),
          () => easyRefreshFail(freshController),
        ),
        childBuilder: (context, physics) {
          return Scaffold(
            body: ExtendedNestedScrollView(
              controller: scrollController,
              pinnedHeaderSliverHeightBuilder: () {
                return getStatusHeight() + 44 + 54;
              },
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  const HeaderLocator.sliver(clearExtent: false),
                  SearchHeader(),
                  GalleryList(),
                  AdvBanner(),
                  MenuSlider(),
                  TabList(pageController),
                ];
              },
              onlyOneScrollInBody: true,
              // 只在 tab 数据 / 当前 tab 变化时重建，避免滚动时重建全部商品列表
              body: Selector<HomeProvider, ({String currentTab, List<model.TabList> tabs})>(
                selector: (context, provider) => (
                  currentTab: provider.currentTab,
                  tabs: provider.homePageInfo.tabList ?? const <model.TabList>[],
                ),
                shouldRebuild: (prev, next) => prev.currentTab != next.currentTab || !identical(prev.tabs, next.tabs),
                builder: (context, data, child) {
                  return PageView(
                    controller: pageController,
                    onPageChanged: (index) {
                      final provider = context.read<HomeProvider>();
                      if (provider.isTabClick) return;
                      provider.changeCurrentTab(data.tabs[index].code!);
                    },
                    children: data.tabs
                        .map((e) => KeepAliveWrapper(child: PageGoodsList("home_tab_${e.code!}", data.currentTab, physics)))
                        .toList(),
                  );
                },
              ),
            ),
            floatingActionButton: Selector<HomeProvider, bool>(
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
    int depth = notification.depth;
    double distance = notification.metrics.pixels;
    if (depth == 0) {
      context.read<HomeProvider>().recordPageY(distance);
    }
    if (depth == 2) {
      context.read<HomeProvider>().setShowBackTop(distance > screenHeight);
    }
    return false;
  }
}
