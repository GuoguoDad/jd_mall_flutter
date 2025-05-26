// Package imports:
import 'package:get/get_state_manager/src/simple/get_state.dart';

// Project imports:
import 'package:jd_mall_flutter/view/page/cart/cart_controller.dart';
import 'package:jd_mall_flutter/view/page/category/category_controller.dart';
import 'package:jd_mall_flutter/view/page/home/home_controller.dart';
import 'package:jd_mall_flutter/view/page/login/login_controller.dart';
import 'package:jd_mall_flutter/view/page/mine/mine_controller.dart';

class MainBindings extends Binding {
  @override
  List<Bind> dependencies() => [
    Bind.put(() => HomeController()),
    Bind.lazyPut(() => CategoryController()),
    Bind.lazyPut(() => CartController()),
    Bind.lazyPut(() => MineController()),
    Bind.lazyPut(() => LoginController())
  ];
}
