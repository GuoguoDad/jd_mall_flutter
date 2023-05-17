import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_action.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_state.dart';

final welPageReducer = combineReducers<WelPageState>([
  TypedReducer<WelPageState, ChangePageScrollYAction>((state, action) =>
      WelPageState(action.value,  state.menuSliderIndex, state.currentTab, state.homePageInfo, state.pageNum, state.goodsPageInfo)),

  TypedReducer<WelPageState, SetMenuSliderIndex>((state, action) =>
      WelPageState(state.pageScrollY, action.value, state.currentTab, state.homePageInfo, state.pageNum, state.goodsPageInfo)),

  TypedReducer<WelPageState, SetCurrentTab>((state, action) =>
      WelPageState(state.pageScrollY, state.menuSliderIndex, action.value, state.homePageInfo, state.pageNum, state.goodsPageInfo)),

  TypedReducer<WelPageState, InitDataAction>((state, action) =>
      WelPageState(state.pageScrollY, state.menuSliderIndex, state.currentTab, state.homePageInfo, state.pageNum, state.goodsPageInfo)),

  TypedReducer<WelPageState, SetHomePageInfoAction>((state, action) =>
      WelPageState(state.pageScrollY, state.menuSliderIndex, state.currentTab, action.value, state.pageNum, state.goodsPageInfo)),

  TypedReducer<WelPageState, InitGoodsPageAction>((state, action) =>
      WelPageState(state.pageScrollY, state.menuSliderIndex, state.currentTab, state.homePageInfo, action.pageNum, action.value)),

  TypedReducer<WelPageState, MoreGoodsPageAction>((state, action) => _onLoadMore(state, action)),

]);


WelPageState _onLoadMore(WelPageState state, MoreGoodsPageAction action) {
  List<GoodsList> goods = state.goodsPageInfo.goodsList ?? [];
  List<GoodsList>? goodsList = [...goods, ...?action.value.goodsList];

  return  WelPageState(
      state.pageScrollY,
      state.menuSliderIndex,
      state.currentTab,
      state.homePageInfo,
      action.pageNum,
      GoodsPageInfo(goodsList: goodsList, totalCount: state.goodsPageInfo.totalCount, totalPageCount: state.goodsPageInfo.totalPageCount)
  );
}