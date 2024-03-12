// Project imports:
import 'package:jd_mall_flutter/view/page/detail/redux/detail_page_state.dart';
import 'package:jd_mall_flutter/view/page/login/redux/login_page_state.dart';

class AppState {
  final DetailPageState detailPageState;
  final LoginPageState loginPageState;

  AppState(
    this.detailPageState,
    this.loginPageState,
  );
}
