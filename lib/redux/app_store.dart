import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/redux/app_reducer.dart';
import 'package:jd_mall_flutter/redux/app_state.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_state.dart';
import 'package:jd_mall_flutter/models/home_page_info.dart';

import '../page/welcome/redux/wel_page_middleware.dart';

final store = Store<AppState>(
  reducers,
  initialState: AppState(
    WelPageState(false, 0, 0, "1", HomePageInfo.fromJson({}), 1, GoodsPageInfo.fromJson({}))
  ),
  middleware: [
    WelPageMiddleware()
  ]
);