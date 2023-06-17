import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/view/page/home/widget/back_top.dart';
import 'package:jd_mall_flutter/view/page/home/widget/tab_list.dart';
import 'package:jd_mall_flutter/view/page/home/widget/adv_img.dart';
import 'package:jd_mall_flutter/view/page/home/widget/gallery_list.dart';
import 'package:jd_mall_flutter/view/page/home/widget/menu_slider.dart';
import 'package:jd_mall_flutter/view/page/home/widget/search_header.dart';
import 'package:jd_mall_flutter/view/page/home/redux/home_page_action.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/models/home_page_info.dart';
import 'package:jd_mall_flutter/view/page/home/widget/page_goods_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String name = "/welcome";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EasyRefreshController easyRefreshController = EasyRefreshController(controlFinishRefresh: true);
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(onInit: (store) {
      store.dispatch(InitDataAction());
    }, builder: (context, store) {
      List<TabList> tabs = store.state.homePageState.homePageInfo.tabList ?? [];

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
                controller: easyRefreshController,
                header: const ClassicHeader(
                  clamping: true,
                  position: IndicatorPosition.locator,
                  mainAxisAlignment: MainAxisAlignment.end,
                  dragText: 'Pull to refresh',
                  armedText: 'Release ready',
                  readyText: 'Refreshing...',
                  processingText: 'Refreshing...',
                  processedText: 'Succeeded',
                  noMoreText: 'No more',
                  failedText: 'Failed',
                  messageText: 'Last updated at %T',
                ),
                onRefresh: () async {
                  store.dispatch(
                      RefreshAction(() => easyRefreshSuccess(easyRefreshController), () => easyRefreshFail(easyRefreshController)));
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
                          delegate: SliverChildListDelegate([galleryList(context), advBanner(context), menuSlider(context)]),
                        ),
                        tabList(context, onTabChange: (code) {
                          int tabIndex = tabs.indexWhere((element) => element.code == code);
                          _pageController.animateToPage(tabIndex, duration: const Duration(milliseconds: 200), curve: Curves.linear);
                        })
                      ];
                    },
                    body: PageView(
                      controller: _pageController,
                      onPageChanged: (index) => store.dispatch(SetCurrentTab(tabs[index].code!)),
                      children: tabs.map((e) => PageGoodsList(e.code!, physics)).toList(),
                    ),
                  );
                }),
          ),
          floatingActionButton: backTop(context,
              onTop: () => _scrollController.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.linear)));
    });
  }
}
