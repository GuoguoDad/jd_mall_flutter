// Package imports:
import 'package:get/get_state_manager/src/simple/get_state.dart';

// Project imports:
import 'package:jd_mall_flutter/view/page/login/login_controller.dart';

class LoginBindings extends Binding {
  @override
  List<Bind> dependencies() => [
    Bind.lazyPut(() => LoginController())
  ];
}
