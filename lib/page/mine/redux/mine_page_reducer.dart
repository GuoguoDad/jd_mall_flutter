import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/page/mine/redux/mine_page_action.dart';
import 'package:jd_mall_flutter/page/mine/redux/mine_page_state.dart';

final minePageReducer = combineReducers<MinePageState>([
  //记录页面滚动距离
  TypedReducer<MinePageState, ChangePageScrollYAction>((state, action) => state..pageScrollY = action.value),
  //记录九宫格菜单滚动index
  TypedReducer<MinePageState, ChangeSliderIndexAction>((state, action) {
    return state..menuIndex = action.menuIndex;
  }),
  //
  TypedReducer<MinePageState, InitMineMenuTabInfoAction>((state, action) {
    return state..menuTabInfo = action.menuTabInfo;
  })
]);
