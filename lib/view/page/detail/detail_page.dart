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

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final DetailController controller = Get.put(DetailController());
  late final ExtendedScrollController _scrollController;
  late final RefreshController _refreshController;

  //是否是floatingHeader中的tab点击
  bool isTabClicked = false;
  final ValueNotifier<double> _pageScrollY = ValueNotifier<double>(0);
  final ValueNotifier<int> _index = ValueNotifier<int>(0);

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
    _pageScrollY.dispose();
    _index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return pageContainer(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            if (notification.depth == 1) {
              _pageScrollY.value = notification.metrics.pixels;

              //监听滚动，选中对应的tab
              if (isTabClicked) return false;
              int newIndex = findFirstVisibleItemIndex(cardKeys, context);
              _index.value = newIndex;
            }
            return false;
          },
          child: Container(
            color: CommonStyle.colorF5F5F5,
            child: SmartRefresher(
              controller: _refreshController,
              enablePullUp: true,
              enablePullDown: false,
              onLoading: () => controller.loadNextPage(() => loadMoreSuccess(_refreshController), () => loadMoreFail(_refreshController)),
              child: ExtendedCustomScrollView(
                controller: _scrollController,
                slivers: [
                  goodsInfo(context, cardKeys[0], controller),
                  appraiseInfo(context, cardKeys[1], controller),
                  detailCard(context, cardKeys[2], controller),
                  storeGoodsHeader(context, cardKeys[3]),
                  storeGoods(context, controller)
                ],
              ),
            ),
          ),
        ),
        floatingHeader()
      ],
    );
  }

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
              floatingActionButton: BackToTop(_scrollController),
            ),
          ),
          fixedBottom(context)
        ],
      ),
    );
  }

  //顶部商品、评价、详情、推荐浮动tab
  Widget floatingHeader() {
    return Positioned(
      top: 0,
      left: 0,
      child: tabHeader(
        context,
        _pageScrollY,
        _index,
        onChange: (index) {
          if (_index.value != index) {
            isTabClicked = true;
            _index.value = index;
            scroll2PositionByTabIndex(index);
          }
        },
      ),
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
