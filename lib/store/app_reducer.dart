// Project imports:
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/detail/redux/detail_page_reducer.dart';
import 'package:jd_mall_flutter/view/page/login/redux/login_page_reducer.dart';
import 'package:jd_mall_flutter/view/page/mine/redux/mine_page_reducer.dart';

AppState reducers(AppState state, action) {
  return AppState(
    minePageReducer(state.minePageState, action),
    detailPageReducer(state.detailPageState, action),
    loginPageReducer(state.loginPageState, action),
  );
}
