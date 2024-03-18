// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class NavigatorChangeObserver<R extends Route<dynamic>> extends RouteObserver<R> {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (kDebugMode) {
      // print('didPush route: ${route.settings.name},  previousRoute:${previousRoute?.settings.name}');
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (kDebugMode) {
      // print('didPop route: ${route.settings.name},  previousRoute:${previousRoute?.settings.name}');
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (kDebugMode) {
      // print('didReplace newRoute: $newRoute,oldRoute:$oldRoute');
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    if (kDebugMode) {
      // print('didRemove route: $route,previousRoute:$previousRoute');
    }
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    if (kDebugMode) {
      // print('didStartUserGesture route: $route,previousRoute:$previousRoute');
    }
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    if (kDebugMode) {
      // print('didStopUserGesture');
    }
  }
}
