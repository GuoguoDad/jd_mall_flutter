// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_refresh/easy_refresh.dart';
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
import 'package:jd_mall_flutter/models/home_page_info.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/home/redux/home_page_action.dart';
import 'package:jd_mall_flutter/view/page/home/widget/adv_img.dart';
import 'package:jd_mall_flutter/view/page/home/widget/gallery_list.dart';
import 'package:jd_mall_flutter/view/page/home/widget/menu_slider.dart';
import 'package:jd_mall_flutter/view/page/home/widget/search_header.dart';
import 'package:jd_mall_flutter/view/page/home/widget/tab_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String name = "/homePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final EasyRefreshController _freshController;
  late final ScrollController _scrollController;
  late final PageController _pageController;

  bool isTabClick = false;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      onInit: (store) {
        store.dispatch(InitDataAction());
      },
      builder: (context, store) {
        List<TabList> tabs = store.state.homePageState.homePageInfo.tabList ?? [];
        bool showTop = store.state.homePageState.showBackTop;
        bool isLoading = store.state.homePageState.isLoading;

        if (isLoading) return loadingWidget(context);

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            int depth = notification.depth;
            double distance = notification.metrics.pixels;
            if (depth == 0) {
              store.dispatch(ChangePageScrollYAction(distance));
            }
            if (depth == 2) {
              store.dispatch(ChangeBackTopAction(distance > getScreenHeight(context)));
            }
            return false;
          },
          child: EasyRefresh.builder(
            controller: _freshController,
            header: classicHeader,
            clipBehavior: Clip.none,
            onRefresh: () async => store.dispatch(RefreshAction(() => easyRefreshSuccess(_freshController), () => easyRefreshFail(_freshController))),
            childBuilder: (context, physics) {
              return Scaffold(
                body: NestedScrollView(
                  controller: _scrollController,
                  physics: physics,
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      const HeaderLocator.sliver(clearExtent: false),
                      searchHeader(context),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          galleryList(context),
                          advBanner(context),
                          menuSlider(context),
                        ]),
                      ),
                      tabList(
                        context,
                        onTabChange: (code) => handleTabChange(store, code, tabs),
                      )
                    ];
                  },
                  body: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      if (isTabClick) return;
                      store.dispatch(SetCurrentTab(tabs[index].code!));
                    },
                    children: tabs.map((e) => KeepAliveWrapper(child: PageGoodsList("home_tab_${e.code!}", physics))).toList(),
                  ),
                ),
                floatingActionButton: backTop(showTop, _scrollController),
              );
            },
          ),
        );
      },
    );
  }

  void handleTabChange(Store<AppState> store, String code, List<TabList> tabs) {
    isTabClick = true;
    store.dispatch(SetCurrentTab(code));

    int tabIndex = tabs.indexWhere((element) => element.code == code);
    _pageController.animateToPage(tabIndex, duration: const Duration(milliseconds: 200), curve: Curves.linear).then((value) => isTabClick = false);
  }
}
