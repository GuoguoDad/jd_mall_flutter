// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jd_mall_flutter/component/page_goods_list_skeleton.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Project imports:
import 'package:jd_mall_flutter/common/constant/index.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/common_service.dart';
import 'package:jd_mall_flutter/component/goods_item.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';

class PageGoodsList extends StatefulWidget {
  final String code;
  final ScrollPhysics physics;
  final String currentCode;

  const PageGoodsList(this.code, this.currentCode, this.physics, {super.key});

  @override
  State<StatefulWidget> createState() => _PageGoodsListState();
}

class _PageGoodsListState extends State<PageGoodsList> {
  late final RefreshController _refreshController;

  int pageNum = 1;
  bool isLoading = true;

  //商品数据
  GoodsPageInfo goodsPageInfo = GoodsPageInfo.fromJson({});

  @override
  void initState() {
    _refreshController = RefreshController();
    super.initState();
    queryGoodsListByPage(1);
  }

  @override
  void didUpdateWidget(PageGoodsList oldWidget) {
    List<GoodsList> goods = goodsPageInfo.goodsList ?? [];
    if (oldWidget.code == "home_tab_${widget.currentCode}" && goods.isEmpty) {
      queryGoodsListByPage(1);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  queryGoodsListByPage(int currentPage) {
    CommonServiceApi.queryGoodsListByPage(widget.code, currentPage, pageSize).then((value) {
      if (value != null) {
        List<GoodsList> goods = goodsPageInfo.goodsList ?? [];
        List<GoodsList> newGoods = value.goodsList ?? [];
        List<GoodsList>? goodsList = [...goods, ...newGoods];

        setState(() {
          isLoading = false;
          pageNum = currentPage;
          goodsPageInfo = GoodsPageInfo(goodsList: goodsList, totalCount: value.totalCount, totalPageCount: value.totalPageCount);
        });

        if (currentPage < value.totalPageCount) {
          _refreshController.loadComplete();
        } else {
          _refreshController.loadNoData();
        }
      } else {
        setState(() {
          isLoading = false;
        });
        _refreshController.loadFailed();
        Future.delayed(const Duration(milliseconds: 1000), () => _refreshController.resetNoData());
      }
    }).catchError((err) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = (getScreenWidth(context) - 20) / 2;
    List<GoodsList> goodsList = goodsPageInfo.goodsList ?? [];

    if ((isLoading || goodsList.isEmpty) && pageNum == 1) {
      return pageGoodsListSkeleton(context);
    }

    return SmartRefresher(
      key: Key("MasonryGridView_${widget.code}"),
      controller: _refreshController,
      enablePullDown: false,
      enablePullUp: true,
      onLoading: () async {
        queryGoodsListByPage(pageNum + 1);
      },
      child: MasonryGridView.builder(
        physics: widget.physics,
        padding: EdgeInsets.zero,
        itemCount: goodsList.length,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        mainAxisSpacing: 10,
        crossAxisSpacing: 0,
        itemBuilder: (BuildContext context, int index) => goodsItem(context, goodsList[index], width),
      ),
    );
  }
}
