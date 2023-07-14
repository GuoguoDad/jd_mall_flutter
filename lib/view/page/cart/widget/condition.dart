import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/component/persistentHeader/sliver_header_builder.dart';
import 'package:jd_mall_flutter/generated/l10n.dart';

Widget condition(BuildContext context) {
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
              "${S.of(context).all} 0",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: CommonStyle.themeColor),
            ),
            Text("${S.of(context).priceReduction} 0", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: CommonStyle.colorD0D0D0)),
            Text(S.of(context).filter, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    ),
  );
}
