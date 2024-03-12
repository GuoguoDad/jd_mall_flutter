// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/util.dart';
import 'package:jd_mall_flutter/store/app_reducer.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/login/redux/login_page_state.dart';

final store = Store<AppState>(
  reducers,
  initialState: AppState(LoginPageState(isLogin())),
  middleware: [],
);
