import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_action.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_state.dart';

final welPageReducer = combineReducers<WelPageState>([
  //修改loading状态
  TypedReducer<WelPageState, SetLoadingAction>((state, action) => WelPageState(
      action.value, state.pageScrollY, state.menuSliderIndex, state.currentTab, state.homePageInfo, state.pageNum, state.goodsPageInfo)),
  //记录页面滚动距离
  TypedReducer<WelPageState, ChangePageScrollYAction>((state, action) => WelPageState(
      state.isLoading, action.value, state.menuSliderIndex, state.currentTab, state.homePageInfo, state.pageNum, state.goodsPageInfo)),
  //记录九宫格菜单滚动index
  TypedReducer<WelPageState, SetMenuSliderIndex>((state, action) => WelPageState(
      state.isLoading, state.pageScrollY, action.value, state.currentTab, state.homePageInfo, state.pageNum, state.goodsPageInfo)),
  //记录滚动图片index
  TypedReducer<WelPageState, SetCurrentTab>((state, action) => WelPageState(
      state.isLoading, state.pageScrollY, state.menuSliderIndex, action.value, state.homePageInfo, state.pageNum, state.goodsPageInfo)),
  //初始化数据
  TypedReducer<WelPageState, InitDataAction>((state, action) => WelPageState(
      state.isLoading, state.pageScrollY, state.menuSliderIndex, state.currentTab, state.homePageInfo, state.pageNum, state.goodsPageInfo)),
  //设置页面数据
  TypedReducer<WelPageState, SetHomePageInfoAction>((state, action) => WelPageState(
      state.isLoading, state.pageScrollY, state.menuSliderIndex, state.currentTab, action.value, state.pageNum, state.goodsPageInfo)),
  //初始化商品数据
  TypedReducer<WelPageState, InitGoodsPageAction>((state, action) => WelPageState(
      state.isLoading, state.pageScrollY, state.menuSliderIndex, state.currentTab, state.homePageInfo, action.pageNum, action.value)),
  //加载更多
  TypedReducer<WelPageState, MoreGoodsPageAction>((state, action) => _onLoadMore(state, action)),
]);

WelPageState _onLoadMore(WelPageState state, MoreGoodsPageAction action) {
  List<GoodsList> goods = state.goodsPageInfo.goodsList ?? [];
  List<GoodsList>? goodsList = [...goods, ...?action.value.goodsList];

  return WelPageState(state.isLoading, state.pageScrollY, state.menuSliderIndex, state.currentTab, state.homePageInfo, action.pageNum,
      GoodsPageInfo(goodsList: goodsList, totalCount: state.goodsPageInfo.totalCount, totalPageCount: state.goodsPageInfo.totalPageCount));
}
