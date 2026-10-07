// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/goods_item.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/view/page/cart/cart_provider.dart';

final double width = (getScreenWidth() - 20) / 2;

class ProbablyLikeGoods extends StatelessWidget {
  const ProbablyLikeGoods({super.key});

  @override
  Widget build(BuildContext context) {
    // 只在商品数据本身变化时重建，避免购物车勾选等操作牵连整个瀑布流
    return Selector<CartProvider, List<GoodsList>?>(
      selector: (context, provider) => provider.goodsPageInfo.goodsList,
      shouldRebuild: (prev, next) => !identical(prev, next),
      builder: (context, goodsList, child) {
        final list = goodsList ?? const <GoodsList>[];

        return SliverMasonryGrid.count(
          childCount: list.length,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 0,
          itemBuilder: (context, index) => RepaintBoundary(
            child: goodsItem(context, list[index], width),
          ),
        );
      },
    );
  }
}
