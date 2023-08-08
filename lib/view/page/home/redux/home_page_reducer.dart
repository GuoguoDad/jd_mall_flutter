// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:jd_mall_flutter/view/page/home/redux/home_page_action.dart';
import 'package:jd_mall_flutter/view/page/home/redux/home_page_state.dart';

final homePageReducer = combineReducers<HomePageState>([
  //修改loading状态
  TypedReducer<HomePageState, SetLoadingAction>((state, action) => state..isLoading = action.value),
  //记录九宫格菜单滚动index
  TypedReducer<HomePageState, SetMenuSliderIndex>((state, action) => state..menuSliderIndex = action.value),
  //设置页面数据
  TypedReducer<HomePageState, SetHomePageInfoAction>((state, action) => state..homePageInfo = action.value),
]);
