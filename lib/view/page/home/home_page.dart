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
import 'package:jd_mall_flutter/component/loading_widget.dart';
import 'package:jd_mall_flutter/component/page_goods_list.dart';
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
              body: Consumer<HomeProvider>(
                builder: (context, provider, child) {
                  var tabs = provider.homePageInfo.tabList ?? [];
                  String currentTab = provider.currentTab;

                  return PageView(
                    controller: pageController,
                    onPageChanged: (index) {
                      if (provider.isTabClick) return;
                      provider.changeCurrentTab(tabs[index].code!);
                    },
                    children: tabs.map((e) => KeepAliveWrapper(child: PageGoodsList("home_tab_${e.code!}", currentTab, physics))).toList(),
                  );
                }
              ),
            ),
            floatingActionButton: Consumer<HomeProvider>(
              builder: (context, provider, child) {
                return backTop(provider.showBackTop, scrollController);
              }
            ),
          );
        },
      ),
    );
  }

  bool onPageScroll(BuildContext context, ScrollNotification notification) {
    int depth = notification.depth;
    double distance = notification.metrics.pixels;
    if (depth == 0) {
      context.read<HomeProvider>().recordPageY(distance);
    }
    if (depth == 2) {
      context.read<HomeProvider>().setShowBackTop(distance > getScreenHeight());
    }
    return false;
  }
}
