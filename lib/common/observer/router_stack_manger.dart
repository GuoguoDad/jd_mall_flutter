class RouterStackManager {
  static final RouterStackManager _instance = RouterStackManager._internal();

  factory RouterStackManager() {
    return _instance;
  }

  RouterStackManager._internal();

  final List<String> _routeNames = [];

  void pushRouterByName(String routeName) {
    _routeNames.add(routeName);
  }

  void removeRouterByName(String routeName) {
    if (_routeNames.contains(routeName)) {
      _routeNames.remove(routeName);
    }
  }

  List<String?> get routeNames => _routeNames;

  bool isRouteExist(String routeName) {
    return _routeNames.contains(routeName);
  }
}
