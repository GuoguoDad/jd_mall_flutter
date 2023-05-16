import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_action.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_state.dart';

final welPageReducer = combineReducers<WelPageState>([
  TypedReducer<WelPageState, ChangePageScrollYAction>((state, action) =>
      WelPageState(state.isLoading ,action.value,  state.menuSliderIndex, state.currentTab, state.homePageInfo, state.pageNum, state.goodsPageInfo)),

  TypedReducer<WelPageState, SetMenuSliderIndex>((state, action) =>
      WelPageState(state.isLoading ,state.pageScrollY, action.value, state.currentTab, state.homePageInfo, state.pageNum, state.goodsPageInfo)),

  TypedReducer<WelPageState, SetCurrentTab>((state, action) =>
      WelPageState(state.isLoading ,state.pageScrollY, state.menuSliderIndex, action.value, state.homePageInfo, state.pageNum, state.goodsPageInfo)),

  TypedReducer<WelPageState, LoadAction>((state, action) =>
      WelPageState(action.value ,state.pageScrollY, state.menuSliderIndex, state.currentTab, state.homePageInfo, state.pageNum, state.goodsPageInfo)),

  TypedReducer<WelPageState, SetHomePageInfoAction>((state, action) =>
      WelPageState(state.isLoading ,state.pageScrollY, state.menuSliderIndex, state.currentTab, action.value, state.pageNum, state.goodsPageInfo)),

  TypedReducer<WelPageState, SetGoodsPageAction>((state, action) =>
      WelPageState(state.isLoading ,state.pageScrollY, state.menuSliderIndex, state.currentTab, state.homePageInfo, action.pageNum, action.value)),
]);