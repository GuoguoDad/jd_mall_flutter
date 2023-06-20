import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/common/util/color_util.dart';
import 'package:jd_mall_flutter/component/linear_button.dart';

Widget fixedBottom(BuildContext context) {
  double space = getBottomSpace(context);

  return Container(
    height: 64 + space,
    padding: EdgeInsets.only(bottom: space),
    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey, width: 0.2)),
    child: Row(
      children: [
        Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                columnItem("images/detail/ic_store_red.png", "店铺"),
                columnItem("images/detail/ic_customer_service.png", "客服"),
                columnItem("images/detail/ic_cart.png", "购物车")
              ],
            )),
        Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LinearButton(
                    width: 110,
                    height: 48,
                    btnName: "加入购物车",
                    highlightColor: Colors.yellow,
                    colors: [ColorUtil.hex2Color("#F2CD4A"), ColorUtil.hex2Color("#F2C54B")],
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    onTap: () => print("=======")),
                LinearButton(
                    width: 110,
                    height: 48,
                    btnName: "领券购买",
                    highlightColor: Colors.red,
                    colors: [ColorUtil.hex2Color("#E54B4E"), ColorUtil.hex2Color("#E34439")],
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    onTap: () => print("======="))
              ],
            ))
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
        assetImage(icon, 32, 32),
        Text(
          name,
          style: const TextStyle(fontSize: 14, color: Colors.black54, decoration: TextDecoration.none),
        )
      ],
    ),
  );
}
