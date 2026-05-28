// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/goods_item.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_provider.dart';

double screenWidth = getScreenWidth();

class StoreGoodsList extends StatelessWidget {
  const StoreGoodsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailProvider>(
      builder: (context, provider, child) {
        double width = (getScreenWidth() - 20) / 2;
        List<GoodsList>? goodsList = provider.goodsPageInfo.goodsList ?? [];

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
