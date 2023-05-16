import 'package:jd_mall_flutter/redux/app_state.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_reducer.dart';

AppState reducers(AppState state, action) {
  return AppState(
      welPageReducer(state.welPageState, action)
  );
}