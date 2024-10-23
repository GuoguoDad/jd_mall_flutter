// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:jd_mall_flutter/common/observer/router_stack_manger.dart';
import '../util/util.dart';

class NavigatorChangeObserver<R extends Route<dynamic>> extends RouteObserver<R> {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if(route.settings.name != null) {
      RouterStackManager().pushRouterByName(route.settings.name!);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if(route.settings.name != null) {
      RouterStackManager().removeRouterByName(route.settings.name!);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if(newRoute?.settings.name != null) {
      RouterStackManager().pushRouterByName(newRoute!.settings.name!);
    }
    if(oldRoute?.settings.name != null) {
      RouterStackManager().removeRouterByName(oldRoute!.settings.name!);
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    if(route.settings.name != null) {
      RouterStackManager().removeRouterByName(route.settings.name!);
    }
  }
}
