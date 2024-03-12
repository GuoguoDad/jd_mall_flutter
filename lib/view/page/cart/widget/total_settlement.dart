// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/linear_button.dart';
import 'package:jd_mall_flutter/generated/l10n.dart';
import 'package:jd_mall_flutter/models/cart_goods.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/view/page/cart/cart_controller.dart';

Widget totalSettlement(BuildContext context, CartController c) {
  return Container(
    height: 58,
    width: getScreenWidth(context),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        top: BorderSide(color: CommonStyle.colorE6E6E6, width: 0.5),
        bottom: BorderSide(color: CommonStyle.colorE6E6E6, width: 0.5),
      ),
    ),
    child: Obx(() {
      List<CartGoods> cartGoods = c.cartGoods;
      List<String> selectList = c.selectCartGoodsList;
      bool isSelect = isSelectAll(cartGoods, selectList);

      TotalInfo totalInfo = calcPrice(cartGoods, selectList);

      return Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Container(
                  width: 28,
                  margin: const EdgeInsets.only(left: 12),
                  child: Checkbox(
                    value: isSelect,
                    shape: const CircleBorder(),
                    activeColor: Colors.red,
                    onChanged: (bool? va) {
                      c.selectAll(!isSelect);
                    },
                  ),
                ),
                Text(S.of(context).selectAll, style: const TextStyle(fontSize: 13)),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Text("${S.of(context).amountTo}:", style: const TextStyle(fontSize: 13)),
                ),
                Text(
                  "￥${totalInfo.price}",
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            width: 150,
            height: 58,
            alignment: Alignment.center,
            child: LinearButton(
              width: 130,
              height: 42,
              btnName: '${S.of(context).toSettle}(${totalInfo.num})',
              onTap: () {
                if (selectList.isEmpty) {
                  EasyLoading.showInfo("您还没有选择商品哦", duration: const Duration(seconds: 2));
                  return;
                }
                Navigator.of(context).pushNamed(RoutesEnum.generateOrder.path);
              },
            ),
          )
        ],
      );
    }),
  );
}

bool isSelectAll(List<CartGoods> cartGoods, List<String> selectList) {
  //店铺维度选中列表
  List<CartGoods> list = cartGoods.where((element) {
    List<GoodsInfo> goods = element.goodsList!.where((goods) => selectList.contains(goods.code)).toList();
    return goods.length == element.goodsList?.length;
  }).toList();

  return list.length == cartGoods.length;
}

TotalInfo calcPrice(List<CartGoods> cartGoods, List<String> selectList) {
  double totalPrice = 0;
  int num = 0;
  for (var element in selectList) {
    GoodsInfo? goodsInfo = getGoodsInfo(cartGoods, element);
    num += goodsInfo!.num!;
    double money = goodsInfo.num! * double.parse(goodsInfo.price!);
    totalPrice += money;
  }
  return TotalInfo(totalPrice, num);
}

GoodsInfo? getGoodsInfo(List<CartGoods> cartGoods, String goodsCode) {
  CartGoods cGoods = cartGoods.firstWhere((element) => goodsCode.contains(element.storeCode!));
  return cGoods.goodsList?.firstWhere((element) => element.code == goodsCode);
}

class TotalInfo {
  double price;
  int num;

  TotalInfo(this.price, this.num);
}
