// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:jd_mall_flutter/view/page/login/redux/login_page_action.dart';
import 'package:jd_mall_flutter/view/page/login/redux/login_page_state.dart';

final loginPageReducer = combineReducers<LoginPageState>([
  TypedReducer<LoginPageState, SetLoginInfo>((state, action) => state..isLogin = action.isLogin).call,
]);
