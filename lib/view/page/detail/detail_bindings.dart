// Package imports:
import 'package:get/get_state_manager/src/simple/get_state.dart';

// Project imports:
import 'package:jd_mall_flutter/view/page/detail/detail_controller.dart';

class DetailBindings extends Binding {
  @override
  List<Bind> dependencies() => [
    Bind.lazyPut(() => DetailController())
  ];
}
