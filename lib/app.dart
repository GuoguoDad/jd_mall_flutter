import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jd_mall_flutter/view/main/main_page.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common/event/http_error_event.dart';
import 'common/event/index.dart';
import 'common/http/code.dart';
import 'common/localization/default_localizations.dart';
import 'common/localization/localizations_delegate.dart';

class MallApp extends StatefulWidget {
  const MallApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FlutterReduxMallApp();
  }
}

class _FlutterReduxMallApp extends State<MallApp> with HttpErrorListener {
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
        footerTriggerDistance: 15,
        dragSpeedRatio: 0.91,
        headerTriggerDistance: 88 + MediaQueryData.fromView(View.of(context)).padding.top,
        headerBuilder: () => ClassicHeader(
              spacing: 10,
              height: 68 + MediaQueryData.fromView(View.of(context)).padding.top,
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
          routes: {MainPage.name: (context) => const MainPage(), DetailPage.name: (context) => const DetailPage()},
          home: const MainPage(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            // this line is important
            RefreshLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            MallLocalizationsDelegate.delegate
          ],
          supportedLocales: const [
            Locale('en', 'US'), // 美国英语
            Locale('zh', 'CN'), // 中文简体
          ],
        ));
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
    Fluttertoast.showToast(msg: message, gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_LONG);
  }
}
