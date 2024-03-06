// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:jd_mall_flutter/view/page/home/redux/home_page_action.dart';
import 'package:jd_mall_flutter/view/page/home/service.dart';

class HomePageMiddleware<WelPageState> implements MiddlewareClass<WelPageState> {
  @override
  call(Store<WelPageState> store, action, NextDispatcher next) {
    if (action is InitDataAction) {
      store.dispatch(SetLoadingAction(true));
      HomeApi.queryHomeInfo().then(
        (res) => {
          if (res != null) {store.dispatch(SetLoadingAction(false)), store.dispatch(SetHomePageInfoAction(res))}
        },
      );
    }
    if (action is RefreshAction) {
      HomeApi.queryHomeInfo().then(
        (res) => {
          if (res != null) {store.dispatch(SetHomePageInfoAction(res)), action.freshSuccess()} else action.freshFail()
        },
      );
    }
    next(action);
  }
}
