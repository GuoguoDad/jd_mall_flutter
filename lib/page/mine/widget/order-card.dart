import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/redux/app_state.dart';
import 'package:jd_mall_flutter/common/widget/image/asset_image.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_state.dart';

import '../redux/mine_page_state.dart';

Widget orderCard(BuildContext context) {
  return SliverToBoxAdapter(
      child: StoreConnector<AppState, MinePageState>(
    converter: (store) {
      return store.state.minePageState;
    },
    builder: (context, state) {
      return Container(
          height: 142,
          width: MediaQuery.of(context).size.width - 20,
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  horizontalItem("images/ic_goods_star.png", "商品收藏0"),
                  line(1, 12),
                  horizontalItem("images/ic_store_focus.png", "店铺关注16"),
                  line(1, 12),
                  horizontalItem("images/ic_look_history.png", "浏览记录20")
                ],
              ),
              line(MediaQuery.of(context).size.width - 50, 1),
              Flex(direction: Axis.horizontal, children: [
                verticalItem("images/ic_todo_pay.png", "待付款"),
                verticalItem("images/ic_todo_get.png", "待收货"),
                verticalItem("images/ic_todo_evaluate.png", "待评价"),
                verticalItem("images/ic_todo_exchange.png", "退换/售后")
              ])
            ],
          ));
    },
  ));
}

Widget horizontalItem(String iconPath, String text) {
  return Expanded(
      flex: 1,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            assetImage(iconPath, 20, 20),
            Container(
              margin: const EdgeInsets.only(left: 4),
              child: Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ));
}

Widget verticalItem(String iconPath, String text) {
  return Expanded(
      flex: 1,
      child: SizedBox(
        height: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            assetImage(iconPath, 42, 42),
            Container(
              margin: EdgeInsets.only(top: 2),
              child: Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ));
}

Widget line(double w, double h) {
  return Container(
    width: w,
    height: h,
    color: CommonStyle.colorF1F1F1,
  );
}
