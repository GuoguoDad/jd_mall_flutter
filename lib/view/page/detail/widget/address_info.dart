// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/generated/assets.dart';
import 'package:jd_mall_flutter/generated/l10n.dart';
import 'package:jd_mall_flutter/models/goods_detail_res.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_controller.dart';

double screenWidth = 0;

Widget addressInfo(BuildContext context, DetailController c) {
  screenWidth = getScreenWidth(context);

  return Container(
    width: getScreenWidth(context) - 24,
    margin: const EdgeInsets.only(top: 10),
    padding: const EdgeInsets.all(10),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    child: Obx(() {
      BannerInfo selectInfo = c.selectInfo.value;
      List<String> tagList = c.goodsDetailRes.value.goodsInfo?.tagList ?? [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rowItem(S.of(context).select, "已选：${selectInfo.colorName}, 42, 1件", 1, true, null),
          rowItem(S.of(context).sendTo, "江苏省南京市江宁区东山街道丰泽路118号中粮鸿云", 1, true, "今天17:00前完成下单，预计明天送达"),
          rowItem(S.of(context).carriage, "店铺单笔订单不满199元，收费5元(请以提交订单时为准)", 2, false, null),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: tagList.map((e) => tagLabel(e)).toList(),
          ),
        ],
      );
    }),
  );
}

Widget rowItem(String label, String text, int line, bool showArrow, String? des) {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: CommonStyle.color8B8C8A, fontSize: 16)),
                Container(
                  width: screenWidth - 110,
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    text,
                    maxLines: line,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            showArrow ? assetImage(Assets.detailIcArrowRight, 8, 24) : Container()
          ],
        ),
        des != null
            ? Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  des,
                  style: const TextStyle(fontSize: 16),
                ),
              )
            : Container()
      ],
    ),
  );
}

Widget tagLabel(String label) {
  return Text(label, style: TextStyle(fontSize: 14, color: CommonStyle.color8B8C8A));
}
