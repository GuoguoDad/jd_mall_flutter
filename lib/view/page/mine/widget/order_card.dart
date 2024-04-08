// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/generated/assets.dart';

Widget orderCard() {
  return SliverToBoxAdapter(
    child: Container(
      height: 142,
      width: getScreenWidth() - 20,
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              horizontalItem(Assets.imagesIcGoodsStar, "${"productCollection".tr}0"),
              line(1, 12),
              horizontalItem(Assets.imagesIcStoreFocus, "${"storeFollow".tr}16"),
              line(1, 12),
              horizontalItem(Assets.imagesIcLookHistory, "${"browsingHistory".tr}20")
            ],
          ),
          line(getScreenWidth() - 50, 1),
          Flex(
            direction: Axis.horizontal,
            children: [
              verticalItem(Assets.imagesIcTodoPay, "unpaid".tr),
              verticalItem(Assets.imagesIcTodoGet, "toBeReceived".tr),
              verticalItem(Assets.imagesIcTodoEvaluate, "toBeEvaluated".tr),
              verticalItem(Assets.imagesIcTodoExchange, "returnAfterSales".tr)
            ],
          )
        ],
      ),
    ),
  );
}

Widget horizontalItem(String iconPath, String text) {
  return Expanded(
    flex: 1,
    child: Container(
      height: 50,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          assetImage(iconPath, 20, 20),
          Container(
            margin: const EdgeInsets.only(left: 4),
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    ),
  );
}

Widget verticalItem(String iconPath, String text) {
  return Expanded(
    flex: 1,
    child: SizedBox(
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          assetImage(iconPath, 42, 42),
          Container(
            margin: const EdgeInsets.only(top: 2),
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    ),
  );
}

Widget line(double w, double h) {
  return Container(
    width: w,
    height: h,
    color: CommonStyle.colorF1F1F1,
  );
}
