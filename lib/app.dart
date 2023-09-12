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
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/generated/l10n.dart';
import 'package:jd_mall_flutter/http/code.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/view/main/main_page.dart';
import 'package:jd_mall_flutter/observer/navigator_change_observer.dart';

class MallApp extends StatefulWidget {
  const MallApp({super.key});

  @override
  State<StatefulWidget> createState() => _FlutterReduxMallApp();
}

class _FlutterReduxMallApp extends State<MallApp> with HttpErrorListener {
  @override
  Widget build(BuildContext context) {
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
      child: MaterialApp(
        navigatorKey: navKey,
        navigatorObservers: [NavigatorChangeObserver()],
        theme: ThemeData(
          brightness: Brightness.light,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        initialRoute: MainPage.name,
        builder: EasyLoading.init(),
        routes: routesMap,
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
}

mixin HttpErrorListener on State<MallApp> {
  StreamSubscription? stream;

  GlobalKey<NavigatorState> navKey = GlobalKey();

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
    var context = navKey.currentContext!;
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
