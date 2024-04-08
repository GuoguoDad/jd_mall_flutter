// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/component/persistentHeader/sliver_header_builder.dart';

Widget condition() {
  return SliverPersistentHeader(
    pinned: false,
    delegate: SliverHeaderDelegate.fixedHeight(
      //固定高度
      height: 40,
      child: Container(
        padding: const EdgeInsets.only(left: 24, right: 24),
        color: CommonStyle.colorF1F1F1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${"all".tr} 0",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: CommonStyle.themeColor),
            ),
            Text("${"priceReduction".tr} 0", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: CommonStyle.colorD0D0D0)),
            Text("filter".tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    ),
  );
}
