// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:jd_mall_flutter/common/observer/router_stack_manger.dart';

import '../util/util.dart';

class NavigatorChangeObserver<R extends Route<dynamic>> extends RouteObserver<R> {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    RouterStackManager().pushRouterByName(route.settings.name!);
    if (kDebugMode) {
      logger.d("after push current router stack:${RouterStackManager().routeNames.toString()}");
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    RouterStackManager().removeRouterByName(route.settings.name!);
    if (kDebugMode) {
      logger.d("after pop current router stack:${RouterStackManager().routeNames.toString()}");
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    RouterStackManager().pushRouterByName(newRoute!.settings.name!);
    RouterStackManager().removeRouterByName(oldRoute!.settings.name!);
    if (kDebugMode) {
      logger.d("after replace current router stack:${RouterStackManager().routeNames.toString()}");
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    RouterStackManager().removeRouterByName(route.settings.name!);
    if (kDebugMode) {
      logger.d("pop后 current router stack:${RouterStackManager().routeNames.toString()}");
    }
  }
}
