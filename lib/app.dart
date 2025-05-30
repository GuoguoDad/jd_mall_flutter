// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';
import 'package:jd_mall_flutter/view/main/main_bindings.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

// Project imports:
import 'package:jd_mall_flutter/common/event/http_error_event.dart';
import 'package:jd_mall_flutter/common/event/index.dart';
import 'package:jd_mall_flutter/common/global/Global.dart';
import 'package:jd_mall_flutter/common/observer/navigator_change_observer.dart';
import 'package:jd_mall_flutter/http/code.dart';
import 'package:jd_mall_flutter/routes.dart';
import 'package:jd_mall_flutter/translation/messages.dart';

class MallApp extends StatefulWidget {
  const MallApp({super.key});

  @override
  State<StatefulWidget> createState() => _FlutterMallApp();
}

class _FlutterMallApp extends State<MallApp> with HttpErrorListener {
  @override
  Widget build(BuildContext context) {
    return refreshConfig(
      child: GetMaterialApp(
        translations: Messages(),
        navigatorKey: Global.navigatorKey,
        navigatorObservers: [NavigatorChangeObserver()],
        theme: ThemeData(
          brightness: Brightness.light,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        getPages: appPages,
        initialRoute: RoutesEnum.mainPage.path,
        unknownRoute: unknownRoute,
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FormBuilderLocalizations.delegate,
          RefreshLocalizations.delegate
        ],
        locale: const Locale('zh', 'CN'),
        fallbackLocale: const Locale('en', 'US'),
        supportedLocales: const [
          Locale('en', 'US'), // 美国英语
          Locale('zh', 'CN'), // 中文简体
        ],
      ),
    );
  }

  Widget refreshConfig({required Widget child}) {
    double statusHeight = MediaQuery.viewPaddingOf(context).top;

    return RefreshConfiguration(
      footerTriggerDistance: 15,
      dragSpeedRatio: 0.91,
      headerTriggerDistance: 88 + statusHeight,
      headerBuilder: () => ClassicHeader(
        spacing: 10,
        height: 68 + statusHeight,
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
    switch (code) {
      case Code.NETWORK_ERROR:
        showToast("networkError".tr);
        break;
      case 401:
        showToast("networkError401".tr);
        break;
      case 403:
        showToast("networkError403".tr);
        break;
      case 404:
        showToast("networkError404".tr);
        break;
      case 422:
        showToast("networkError422".tr);
        break;
      case Code.NETWORK_TIMEOUT:
        showToast("networkErrorTimeout".tr);
        break;
      case Code.CONNECTION_REFUSED:
        showToast("connectRefused".tr);
        break;
      default:
        showToast("${"networkErrorUnknown".tr} $message");
        break;
    }
  }

  showToast(String message) {
    EasyLoading.showInfo(message, duration: const Duration(seconds: 3));
  }
}
