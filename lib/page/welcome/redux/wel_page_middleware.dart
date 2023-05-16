import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_action.dart';
import 'package:jd_mall_flutter/page/welcome/service.dart';

const pageSize = 16;

class WelPageMiddleware<WelPageState> implements MiddlewareClass<WelPageState> {
  @override
  call(Store<WelPageState> store, action, NextDispatcher next) {
    if(action is LoadAction) {
      Future.wait([WelcomeApi.queryHomeInfo(), WelcomeApi.queryGoodsListByPage(1, pageSize)]).then((res) => {
        store.dispatch(SetHomePageInfoAction(res[0])),
        store.dispatch(SetGoodsPageAction(2, res[1]))
      });
    }
    next(action);
  }
}