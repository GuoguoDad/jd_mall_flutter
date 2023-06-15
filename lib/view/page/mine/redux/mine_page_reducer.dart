import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/view/page/mine/redux/mine_page_action.dart';
import 'package:jd_mall_flutter/view/page/mine/redux/mine_page_state.dart';

import 'package:jd_mall_flutter/models/goods_page_info.dart';

final minePageReducer = combineReducers<MinePageState>([
  //记录页面滚动距离
  TypedReducer<MinePageState, ChangePageScrollYAction>((state, action) => state..pageScrollY = action.value),
  //记录九宫格菜单滚动index
  TypedReducer<MinePageState, ChangeSliderIndexAction>((state, action) => state..menuIndex = action.menuIndex),
  //记录滚动tab index
  TypedReducer<MinePageState, SetCurrentTab>((state, action) => state..currentTab = action.value),
  //
  TypedReducer<MinePageState, InitMineMenuTabInfoAction>((state, action) => state..menuTabInfo = action.menuTabInfo),
  //初始化商品数据
  TypedReducer<MinePageState, InitGoodsPageAction>((state, action) => state
    ..pageNum = action.pageNum
    ..goodsPageInfo = action.value),
  //加载更多
  TypedReducer<MinePageState, MoreGoodsPageAction>((state, action) {
    List<GoodsList> goods = state.goodsPageInfo.goodsList ?? [];
    List<GoodsList>? goodsList = [...goods, ...?action.value.goodsList];

    return state
      ..pageNum = action.pageNum
      ..goodsPageInfo = GoodsPageInfo(
          goodsList: goodsList, totalCount: state.goodsPageInfo.totalCount, totalPageCount: state.goodsPageInfo.totalPageCount);
  }),
]);
