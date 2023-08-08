// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:jd_mall_flutter/view/page/mine/redux/mine_page_action.dart';
import 'package:jd_mall_flutter/view/page/mine/redux/mine_page_state.dart';

final minePageReducer = combineReducers<MinePageState>([
  //修改loading状态
  TypedReducer<MinePageState, SetLoadingAction>((state, action) => state..isLoading = action.value),
  //记录九宫格菜单滚动index
  TypedReducer<MinePageState, ChangeSliderIndexAction>((state, action) => state..menuIndex = action.menuIndex),
  //记录滚动tab index
  TypedReducer<MinePageState, SetCurrentTab>((state, action) => state..currentTab = action.value),
  //
  TypedReducer<MinePageState, InitMineMenuTabInfoAction>((state, action) => state..menuTabInfo = action.menuTabInfo),
]);
