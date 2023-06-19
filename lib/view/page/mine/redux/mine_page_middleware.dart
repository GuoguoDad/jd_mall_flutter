import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/view/page/mine/redux/mine_page_action.dart';
import 'package:jd_mall_flutter/view/page/mine/service.dart';

Future initData = Future.wait([MineApi.queryInfo()]);

class MinePageMiddleware<MinePageState> implements MiddlewareClass<MinePageState> {
  @override
  call(Store<MinePageState> store, action, NextDispatcher next) {
    if (action is InitPageAction) {
      store.dispatch(SetLoadingAction(true));
      initData.then((res) => {
            if (res[0] != null) {store.dispatch(SetLoadingAction(false)), store.dispatch(InitMineMenuTabInfoAction(res[0]))}
          });
    }
    if (action is RefreshAction) {
      initData.then((res) => {store.dispatch(InitMineMenuTabInfoAction(res[0])), action.freshSuccess()});
    }
    next(action);
  }
}
