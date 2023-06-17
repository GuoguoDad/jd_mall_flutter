import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/view/page/home/redux/home_page_action.dart';
import 'package:jd_mall_flutter/view/page/home/service.dart';

Future initData = Future.wait([WelcomeApi.queryHomeInfo()]);

class HomePageMiddleware<WelPageState> implements MiddlewareClass<WelPageState> {
  @override
  call(Store<WelPageState> store, action, NextDispatcher next) {
    if (action is InitDataAction) {
      store.dispatch(SetLoadingAction(true));
      initData.then((res) => {
            if (res[0] != null) {store.dispatch(SetLoadingAction(false)), store.dispatch(SetHomePageInfoAction(res[0]))}
          });
    }
    if (action is RefreshAction) {
      initData.then((res) => {
            if (res[0] != null) {store.dispatch(SetHomePageInfoAction(res[0])), action.freshSuccess()} else action.freshFail()
          });
    }
    next(action);
  }
}
