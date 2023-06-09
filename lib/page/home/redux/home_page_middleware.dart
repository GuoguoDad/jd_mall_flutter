import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/page/home/redux/home_page_action.dart';
import 'package:jd_mall_flutter/page/home/service.dart';
import 'package:jd_mall_flutter/common/constant/index.dart';

Future initData = Future.wait([WelcomeApi.queryHomeInfo(), WelcomeApi.queryGoodsListByPage(1, pageSize)]);

class HomePageMiddleware<WelPageState> implements MiddlewareClass<WelPageState> {
  @override
  call(Store<WelPageState> store, action, NextDispatcher next) {
    if (action is InitDataAction) {
      store.dispatch(SetLoadingAction(true));
      initData.then((res) => {
            if (res[0] != null && res[1] != null)
              {
                store.dispatch(SetLoadingAction(false)),
                store.dispatch(SetHomePageInfoAction(res[0])),
                store.dispatch(InitGoodsPageAction(1, res[1]))
              }
          });
    }
    if (action is RefreshAction) {
      initData.then(
          (res) => {store.dispatch(SetHomePageInfoAction(res[0])), store.dispatch(InitGoodsPageAction(2, res[1])), action.freshSuccess()});
    }
    if (action is LoadMoreAction) {
      WelcomeApi.queryGoodsListByPage(action.currentPage, pageSize).then((res) {
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
