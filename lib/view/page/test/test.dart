import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/widget/persistentHeader/sliver_header_builder.dart';

import 'package:jd_mall_flutter/view/page/test/widget/search_header.dart';

import 'package:jd_mall_flutter/view/page/test/widget/adv_img.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  static const String name = "/test";

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              searchHeader(context),
              SliverList(
                delegate: SliverChildListDelegate([advBanner(context)]),
              ),
              SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverHeaderDelegate.fixedHeight(
                      //固定高度
                      height: 58,
                      child: Container(
                        color: Colors.grey,
                        child: TabBar(
                          labelColor: Colors.black,
                          controller: _tabController,
                          tabs: const [
                            Tab(
                              text: '资讯',
                            ),
                            Tab(
                              text: '技术',
                            ),
                          ],
                        ),
                      )))
            ];
          },
          body: TabBarView(controller: _tabController, children: [_buildTabNewsList('----技术类----'), _buildTabNewsList('----技术类----')])),
    );
  }
}

//构建newstlist列表
_buildTabNewsList(String name) {
  return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (context, int index) {
        return Column(
          children: [
            Text(
              '$name $index 通过scrollDirection和reverse参数控制其滚动方向，用法如下：',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '作者 csdn账号 ',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: 50);
}
