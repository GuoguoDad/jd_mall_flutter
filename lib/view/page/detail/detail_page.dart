// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:extended_scroll/extended_scroll.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/refresh_util.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/loading_widget.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/detail/redux/detail_page_action.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/appraise_info.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/back_to_top.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/detail_card.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/fixed_bottom.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/goods_info.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/store_goods.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/store_goods_header.dart';
import 'package:jd_mall_flutter/view/page/detail/widget/tab_header.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  static const String name = "/detailPage";

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final ExtendedScrollController _scrollController;
  late final RefreshController _refreshController;

  //是否是floatingHeader中的tab点击
  bool isTabClicked = false;

  //商品、评论、详情、同店好货锚点key
  final cardKeys = <GlobalKey>[
    GlobalKey(debugLabel: 'detail_card_0'),
    GlobalKey(debugLabel: 'detail_card_1'),
    GlobalKey(debugLabel: 'detail_card_2'),
    GlobalKey(debugLabel: 'detail_card_3')
  ];

  @override
  void initState() {
    _scrollController = ExtendedScrollController();
    _refreshController = RefreshController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      onInit: (store) async {
        await store.dispatch(InitPageAction());
      },
      onDispose: (store) {
        store.dispatch(ChangeTopTabIndexAction(0));
      },
      builder: (context, store) {
        bool isLoading = store.state.detailPageState.isLoading;

        List<Widget> stackWidgets = [];
        if (isLoading) {
          stackWidgets.add(loadingWidget(context));
        } else {
          stackWidgets.add(NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              double distance = notification.metrics.pixels;
              store.dispatch(ChangePageScrollYAction(distance));
              //监听滚动，选中对应的tab
              if (isTabClicked) return false;
              int newIndex = findFirstVisibleItemIndex(cardKeys, context);
              store.dispatch(ChangeTopTabIndexAction(newIndex));
              return false;
            },
            child: Container(
              color: CommonStyle.colorF5F5F5,
              child: SmartRefresher(
                controller: _refreshController,
                enablePullUp: true,
                enablePullDown: false,
                onLoading: () async {
                  store.dispatch(LoadMoreAction(
                    store.state.detailPageState.pageNum + 1,
                    () => loadMoreSuccess(_refreshController),
                    () => loadMoreFail(_refreshController),
                  ));
                },
                child: ExtendedCustomScrollView(
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
          ));
        }

        stackWidgets.add(
          Positioned(
            top: 0,
            left: 0,
            child: tabHeader(
              context,
              onChange: (index) {
                isTabClicked = true;
                store.dispatch(ChangeTopTabIndexAction(index));
                scroll2PositionByTabIndex(index);
              },
            ),
          ),
        );

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Scaffold(
                  body: Stack(
                    children: stackWidgets,
                  ),
                  floatingActionButton: BackToTop(_scrollController),
                ),
              ),
              fixedBottom(context)
            ],
          ),
        );
      },
    );
  }

  //根据index滚动页面至相应模块位置
  void scroll2PositionByTabIndex(int index) {
    RenderSliverToBoxAdapter? keyRenderObject = cardKeys[index].currentContext?.findAncestorRenderObjectOfType<RenderSliverToBoxAdapter>();
    if (keyRenderObject != null) {
      _scrollController.position
          .ensureVisible(keyRenderObject, offsetTop: 42 + getStatusHeight(context), duration: const Duration(milliseconds: 300), curve: Curves.linear)
          .then((value) => isTabClicked = false);
    }
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
