import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/redux/action/wel_page_action.dart';
import 'package:jd_mall_flutter/redux/state/wel_page_state.dart';

final welPageReducer = combineReducers<WelPageState>([
  TypedReducer<WelPageState, ChangePageScrollYAction>((state, action) =>
      WelPageState(action.value, state.menuSliderIndex, state.homePageInfo)),
  TypedReducer<WelPageState, SetMenuSliderIndex>((state, action) =>
      WelPageState(state.pageScrollY, action.value, state.homePageInfo)),
]);