import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/view/page/home/redux/home_page_action.dart';
import 'package:jd_mall_flutter/view/page/home/redux/home_page_state.dart';

final homePageReducer = combineReducers<HomePageState>([
  TypedReducer<HomePageState, ChangeBackTopAction>((state, action) => state..showBackTop = action.value),
  //修改loading状态
  TypedReducer<HomePageState, SetLoadingAction>((state, action) => state..isLoading = action.value),
  //记录页面滚动距离
  TypedReducer<HomePageState, ChangePageScrollYAction>((state, action) => state..pageScrollY = action.value),
  //记录九宫格菜单滚动index
  TypedReducer<HomePageState, SetMenuSliderIndex>((state, action) => state..menuSliderIndex = action.value),
  //记录滚动图片index
  TypedReducer<HomePageState, SetCurrentTab>((state, action) => state..currentTab = action.value),
  //设置页面数据
  TypedReducer<HomePageState, SetHomePageInfoAction>((state, action) => state..homePageInfo = action.value),
]);
