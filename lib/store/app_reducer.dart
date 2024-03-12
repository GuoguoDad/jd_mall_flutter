// Project imports:
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/login/redux/login_page_reducer.dart';

AppState reducers(AppState state, action) {
  return AppState(
    loginPageReducer(state.loginPageState, action),
  );
}
