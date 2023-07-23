import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/common/util/color_util.dart';
import 'package:jd_mall_flutter/component/linear_button.dart';
import 'package:jd_mall_flutter/generated/l10n.dart';

Widget fixedBottom(BuildContext context) {
  double space = getBottomSpace(context);

  return Container(
    height: 64 + space,
    padding: EdgeInsets.only(bottom: space),
    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300, width: 0.2)),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              columnItem("images/detail/ic_store_red.png", S.of(context).store),
              columnItem("images/detail/ic_customer_service.png", S.of(context).customerService),
              columnItem("images/detail/ic_cart.png", S.of(context).tabMainCart)
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LinearButton(
                width: 110,
                height: 42,
                btnName: S.of(context).add2Cart,
                highlightColor: Colors.yellow,
                colors: [ColorUtil.hex2Color("#F2CD4A"), ColorUtil.hex2Color("#F2C54B")],
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                onTap: () => print("======="),
              ),
              LinearButton(
                width: 110,
                height: 42,
                btnName: S.of(context).couponPurchase,
                highlightColor: Colors.red,
                colors: [ColorUtil.hex2Color("#E54B4E"), ColorUtil.hex2Color("#E34439")],
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                onTap: () => print("======="),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget columnItem(String icon, String name) {
  return SizedBox(
    height: 54,
    width: 56,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        assetImage(icon, 28, 28),
        Text(
          name,
          style: const TextStyle(fontSize: 12, color: Colors.black54, decoration: TextDecoration.none),
        )
      ],
    ),
  );
}
