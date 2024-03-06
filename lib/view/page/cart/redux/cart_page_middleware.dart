// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:jd_mall_flutter/common/constant/index.dart';
import 'package:jd_mall_flutter/models/cart_goods.dart';
import 'package:jd_mall_flutter/view/page/cart/redux/cart_page_action.dart';
import 'package:jd_mall_flutter/view/page/cart/service.dart';

Future initData = Future.wait([CartApi.queryCartGoods(), CartApi.queryGoodsListByPage(1, pageSize)]);

class CartPageMiddleware<CartPageState> implements MiddlewareClass<CartPageState> {
  @override
  call(Store<CartPageState> store, action, NextDispatcher next) {
    if (action is InitAction) {
      store.dispatch(SetLoadingAction(true));
      initData.then(
        (res) => {
          if (res[0] != null && res[1] != null)
            {store.dispatch(SetLoadingAction(false)), store.dispatch(InitCartGoodsAction(res[0])), store.dispatch(InitGoodsPageAction(1, res[1]))}
        },
      );
    }
    if (action is RefreshAction) {
      initData.then(
        (res) => {store.dispatch(InitCartGoodsAction(res[0].cast<CartGoods>())), store.dispatch(InitGoodsPageAction(1, res[1])), action.freshSuccess()},
      );
    }
    if (action is LoadMoreAction) {
      CartApi.queryGoodsListByPage(action.currentPage, pageSize).then(
        (res) {
          var totalPage = res.totalPageCount;

          if (totalPage >= action.currentPage) {
            store.dispatch(MoreGoodsPageAction(action.currentPage, res));
            action.loadMoreSuccess();
          } else {
            action.loadMoreFail();
          }
        },
      );
    }
    next(action);
  }
}
