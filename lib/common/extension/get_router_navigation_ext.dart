import 'package:get/get.dart';
import 'package:jd_mall_flutter/common/observer/router_stack_manger.dart';

extension GetRouterNavigation on GetInterface {
  //查询指定的RouterName是否存在自己的路由栈中
  bool isRouteExist(String routerName) {
    return RouterStackManager().isRouteExist(routerName);
  }

  //判断是否栈顶路由
  bool isTopRoute(String routerName) {
    return RouterStackManager().isTopRoute(routerName);
  }

  //SingleTask模式pop页面，适用场景:  登录后跳转
  void popNamedSingleTask(String routerName, {dynamic arguments, void Function(dynamic value)? callback}) {
    if (isRouteExist(routerName)) {
      Get.until((route) => route.name == routerName);
    } else {
      Get.offNamed(routerName, arguments: arguments)?.then(
        (value) => {
          if (callback != null) {callback(value)}
        },
      );
    }
  }

  //SingleTop模式跳转页面，适用场景:  推送信息跳转
  void toNamedSingleTop(String routerName, {dynamic arguments, void Function(dynamic value)? callback}) {
    if (isTopRoute(routerName)) {
      Get.until((route) => route.name == routerName);
    } else {
      Get.offNamed(routerName, arguments: arguments)?.then(
        (value) => {
          if (callback != null) {callback(value)}
        },
      );
    }
  }
}
