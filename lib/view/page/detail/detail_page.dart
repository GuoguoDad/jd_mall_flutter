// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_extended_scroll/flutter_extended_scroll.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_provider.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/appraise_info.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/back_to_top.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/detail_card.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/fixed_bottom.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/goods_info.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/store_goods.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/store_goods_header.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/tab_header.dart';
import 'package:jd_mall_flutter/view/page/home/util.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  final ExtendedScrollController scrollController = ExtendedScrollController();
  final RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DetailProvider>().initPageData();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return pageContainer(
      context,
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) => onPageScroll(context, notification),
          child: Container(
            color: CommonStyle.colorF5F5F5,
            child: SmartRefresher(
              controller: refreshController,
              enablePullUp: true,
              enablePullDown: false,
              onLoading: () => context.read<DetailProvider>().loadNextPage(
                () => loadMoreSuccess(refreshController),
                () => loadMoreFail(refreshController),
              ),
              child: ExtendedCustomScrollView(
                controller: scrollController,
                slivers: [
                  GoodsInfo(),
                  AppraiseList(),
                  DetailImgList(),
                  StoreGoodsHeader(),
                  StoreGoodsList(),
                ],
              ),
            ),
          ),
        ),
        Positioned(top: 0, left: 0, child: TabHeader(scrollController))
      ],
    );
  }

  bool onPageScroll(BuildContext context, ScrollNotification notification) {
    if (notification.depth == 1) {
      context.read<DetailProvider>().recordPageY(notification.metrics.pixels);

      //监听滚动，选中对应的tab
      if (context.read<DetailProvider>().isTabClick) return false;
      int newIndex = findFirstVisibleItemIndex(cardKeys);
      context.read<DetailProvider>().setIndex(newIndex);
    }
    return false;
  }

  //页面框架
  Widget pageContainer(BuildContext context, {required List<Widget> children}) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Scaffold(
              body: Stack(
                children: children,
              ),
              floatingActionButton: BackToTop(scrollController),
            ),
          ),
          fixedBottom(context)
        ],
      ),
    );
  }

  //找到当前页面第一个可见的item的索引
  int findFirstVisibleItemIndex(List<GlobalKey<State<StatefulWidget>>> cardKeys) {
    int i = 0;
    for (; i < cardKeys.length; i++) {
      RenderSliverToBoxAdapter? keyRenderObject = cardKeys[i].currentContext?.findAncestorRenderObjectOfType<RenderSliverToBoxAdapter>();
      if (keyRenderObject != null) {
        //距离CustomScrollView顶部距离， 上滚出可视区域变为0
        final dy = (keyRenderObject.parentData as SliverPhysicalParentData).paintOffset.dy;
        if (dy > 42 + getStatusHeight()) {
          break;
        }
      }
    }
    final newIndex = i == 0 ? 0 : i - 1;
    return newIndex;
  }
}
