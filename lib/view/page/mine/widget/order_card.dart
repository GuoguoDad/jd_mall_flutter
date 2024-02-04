// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/generated/assets.dart';
import 'package:jd_mall_flutter/generated/l10n.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/mine/redux/mine_page_state.dart';

Widget orderCard(BuildContext context) {
  return StoreConnector<AppState, MinePageState>(
    converter: (store) {
      return store.state.minePageState;
    },
    builder: (context, state) {
      return SliverToBoxAdapter(
        child: Container(
          height: 142,
          width: getScreenWidth(context) - 20,
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  horizontalItem(Assets.imagesIcGoodsStar, "${S.of(context).productCollection}0"),
                  line(1, 12),
                  horizontalItem(Assets.imagesIcStoreFocus, "${S.of(context).storeFollow}16"),
                  line(1, 12),
                  horizontalItem(Assets.imagesIcLookHistory, "${S.of(context).browsingHistory}20")
                ],
              ),
              line(getScreenWidth(context) - 50, 1),
              Flex(
                direction: Axis.horizontal,
                children: [
                  verticalItem(Assets.imagesIcTodoPay, S.of(context).unpaid),
                  verticalItem(Assets.imagesIcTodoGet, S.of(context).toBeReceived),
                  verticalItem(Assets.imagesIcTodoEvaluate, S.of(context).toBeEvaluated),
                  verticalItem(Assets.imagesIcTodoExchange, S.of(context).returnAfterSales)
                ],
              )
            ],
          ),
        ),
      );
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
              style: const TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    ),
  );
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
              style: const TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    ),
  );
}

Widget line(double w, double h) {
  return Container(
    width: w,
    height: h,
    color: CommonStyle.colorF1F1F1,
  );
}
