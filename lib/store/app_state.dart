import 'package:jd_mall_flutter/page/home/redux/home_page_state.dart';
import '../page/cart/redux/cart_page_state.dart';
import '../page/category/redux/category_page_state.dart';
import '../page/mine/redux/mine_page_state.dart';

class AppState {
  final HomePageState homePageState;
  final CategoryPageState categoryPageState;
  final CartPageState cartPageState;
  final MinePageState minePageState;

  AppState(this.homePageState, this.categoryPageState, this.cartPageState, this.minePageState);
}
