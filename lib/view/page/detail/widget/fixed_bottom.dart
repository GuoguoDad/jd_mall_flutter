// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/common/extension/color_ext.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/component/linear_button.dart';
import 'package:jd_mall_flutter/generated/l10n.dart';

Widget fixedBottom(BuildContext context) {
  double space = getBottomSpace(context);

  return Container(
    height: 64 + space,
    padding: EdgeInsets.only(bottom: space),
    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300, width: 0.2)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        columnItem("images/detail/ic_store_red.png", S.of(context).store),
        columnItem("images/detail/ic_customer_service.png", S.of(context).customerService),
        columnItem("images/detail/ic_cart.png", S.of(context).tabMainCart),
        LinearButton(
          width: 100,
          height: 42,
          btnName: S.of(context).add2Cart,
          highlightColor: Colors.yellow,
          colors: ["#F2CD4A".toColor(), "#F2C54B".toColor()],
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          onTap: () => print("======="),
        ),
        LinearButton(
          width: 100,
          height: 42,
          btnName: S.of(context).couponPurchase,
          highlightColor: Colors.red,
          colors: ["#E54B4E".toColor(), "#E34439".toColor()],
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          onTap: () => print("======="),
        )
      ],
    ),
  );
}

Widget columnItem(String icon, String name) {
  return SizedBox(
    height: 54,
    width: 50,
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
