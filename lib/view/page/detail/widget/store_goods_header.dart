import 'package:flutter/material.dart';

import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';

Widget storeGoodsHeader(BuildContext context, Key key) {
  return SliverToBoxAdapter(
    child: Container(
      key: key,
      height: 48,
      width: getScreenWidth(context) - 10,
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
