// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/generated/assets.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_provider.dart';
import 'package:jd_mall_flutter/view/page/home/util.dart';

double screenWidth = getScreenWidth();

/// 详情区块的锚点卡片（承载 cardKeys[2]，用于顶部 tab 定位）。
/// 只保留标题，详情大图拆到 [DetailImgList] 做懒加载，避免一次性构建全部大图。
class DetailImgHeader extends StatelessWidget {
  const DetailImgHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final hasImg = (context.select<DetailProvider, int>(
          (p) => (p.goodsDetailRes.detailInfo?.introductionList ?? const <String>[]).length,
        )) >
        0;

    if (!hasImg) return const SliverToBoxAdapter(child: SizedBox.shrink());

    return SliverToBoxAdapter(
      child: Container(
        key: cardKeys[2],
        margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        child: Text(
          "详情",
          style: TextStyle(color: CommonStyle.color545454),
        ),
      ),
    );
  }
}

/// 详情大图列表：使用 SliverList 懒加载，只有进入视口的图片才会构建与解码，
/// 并按实际显示尺寸限制解码分辨率，显著降低详情页滚动时的内存与解码耗时。
class DetailImgList extends StatelessWidget {
  const DetailImgList({super.key});

  @override
  Widget build(BuildContext context) {
    final list = context.select<DetailProvider, List<String>?>(
      (p) => p.goodsDetailRes.detailInfo?.introductionList,
    );

    if (list == null || list.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());

    final memWidth = ((screenWidth - 40) * MediaQuery.devicePixelRatioOf(context)).round();

    return SliverPadding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      sliver: DecoratedSliver(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
        ),
        sliver: SliverPadding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => RepaintBoundary(
                child: CachedNetworkImage(
                  width: screenWidth - 40,
                  imageUrl: list[index],
                  memCacheWidth: memWidth,
                  filterQuality: FilterQuality.low,
                  placeholder: (context, url) => assetImage(Assets.imagesDefault, screenWidth - 40, 100),
                  errorBuilder: (context, url, error) => assetImage(Assets.imagesDefault, screenWidth - 40, 100),
                  fit: BoxFit.fitWidth,
                ),
              ),
              childCount: list.length,
            ),
          ),
        ),
      ),
    );
  }
}
