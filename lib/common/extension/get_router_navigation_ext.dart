import 'package:get/get.dart';
import 'package:jd_mall_flutter/common/observer/router_stack_manger.dart';

extension GetRouterNavigation on GetInterface {
  //查询指定的RouterName是否存在自己的路由栈中
  bool isRouteExist(String routerName) {
    return RouterStackManager().isRouteExist(routerName);
  }

  //SingleTask模式pop页面
  void popNamedSingleTask(String routerName, dynamic arguments, void Function(dynamic value)? callback) {
    if (isRouteExist(routerName)) {
      Get.until((route) => route.settings.name == routerName);
    } else {
      Get.offNamed(routerName, arguments: arguments)?.then(
        (value) => {
          if (callback != null) {callback(value)}
        },
      );
    }
  }
}
