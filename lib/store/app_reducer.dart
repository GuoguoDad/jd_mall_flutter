import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/view/page/home/redux/home_page_reducer.dart';
import 'package:jd_mall_flutter/view/page/cart/redux/cart_page_reducer.dart';
import 'package:jd_mall_flutter/view/page/category/redux/category_page_reducer.dart';
import 'package:jd_mall_flutter/view/page/mine/redux/mine_page_reducer.dart';

AppState reducers(AppState state, action) {
  return AppState(homePageReducer(state.homePageState, action), categoryPageReducer(state.categoryPageState, action),
      cartPageReducer(state.cartPageState, action), minePageReducer(state.minePageState, action));
}
