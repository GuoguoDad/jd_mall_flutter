import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/page/welcome/widget/goods_list.dart';
import 'package:jd_mall_flutter/page/welcome/widget/tab_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:jd_mall_flutter/common/widget/persistentHeader/sliver_header_builder.dart';
import 'package:jd_mall_flutter/page/welcome/widget/adv_img.dart';
import 'package:jd_mall_flutter/page/welcome/widget/gallery_list.dart';
import 'package:jd_mall_flutter/page/welcome/widget/menu_slider.dart';
import 'package:jd_mall_flutter/page/welcome/widget/search_header.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_action.dart';
import 'package:jd_mall_flutter/redux/app_state.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_state.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  static const String name = "/welcome";

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return
      StoreBuilder<AppState>(
        onInit:  (store){
          store.dispatch(LoadAction(true));
        },
        builder: (context, store) {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              // depth 0 表示child包裹的第一个Widget
              if(notification.depth == 0) {
                double distance = notification.metrics.pixels;
                store.dispatch(ChangePageScrollYAction(distance));
              }
              return false;
            },
            child: StoreConnector<AppState, WelPageState>(
                converter: (store) {
                return store.state.welPageState;
              },
              builder: (context, state) {
                return
                  SmartRefresher(
                    controller: _refreshController,
                    enablePullUp: true,
                    onRefresh: () async {
                      await Future.delayed(const Duration(milliseconds: 500));
                      // _refreshController.refreshFailed();
                      _refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await Future.delayed(const Duration(milliseconds: 500));
                      // _refreshController.loadComplete();
                      _refreshController.loadNoData();
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: SliverHeaderDelegate(//有最大和最小高度
                            maxHeight: 88 + MediaQueryData.fromWindow(window).padding.top,
                            minHeight: 44 + MediaQueryData.fromWindow(window).padding.top,
                            child: searchHeader(context),
                          ),
                        ),
                        galleryList(context),
                        advBanner(context),
                        menuSlider(context),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: SliverHeaderDelegate.fixedHeight( //固定高度
                            height: 58,
                            child: tabList(context),
                          ),
                        ),
                        goodsList(context),
                      ],
                    ),
                );
              }
            )
          );
        }
      );
  }
}