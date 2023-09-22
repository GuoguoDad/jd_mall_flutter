/// 3.10 之前
double dpr = WidgetsBinding.instance.window.devicePixelRatio;
Locale locale = WidgetsBinding.instance.window.locale;
double width =
MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;

/// 3.10 之后
double dpr = View.of(context).devicePixelRatio;
Locale locale = View.of(context).platformDispatcher.locale;
double width =
MediaQueryData.fromView(View.of(context)).size.width;

/// 3.10 之前
MediaQueryData.fromWindow(WidgetsBinding.instance.window)
/// 3.10 之后
MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first)
