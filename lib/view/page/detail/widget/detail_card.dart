// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image_ce/cached_network_image.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/generated/assets.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_provider.dart';
import 'package:jd_mall_flutter/view/page/home/util.dart';
import 'package:provider/provider.dart';

double screenWidth = getScreenWidth();

class DetailImgList extends StatelessWidget {
  const DetailImgList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        key: cardKeys[2],
        margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: Text(
                "详情",
                style: TextStyle(color: CommonStyle.color545454),
              ),
            ),
            Consumer<DetailProvider>(
                builder: (context, provider, child) {
                  List<String>? introductionList = provider.goodsDetailRes.detailInfo?.introductionList ?? [];

                  return Column(
                    children: introductionList
                        .map((url) => CachedNetworkImage(
                      width: screenWidth - 40,
                      imageUrl: url,
                      placeholder: (context, url) => assetImage(Assets.imagesDefault, screenWidth - 40, 100),
                      errorWidget: (context, url, error) => assetImage(Assets.imagesDefault, screenWidth - 40, 100),
                      fit: BoxFit.fitWidth,
                    ))
                        .toList(),
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}
