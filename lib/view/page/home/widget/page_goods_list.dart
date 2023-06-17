import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/common/widget/goods_item.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:jd_mall_flutter/common/constant/index.dart';
import 'package:jd_mall_flutter/view/page/home/service.dart';

class PageGoodsList extends StatefulWidget {
  final String code;
  final ScrollPhysics physics;

  const PageGoodsList(this.code, this.physics, {super.key});

  @override
  State<StatefulWidget> createState() => _PageGoodsListState();
}

class _PageGoodsListState extends State<PageGoodsList> {
  final RefreshController _refreshController = RefreshController();

  int pageNum = 1;

  //商品数据
  GoodsPageInfo goodsPageInfo = GoodsPageInfo.fromJson({});

  @override
  void initState() {
    super.initState();
    queryGoodsListByPage(1);
  }

  queryGoodsListByPage(int currentPage) {
    HomeApi.queryGoodsListByPage(widget.code, currentPage, pageSize).then((value) {
      if (value != null) {
        List<GoodsList> goods = goodsPageInfo.goodsList ?? [];
        List<GoodsList>? goodsList = [...goods, ...value.goodsList];

        setState(() {
          pageNum = currentPage;
          goodsPageInfo = GoodsPageInfo(goodsList: goodsList, totalCount: value.totalCount, totalPageCount: value.totalPageCount);
        });

        if (currentPage < value.totalPageCount) {
          _refreshController.loadComplete();
        } else {
          _refreshController.loadNoData();
        }
      } else {
        _refreshController.loadFailed();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = (getScreenWidth(context) - 20) / 2;
    var goodsList = goodsPageInfo.goodsList ?? [];

    return SmartRefresher(
        key: Key("MasonryGridView_${widget.code}"),
        controller: _refreshController,
        enablePullDown: false,
        enablePullUp: true,
        onLoading: () async {
          queryGoodsListByPage(pageNum + 1);
        },
        child: MasonryGridView.count(
          physics: widget.physics,
          padding: EdgeInsets.zero,
          itemCount: goodsList.length,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 0,
          itemBuilder: (context, index) => goodsItem(context, goodsList[index], width),
        ));
  }
}
