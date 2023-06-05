import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';
import '../../../common/widget/persistentHeader/sliver_header_builder.dart';

Widget condition(BuildContext context) {
  return SliverPersistentHeader(
      pinned: true,
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
                  "全部 0",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: CommonStyle.themeColor),
                ),
                Text("降价 0", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: CommonStyle.colorD0D0D0)),
                Text("筛选", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
          )));
}
