import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/page/mine/redux/mine_page_action.dart';
import 'package:jd_mall_flutter/page/mine/service.dart';

class MinePageMiddleware<MinePageState> implements MiddlewareClass<MinePageState> {
  @override
  call(Store<MinePageState> store, action, NextDispatcher next) {
    if (action is InitPageAction) {
      MineApi.queryInfo().then((res) {
        store.dispatch(InitMineMenuTabInfoAction(res));
      });
    }
    next(action);
  }
}
