import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/widget/persistentHeader/sliver_header_builder.dart';
import 'package:jd_mall_flutter/page/welcome/widget/search_header.dart';
import 'package:jd_mall_flutter/redux/action/wel_page_action.dart';
import 'package:jd_mall_flutter/redux/app_state.dart';

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
                  double distance = notification.metrics.pixels;

                  store.dispatch(ChangePageScrollYAction(distance));
                  return false;
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
                    buildSliverList(5),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverHeaderDelegate.fixedHeight( //固定高度
                        height: 50,
                        child: buildHeader(2),
                      ),
                    ),
                    buildSliverList(20),
                  ],
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
          return ListTile(title: Text('$index'));
        },
        childCount: count,
      ),
    );
  }


  // 构建 header
  Widget buildHeader(int i) {
    return Container(
      color: Colors.red,
      child: Text("PersistentHeader $i"),
    );
  }
}