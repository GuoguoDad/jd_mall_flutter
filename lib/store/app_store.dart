// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/util.dart';
import 'package:jd_mall_flutter/models/goods_detail_res.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/store/app_reducer.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/detail/redux/detail_page_middleware.dart';
import 'package:jd_mall_flutter/view/page/detail/redux/detail_page_state.dart';
import 'package:jd_mall_flutter/view/page/login/redux/login_page_state.dart';

final store = Store<AppState>(
  reducers,
  initialState: AppState(
    DetailPageState(true, GoodsDetailRes.fromJson({}), BannerInfo.fromJson({}), 1, GoodsPageInfo.fromJson({})),
    LoginPageState(isLogin()),
  ),
  middleware: [
    DetailPageMiddleware().call,
  ],
);
