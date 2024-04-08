// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/generated/assets.dart';
import 'package:jd_mall_flutter/models/goods_detail_res.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_controller.dart';

Widget skuInfo(BuildContext context) {
  double thumbWidth = 68;

  return Container(
    width: getScreenWidth() - 24,
    margin: const EdgeInsets.only(top: 10),
    padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    child: Obx(() {
      List<BannerInfo> bannerList = DetailController.to.goodsDetailRes.value.bannerList ?? [];
      BannerInfo selectInfo = DetailController.to.selectInfo.value;
      GoodsInfo? goodsInfo = DetailController.to.goodsDetailRes.value.goodsInfo;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: thumbWidth,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${bannerList.length}${"colorToChoose".tr}",
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
                        onTap: () => DetailController.to.selectBanner(bannerList[index]),
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
