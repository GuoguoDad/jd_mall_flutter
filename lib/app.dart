// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Project imports:
import 'package:jd_mall_flutter/common/event/http_error_event.dart';
import 'package:jd_mall_flutter/common/event/index.dart';
import 'package:jd_mall_flutter/common/global/Global.dart';
import 'package:jd_mall_flutter/common/observer/navigator_change_observer.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/generated/l10n.dart';
import 'package:jd_mall_flutter/http/code.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/common/util/util.dart';

class MallApp extends StatefulWidget {
  const MallApp({super.key});

  @override
  State<StatefulWidget> createState() => _FlutterMallApp();
}

class _FlutterMallApp extends State<MallApp> with HttpErrorListener {
  @override
  Widget build(BuildContext context) {
    return refreshConfig(
      child: MaterialApp(
        navigatorKey: Global.navigatorKey,
        navigatorObservers: [NavigatorChangeObserver()],
        theme: ThemeData(
          brightness: Brightness.light,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        initialRoute: RoutesEnum.mainPage.path,
        builder: EasyLoading.init(),
        onGenerateRoute: onGenerateRoute,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FormBuilderLocalizations.delegate,
          RefreshLocalizations.delegate,
          S.delegate,
        ],
        locale: const Locale('zh', 'CN'),
        supportedLocales: const [
          Locale('en', 'US'), // 美国英语
          Locale('zh', 'CN'), // 中文简体
        ],
      ),
    );
  }

  Widget refreshConfig({required Widget child}) {
    return RefreshConfiguration(
      footerTriggerDistance: 15,
      dragSpeedRatio: 0.91,
      headerTriggerDistance: 88 + getStatusHeight(context),
      headerBuilder: () => ClassicHeader(
        spacing: 10,
        height: 68 + getStatusHeight(context),
      ),
      footerBuilder: () => const ClassicFooter(),
      enableLoadingWhenNoData: false,
      enableRefreshVibrate: false,
      enableLoadMoreVibrate: false,
      enableBallisticLoad: true,
      child: child,
    );
  }
}

mixin HttpErrorListener on State<MallApp> {
  StreamSubscription? stream;

  @override
  void initState() {
    super.initState();
    stream = eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream!.cancel();
      stream = null;
    }
  }

  errorHandleFunction(int? code, message) {
    var context = Global.navigatorKey.currentContext!;
    switch (code) {
      case Code.NETWORK_ERROR:
        showToast(S.of(context).networkError);
        break;
      case 401:
        showToast(S.of(context).networkError401);
        break;
      case 403:
        showToast(S.of(context).networkError403);
        break;
      case 404:
        showToast(S.of(context).networkError404);
        break;
      case 422:
        showToast(S.of(context).networkError422);
        break;
      case Code.NETWORK_TIMEOUT:
        showToast(S.of(context).networkErrorTimeout);
        break;
      case Code.CONNECTION_REFUSED:
        showToast(S.of(context).connectRefused);
        break;
      default:
        showToast("${S.of(context).networkErrorUnknown} $message");
        break;
    }
  }

  showToast(String message) {
    EasyLoading.showInfo(message, duration: const Duration(seconds: 3));
  }
}

var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  Object? arguments = settings.arguments;

  Function pageBuilder;
  bool toLogin = false;

  if (loginRequiredRoutes.contains(name) && !isLogin()) {
    toLogin = true;
  }

  Object? params;
  if (toLogin) {
    pageBuilder = routesMap[RoutesEnum.loginPage.path] as Function;
    params = {"from": name!, "args": arguments};
  } else {
    params = arguments;
    if (routesMap[name] != null) {
      pageBuilder = routesMap[name] as Function;
    } else {
      pageBuilder = routesMap[RoutesEnum.notFound.path] as Function;
    }
  }
  return MaterialPageRoute(
    settings: RouteSettings(name: name, arguments: params),
    builder: (context) => params != null ? pageBuilder(context, arguments: params) : pageBuilder(context),
  );
};
