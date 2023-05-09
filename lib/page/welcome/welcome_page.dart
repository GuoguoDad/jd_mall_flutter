import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/util/color_util.dart';
import 'package:jd_mall_flutter/common/widget/persistentHeader/sliver_header_builder.dart';
import 'package:jd_mall_flutter/page/welcome/widget/adv_img.dart';
import 'package:jd_mall_flutter/page/welcome/widget/gallery_list.dart';
import 'package:jd_mall_flutter/page/welcome/widget/menu_slider.dart';
import 'package:jd_mall_flutter/page/welcome/widget/search_header.dart';
import 'package:jd_mall_flutter/redux/action/wel_page_action.dart';
import 'package:jd_mall_flutter/redux/app_state.dart';
import 'package:jd_mall_flutter/redux/state/wel_page_state.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  static const String name = "/welcome";

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return
      StoreBuilder<AppState>(
        builder: (context, store) {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              // depth 0 表示child包裹的第一个Widget
              if(notification.depth == 0) {
                double distance = notification.metrics.pixels;
                // print('=======distance:${distance}');
                store.dispatch(ChangePageScrollYAction(distance));
              }
              return false;
            },
            child: StoreConnector<AppState, WelPageState>(
                converter: (store) {
                return store.state.welPageState;
              },
              builder: (context, state) {
                return  Container(
                  color: ColorUtil( state.pageScrollY <= 44 ? '#FE0F22' : '#FFFFFF'),
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
                          height: 50,
                          child: buildHeader(2),
                        ),
                      ),
                      buildSliverList(20),
                    ],
                  ),
                );
              }
            )
          );
        }
      );
  }


// 构建固定高度的SliverList，count为列表项属相
  Widget buildSliverList([int count = 5]) {
    return SliverFixedExtentList(
      itemExtent: 50,
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return Container(
            color: Colors.white,
            child: ListTile(title: Text('$index')),
          );
        },
        childCount: count,
      ),
    );
  }


  // 构建 header
  Widget buildHeader(int i) {
    return Container(
      color: ColorUtil('#F5F5F4'),
      child: Text("PersistentHeader $i"),
    );
  }
}