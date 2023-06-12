import 'package:jd_mall_flutter/view/page/home/redux/home_page_state.dart';
import 'package:jd_mall_flutter/view/page/cart/redux/cart_page_state.dart';
import 'package:jd_mall_flutter/view/page/mine/redux/mine_page_state.dart';
import 'package:jd_mall_flutter/view/page/category/redux/category_page_state.dart';
import 'package:jd_mall_flutter/view/page/detail/redux/detail_page_state.dart';

class AppState {
  final HomePageState homePageState;
  final CategoryPageState categoryPageState;
  final CartPageState cartPageState;
  final MinePageState minePageState;
  final DetailPageState detailPageState;

  AppState(this.homePageState, this.categoryPageState, this.cartPageState, this.minePageState, this.detailPageState);
}
