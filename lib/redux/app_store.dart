import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/redux/app_reducer.dart';
import 'package:jd_mall_flutter/redux/app_state.dart';
import 'package:jd_mall_flutter/redux/state/wel_page_state.dart';
import 'package:jd_mall_flutter/model/HomePageInfo.dart';

final store = Store<AppState>(
  reducers,
  initialState: AppState(
    WelPageState(0, 0, HomePageInfo.empty())
  ),
);