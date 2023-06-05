import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/page/cart/redux/cart_page_action.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/page/cart/redux/cart_page_state.dart';

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
]);
