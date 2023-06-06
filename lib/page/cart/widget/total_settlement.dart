import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../common/style/common_style.dart';
import '../../../models/cart_goods.dart';
import '../../../redux/app_state.dart';
import '../redux/cart_page_action.dart';

Widget totalSettlement(BuildContext context) {
  return StoreBuilder<AppState>(builder: (context, store) {
    List<CartGoods> cartGoods = store.state.cartPageState.cartGoods;
    List<String> selectList = store.state.cartPageState.selectCartGoodsList;
    bool isSelect = isSelectAll(cartGoods, selectList);

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
                  const Text("￥3376.00", style: TextStyle(fontWeight: FontWeight.bold))
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
                    '去结算(${selectList.length})',
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
