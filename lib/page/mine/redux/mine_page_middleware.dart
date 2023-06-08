import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/page/mine/redux/mine_page_action.dart';
import 'package:jd_mall_flutter/page/mine/service.dart';
import 'package:jd_mall_flutter/common/constant/index.dart';

Future initData = Future.wait([MineApi.queryInfo(), MineApi.queryRecommendList(1, pageSize)]);

class MinePageMiddleware<MinePageState> implements MiddlewareClass<MinePageState> {
  @override
  call(Store<MinePageState> store, action, NextDispatcher next) {
    if (action is InitPageAction) {
      initData.then((res) => {
            if (res[0] != null && res[1] != null)
              {store.dispatch(InitMineMenuTabInfoAction(res[0])), store.dispatch(InitGoodsPageAction(1, res[1]))}
          });
    }
    if (action is RefreshAction) {
      initData.then((res) =>
          {store.dispatch(InitMineMenuTabInfoAction(res[0])), store.dispatch(InitGoodsPageAction(2, res[1])), action.freshSuccess()});
    }
    if (action is LoadMoreAction) {
      MineApi.queryRecommendList(action.currentPage, pageSize).then((res) {
        var totalPage = res.totalPageCount;

        if (totalPage >= action.currentPage) {
          store.dispatch(MoreGoodsPageAction(action.currentPage, res));
          action.loadMoreSuccess();
        } else {
          action.loadMoreFail();
        }
      });
    }
    next(action);
  }
}
