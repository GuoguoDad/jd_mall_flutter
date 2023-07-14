import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/view/page/mine/redux/mine_page_state.dart';

import 'package:jd_mall_flutter/generated/l10n.dart';

Widget orderCard(BuildContext context) {
  return StoreConnector<AppState, MinePageState>(
    converter: (store) {
      return store.state.minePageState;
    },
    builder: (context, state) {
      return Container(
          height: 142,
          width: getScreenWidth(context) - 20,
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  horizontalItem("images/ic_goods_star.png", "${S.of(context).productCollection}0"),
                  line(1, 12),
                  horizontalItem("images/ic_store_focus.png", "${S.of(context).storeFollow}16"),
                  line(1, 12),
                  horizontalItem("images/ic_look_history.png", "${S.of(context).browsingHistory}20")
                ],
              ),
              line(getScreenWidth(context) - 50, 1),
              Flex(direction: Axis.horizontal, children: [
                verticalItem("images/ic_todo_pay.png", S.of(context).unpaid),
                verticalItem("images/ic_todo_get.png", S.of(context).toBeReceived),
                verticalItem("images/ic_todo_evaluate.png", S.of(context).toBeEvaluated),
                verticalItem("images/ic_todo_exchange.png", S.of(context).returnAfterSales)
              ])
            ],
          ));
    },
  );
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
              margin: const EdgeInsets.only(top: 2),
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
