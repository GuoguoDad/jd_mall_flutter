import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/view/page/home/widget/tab_list.dart';
import 'package:jd_mall_flutter/view/page/home/widget/adv_img.dart';
import 'package:jd_mall_flutter/view/page/home/widget/gallery_list.dart';
import 'package:jd_mall_flutter/view/page/home/widget/menu_slider.dart';
import 'package:jd_mall_flutter/view/page/home/widget/search_header.dart';
import 'package:jd_mall_flutter/view/page/home/redux/home_page_action.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/models/home_page_info.dart';
import 'package:jd_mall_flutter/component/page_goods_list.dart';
import 'package:jd_mall_flutter/common/util/easy_refresh_util.dart';
import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/component/back_top.dart';
import 'package:jd_mall_flutter/component/loading_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String name = "/homePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EasyRefreshController freshController = EasyRefreshController(controlFinishRefresh: true);
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();

  bool isTabClick = false;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(onInit: (store) {
      store.dispatch(InitDataAction());
    }, builder: (context, store) {
      List<TabList> tabs = store.state.homePageState.homePageInfo.tabList ?? [];
      bool showTop = store.state.homePageState.showBackTop;
      bool isLoading = store.state.homePageState.isLoading;

      if (isLoading) return loadingWidget(context);

      return Scaffold(
          body: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              double distance = notification.metrics.pixels;
              if (notification.depth == 0) {
                store.dispatch(ChangePageScrollYAction(distance));
              }
              if (notification.depth == 2) {
                store.dispatch(ChangeBackTopAction(distance > getScreenHeight(context)));
              }
              return false;
            },
            child: EasyRefresh.builder(
                controller: freshController,
                header: classicHeader,
                onRefresh: () async {
                  store.dispatch(RefreshAction(() => easyRefreshSuccess(freshController), () => easyRefreshFail(freshController)));
                },
                childBuilder: (context, physics) {
                  return NestedScrollView(
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
                      children: tabs.map((e) => PageGoodsList(e.code!, physics)).toList(),
                    ),
                  );
                }),
          ),
          floatingActionButton: backTop(showTop, _scrollController));
    });
  }

  void handleTabChange(Store<AppState> store, String code, List<TabList> tabs) {
    isTabClick = true;
    store.dispatch(SetCurrentTab(code));

    int tabIndex = tabs.indexWhere((element) => element.code == code);
    _pageController
        .animateToPage(tabIndex, duration: const Duration(milliseconds: 200), curve: Curves.linear)
        .then((value) => isTabClick = false);
  }
}
