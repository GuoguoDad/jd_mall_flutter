// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/goods_item.dart';
import 'package:jd_mall_flutter/view/page/cart/cart_provider.dart';

double width = (getScreenWidth() - 20) / 2;

class ProbablyLikeGoods extends StatelessWidget {
  const ProbablyLikeGoods({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, provider, child) {
        var goodsList = provider.goodsPageInfo.goodsList ?? [];

        return SliverMasonryGrid.count(
          childCount: goodsList.length,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 0,
          itemBuilder: (context, index) => goodsItem(context, goodsList[index], width),
        );
      }
    );
  }
}
