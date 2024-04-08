// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/view/page/home/util.dart';

Widget storeGoodsHeader(BuildContext context) {
  return SliverToBoxAdapter(
    child: Container(
      key: cardKeys[3],
      height: 48,
      width: getScreenWidth() - 10,
      margin: const EdgeInsets.only(left: 5, top: 10),
      padding: const EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Text(
        "同店好货",
        style: TextStyle(color: CommonStyle.color545454),
      ),
    ),
  );
}
