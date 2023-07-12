import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/view/main/main_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:jd_mall_flutter/common/event/http_error_event.dart';
import 'package:jd_mall_flutter/common/event/index.dart';
import 'package:jd_mall_flutter/http/code.dart';
import 'package:jd_mall_flutter/common/localization/default_localizations.dart';
import 'package:jd_mall_flutter/common/localization/localizations_delegate.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';

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
        theme: ThemeData(
          brightness: Brightness.light,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        initialRoute: MainPage.name,
        builder: EasyLoading.init(),
        routes: routesMap,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          RefreshLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          MallLocalizationsDelegate.delegate
        ],
        supportedLocales: const [
          // Locale('en', 'US'), // 美国英语
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
        showToast(MallLocalizations.i18n(context).network_error);
        break;
      case 401:
        showToast(MallLocalizations.i18n(context).network_error_401);
        break;
      case 403:
        showToast(MallLocalizations.i18n(context).network_error_403);
        break;
      case 404:
        showToast(MallLocalizations.i18n(context).network_error_404);
        break;
      case 422:
        showToast(MallLocalizations.i18n(context).network_error_422);
        break;
      case Code.NETWORK_TIMEOUT:
        showToast(MallLocalizations.i18n(context).network_error_timeout);
        break;
      case Code.CONNECTION_REFUSED:
        showToast(MallLocalizations.i18n(context).connnect_refused);
        break;
      default:
        showToast("${MallLocalizations.i18n(context).network_error_unknown} $message");
        break;
    }
  }

  showToast(String message) {
    EasyLoading.showInfo(message, duration: const Duration(seconds: 3));
  }
}
