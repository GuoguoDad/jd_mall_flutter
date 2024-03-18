// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:extended_scroll/extended_scroll.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_controller.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/appraise_info.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/back_to_top.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/detail_card.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/fixed_bottom.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/goods_info.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/store_goods.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/store_goods_header.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/tab_header.dart';

import '../home/util.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  final DetailController controller = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    //页面框架
    Widget pageContainer({required List<Widget> children}) {
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
                floatingActionButton: BackToTop(controller.scrollController),
              ),
            ),
            fixedBottom(context)
          ],
        ),
      );
    }

    return pageContainer(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification.depth == 1) {
              controller.recordPageY(notification.metrics.pixels);

              //监听滚动，选中对应的tab
              if (controller.isTabClick.value) return false;
              int newIndex = findFirstVisibleItemIndex(cardKeys, context);
              controller.setIndex(newIndex);
            }
            return false;
          },
          child: Container(
            color: CommonStyle.colorF5F5F5,
            child: SmartRefresher(
              controller: controller.refreshController,
              enablePullUp: true,
              enablePullDown: false,
              onLoading: () => controller.loadNextPage(() => loadMoreSuccess(controller.refreshController), () => loadMoreFail(controller.refreshController)),
              child: ExtendedCustomScrollView(
                controller: controller.scrollController,
                slivers: [
                  goodsInfo(context),
                  appraiseInfo(context),
                  detailCard(context),
                  storeGoodsHeader(context),
                  storeGoods(context),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: tabHeader(context),
        )
      ],
    );
  }

  //找到当前页面第一个可见的item的索引
  int findFirstVisibleItemIndex(List<GlobalKey<State<StatefulWidget>>> cardKeys, BuildContext context) {
    int i = 0;
    for (; i < cardKeys.length; i++) {
      RenderSliverToBoxAdapter? keyRenderObject = cardKeys[i].currentContext?.findAncestorRenderObjectOfType<RenderSliverToBoxAdapter>();
      if (keyRenderObject != null) {
        //距离CustomScrollView顶部距离， 上滚出可视区域变为0
        final dy = (keyRenderObject.parentData as SliverPhysicalParentData).paintOffset.dy;
        if (dy > 42 + getStatusHeight(context)) {
          break;
        }
      }
    }
    final newIndex = i == 0 ? 0 : i - 1;
    return newIndex;
  }
}
