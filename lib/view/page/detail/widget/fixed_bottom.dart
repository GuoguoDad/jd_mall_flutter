// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/common/extension/color_ext.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/component/linear_button.dart';

Widget fixedBottom(BuildContext context) {
  double space = getBottomSpace();

  return Container(
    height: 64 + space,
    padding: EdgeInsets.only(bottom: space),
    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300, width: 0.2)),
    child: Row(
      children: [
        Flexible(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              columnItem("images/detail/ic_store_red.png", "store".tr),
              columnItem("images/detail/ic_customer_service.png", "customerService".tr),
              columnItem("images/detail/ic_cart.png", "tabMainCart".tr),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.6,
              child: LinearButton(
                width: double.infinity,
                height: double.infinity,
                btnName: "add2Cart".tr,
                fontSize: 14,
                highlightColor: Colors.yellow,
                colors: ["#F2CD4A".toColor(), "#F2C54B".toColor()],
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                onTap: () => print("======="),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.6,
              child: LinearButton(
                width: double.infinity,
                height: double.infinity,
                btnName: "couponPurchase".tr,
                fontSize: 14,
                highlightColor: Colors.red,
                colors: ["#E54B4E".toColor(), "#E34439".toColor()],
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                onTap: () => print("======="),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget columnItem(String icon, String name) {
  return SizedBox(
    height: 50,
    width: 48,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        assetImage(icon, 26, 26),
        Text(
          name,
          style: const TextStyle(fontSize: 12, color: Colors.black54, decoration: TextDecoration.none),
        )
      ],
    ),
  );
}
