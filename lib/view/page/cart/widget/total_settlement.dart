import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../../common/style/common_style.dart';
import '../../../../models/cart_goods.dart';
import '../../../../store/app_state.dart';
import '../redux/cart_page_action.dart';

Widget totalSettlement(BuildContext context) {
  return StoreBuilder<AppState>(builder: (context, store) {
    List<CartGoods> cartGoods = store.state.cartPageState.cartGoods;
    List<String> selectList = store.state.cartPageState.selectCartGoodsList;
    bool isSelect = isSelectAll(cartGoods, selectList);

    TotalInfo totalInfo = calcPrice(cartGoods, selectList);

    return Container(
      height: 58,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: CommonStyle.colorE6E6E6, width: 0.5), bottom: BorderSide(color: CommonStyle.colorE6E6E6, width: 0.5))),
      child: Row(
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
                          store.dispatch(SelectAllAction(!isSelect));
                        }),
                  ),
                  const Text("全选"),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: const Text("合计:"),
                  ),
                  Text("￥${totalInfo.price}", style: const TextStyle(fontWeight: FontWeight.bold))
                ],
              )),
          Container(
            width: 150,
            height: 58,
            alignment: Alignment.center,
            child: Ink(
              width: 130,
              height: 42,
              decoration: const BoxDecoration(
                  gradient:
                      LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFDE2F21), Color(0xFFEC592F)]),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                highlightColor: CommonStyle.themeColor,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  alignment: Alignment.center,
                  child: Text(
                    '去结算(${totalInfo.num})',
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {},
              ),
            ),
          )
        ],
      ),
    );
  });
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
    double money = goodsInfo!.num! * double.parse(goodsInfo!.price!);
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
