// Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';

Widget cartHeader(BuildContext context) {
  return SizedBox(
    height: 44 + getStatusHeight(context),
    child: Container(
      padding: EdgeInsets.only(top: getStatusHeight(context)),
      color: CommonStyle.colorF1F1F1,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 24,
            child: Text(
              "tabMainCart".tr,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 4,
            left: 100,
            child: Container(
              height: 24,
              width: getScreenWidth(context) - 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: CommonStyle.colorECEDEC,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: UnconstrainedBox(
                      child: assetImage('images/ic_address.png', 16, 16),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 24.0,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(right: 2),
                      child: Text(
                        "defaultAddress".tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: CommonStyle.placeholderColor, fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 2,
            right: 18,
            child: assetImage('images/ic_ellipsis.png', 28, 28),
          )
        ],
      ),
    ),
  );
}
