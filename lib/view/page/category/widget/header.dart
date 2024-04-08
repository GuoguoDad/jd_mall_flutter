// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/common/extension/color_ext.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';

Widget header(BuildContext context) {
  return Container(
    color: '#FE0F22'.toColor(),
    height: 50 + getStatusHeight(),
    padding: EdgeInsets.only(top: getStatusHeight()),
    child: Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: <Widget>[
        Positioned(
          top: 0,
          left: 16,
          child: Column(
            children: [
              assetImage('images/scan.png', 24, 24),
              Text(
                "scan".tr,
                style: const TextStyle(color: Colors.white, fontSize: 11),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 16,
          child: Column(
            children: [
              assetImage('images/message.png', 24, 24),
              Text(
                "message".tr,
                style: const TextStyle(color: Colors.white, fontSize: 11),
              )
            ],
          ),
        ),
        Positioned(
          top: 1,
          child: Container(
            height: 36,
            width: getScreenWidth() - 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: "#F0F1ED".toColor(),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 40,
                  height: 34,
                  child: UnconstrainedBox(
                    child: assetImage('images/ic_search.png', 20, 20),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 36.0,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "searchInputTip".tr,
                      style: TextStyle(
                        fontSize: 14,
                        color: '#818286'.toColor(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
