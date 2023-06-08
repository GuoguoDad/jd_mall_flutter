import 'package:redux/redux.dart';
import '../../mine/redux/mine_page_action.dart';
import 'mine_page_state.dart';

final minePageReducer = combineReducers<MinePageState>([
  //记录页面滚动距离
  TypedReducer<MinePageState, ChangePageScrollYAction>((state, action) => state..pageScrollY = action.value),
]);
