import 'package:flutter/material.dart';

import 'package:jd_mall_flutter/common/util/color_util.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/linear_button.dart';

Widget fixedBottom(BuildContext context) {
  double space = getBottomSpace(context);

  return Container(
    height: 64 + space,
    padding: EdgeInsets.only(bottom: space),
    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade200, width: 0.1)),
    child: Row(
      children: [
        Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 12),
                  child: const Text("￥",
                      style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.w600, decoration: TextDecoration.none)),
                ),
                const Text("1899",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.red, decoration: TextDecoration.none)),
                const Text(".20",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.red, decoration: TextDecoration.none)),
              ],
            )),
        Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LinearButton(
                    width: 100,
                    height: 48,
                    btnName: "帮我付",
                    highlightColor: Colors.yellow,
                    colors: [ColorUtil.hex2Color("#F2CD4A"), ColorUtil.hex2Color("#F2C54B")],
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    onTap: () => print("=======")),
                LinearButton(
                    width: 100,
                    height: 48,
                    btnName: "自己付",
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
