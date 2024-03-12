// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/generated/assets.dart';
import 'package:jd_mall_flutter/generated/l10n.dart';
import 'package:jd_mall_flutter/models/goods_detail_res.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_controller.dart';

Widget skuInfo(BuildContext context, DetailController c) {
  double thumbWidth = 68;

  return Container(
    width: getScreenWidth(context) - 24,
    margin: const EdgeInsets.only(top: 10),
    padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    child: Obx(() {
      List<BannerInfo> bannerList = c.goodsDetailRes.value.bannerList ?? [];
      BannerInfo selectInfo = c.selectInfo.value;
      GoodsInfo? goodsInfo = c.goodsDetailRes.value.goodsInfo;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: thumbWidth,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${bannerList.length}${S.of(context).colorToChoose}",
                  style: TextStyle(color: CommonStyle.color545454, fontSize: 16),
                ),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: bannerList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      bool isSelect = bannerList[index].colorId == selectInfo.colorId;

                      return GestureDetector(
                        onTap: () => c.selectBanner(bannerList[index]),
                        child: Container(
                          width: thumbWidth,
                          height: thumbWidth,
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: isSelect ? CommonStyle.themeColor : Colors.transparent, width: 0.5),
                          ),
                          child: CachedNetworkImage(
                            height: thumbWidth,
                            width: thumbWidth,
                            imageUrl: bannerList[index].thumb!,
                            placeholder: (context, url) => assetImage(Assets.imagesDefault, thumbWidth, thumbWidth),
                            errorWidget: (context, url, error) => assetImage(Assets.imagesDefault, thumbWidth, thumbWidth),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              "￥${goodsInfo?.specialPrice}",
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            goodsInfo?.goodsName ?? "",
            maxLines: 2,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
    }),
  );
}
