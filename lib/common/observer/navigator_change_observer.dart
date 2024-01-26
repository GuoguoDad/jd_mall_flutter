// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:jd_mall_flutter/common/router/Router.dart';
import 'package:jd_mall_flutter/common/util/local_storage_util.dart';
import 'package:jd_mall_flutter/routes.dart';

class NavigatorChangeObserver<R extends Route<dynamic>> extends RouteObserver<R> {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    checkLogin(route.settings.name);
    if (kDebugMode) {
      print('didPush route: ${route.settings.name},  previousRoute:${previousRoute?.settings.name}');
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    checkLogin(route.settings.name);
    if (kDebugMode) {
      print('didPop route: ${route.settings.name},  previousRoute:${previousRoute?.settings.name}');
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    checkLogin(newRoute?.settings.name);
    if (kDebugMode) {
      print('didReplace newRoute: $newRoute,oldRoute:$oldRoute');
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    if (kDebugMode) {
      print('didRemove route: $route,previousRoute:$previousRoute');
    }
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    if (kDebugMode) {
      print('didStartUserGesture route: $route,previousRoute:$previousRoute');
    }
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    if (kDebugMode) {
      print('didStopUserGesture');
    }
  }

  void checkLogin(String? name) {
    if (loginRequiredRoutes.contains(name)) {
      LocalStorageUtil.getString("token").then(
        (value) => {
          if (value == null || value.isEmpty) {GlobalRouter.navigatorKey.currentState?.pushNamed(RoutesEnum.loginPage.path)}
        },
      );
    }
  }
}
