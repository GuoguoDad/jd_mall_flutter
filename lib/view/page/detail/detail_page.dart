import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/appraise_info.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/bedienfeld.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/detail_card.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/store_goods.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/store_goods_header.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/tab_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/common/widget/back_to_top.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/detail/redux/detail_page_action.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/goods_info.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  static const String name = "/detail";

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController();

  bool isTabClicked = false;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(onInit: (store) {
      store.dispatch(InitPageAction());
    }, builder: (context, store) {
      //
      //商品、评论、详情、同店好货锚点key
      final cardKeys = <GlobalKey>[];
      for (var i = 0; i < 4; i++) {
        cardKeys.add(GlobalKey(debugLabel: 'card_$i'));
      }
      //
      Widget content = Stack(
        children: [
          Container(
            color: CommonStyle.colorF5F5F5,
            child: SmartRefresher(
              controller: _refreshController,
              enablePullUp: true,
              enablePullDown: false,
              onLoading: () async {
                store.dispatch(LoadMoreAction(store.state.detailPageState.pageNum + 1, () => loadMoreSuccess(_refreshController),
                    () => loadMoreFail(_refreshController)));
              },
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  goodsInfo(context, cardKeys[0]),
                  appraiseInfo(context, cardKeys[1]),
                  detailCard(context, cardKeys[2]),
                  storeGoodsHeader(context, cardKeys[3]),
                  storeGoods(context)
                ],
              ),
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              child: tabHeader(context, onChange: (index) {
                isTabClicked = true;
                store.dispatch(ChangeTopTabIndexAction(index));
                scroll2PositionByTabIndex(cardKeys, index);
              }))
        ],
      );

      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification.depth == 0) {
              double distance = notification.metrics.pixels;
              store.dispatch(ChangePageScrollYAction(distance));
              //监听滚动，选中对应的tab
              if (isTabClicked) return false;
              int newIndex = findFirstVisibleItemIndex(cardKeys, context);
              store.dispatch(ChangeTopTabIndexAction(newIndex));
            }
            return false;
          },
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Scaffold(
                      body: content,
                      floatingActionButton: BackToTop(_scrollController),
                    )),
                bedienfeld(context)
              ],
            ),
          ));
    });
  }

  void scroll2PositionByTabIndex(List<GlobalKey<State<StatefulWidget>>> cardKeys, int index) {
    RenderSliverToBoxAdapter? keyRenderObject = cardKeys[index].currentContext?.findAncestorRenderObjectOfType<RenderSliverToBoxAdapter>();
    if (keyRenderObject != null) {
      _scrollController.position
          .ensureVisible(keyRenderObject, duration: const Duration(milliseconds: 300), curve: Curves.linear)
          .then((value) => isTabClicked = false);
    }
  }

  int findFirstVisibleItemIndex(List<GlobalKey<State<StatefulWidget>>> cardKeys, BuildContext context) {
    int i = 0;
    for (; i < cardKeys.length; i++) {
      RenderSliverToBoxAdapter? keyRenderObject = cardKeys[i].currentContext?.findAncestorRenderObjectOfType<RenderSliverToBoxAdapter>();
      if (keyRenderObject != null) {
        //距离CustomScrollView顶部距离， 上滚出可视区域变为0
        final offsetY = (keyRenderObject.parentData as SliverPhysicalParentData).paintOffset.dy;
        if (offsetY > 42 + getStatusHeight(context)) {
          break;
        }
      }
    }
    final newIndex = i == 0 ? 0 : i - 1;
    return newIndex;
  }
}
