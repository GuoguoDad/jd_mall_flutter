import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/page/cart/redux/cart_page_action.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/page/cart/redux/cart_page_state.dart';

import '../../../models/cart_goods.dart';

final cartPageReducer = combineReducers<CartPageState>([
  //修改loading状态
  TypedReducer<CartPageState, SetLoadingAction>((state, action) => state..isLoading = action.value),
  //初始化购物车商品数据
  TypedReducer<CartPageState, InitCartGoodsAction>((state, action) => state..cartGoods = action.cartGoods),
  //初始化商品数据
  TypedReducer<CartPageState, InitGoodsPageAction>((state, action) => state
    ..pageNum = action.pageNum
    ..goodsPageInfo = action.value),
  //加载更多
  TypedReducer<CartPageState, MoreGoodsPageAction>((state, action) {
    List<GoodsList> goods = state.goodsPageInfo.goodsList ?? [];
    List<GoodsList>? goodsList = [...goods, ...?action.value.goodsList];

    return state
      ..pageNum = action.pageNum
      ..goodsPageInfo = GoodsPageInfo(
          goodsList: goodsList, totalCount: state.goodsPageInfo.totalCount, totalPageCount: state.goodsPageInfo.totalPageCount);
  }),
  //单选购物车中的商品
  TypedReducer<CartPageState, SelectCartGoodsAction>((state, action) {
    List<String> selectList = state.selectCartGoodsList;
    if (!selectList.contains(action.goodsCode)) {
      selectList.add(action.goodsCode);
    } else {
      selectList.removeAt(selectList.indexOf(action.goodsCode));
    }
    return state..selectCartGoodsList = selectList;
  }),
  //店铺维度全选
  TypedReducer<CartPageState, SelectStoreGoodsAction>((state, action) {
    List<String> selectList = state.selectCartGoodsList;
    List<CartGoods> cartGoods = state.cartGoods;
    //找到相应店铺的商品信息
    CartGoods cGoods = cartGoods.firstWhere((element) => element.storeCode == action.storeCode);
    cGoods.goodsList?.forEach((element) {
      if (action.value && !selectList.contains(element.code!)) {
        selectList.add(element.code!);
      } else if (!action.value && selectList.contains(element.code!)) {
        selectList.removeAt(selectList.indexOf(element.code!));
      }
    });
    return state..selectCartGoodsList = selectList;
  }),
  //全选
  TypedReducer<CartPageState, SelectAllAction>((state, action) {
    List<String> selectList = [];
    if (action.selectAll) {
      for (CartGoods element in state.cartGoods) {
        element.goodsList?.forEach((goodsInfo) {
          selectList.add(goodsInfo.code!);
        });
      }
    }
    return state..selectCartGoodsList = selectList;
  }),
]);
