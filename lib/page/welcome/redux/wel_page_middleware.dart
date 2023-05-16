import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_action.dart';
import 'package:jd_mall_flutter/page/welcome/service.dart';

class WelPageMiddleware<WelPageState> implements MiddlewareClass<WelPageState> {
  @override
  call(Store<WelPageState> store, action, NextDispatcher next) {
    if(action is LoadAction) {
      // print("===============middleware=========");
      WelcomeApi.queryHomeInfo().then((res) => {
        store.dispatch(SetHomePageInfoAction(res))
      });
    }
    next(action);
  }
}