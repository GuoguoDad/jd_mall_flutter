import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/store/app_store.dart';
import 'package:jd_mall_flutter/app.dart';
import 'package:jd_mall_flutter/common/constant/index.dart';

Future<void> main() async {
  // runZonedGuarded(() async {
  //   await SentryFlutter.init(
  //     (options) {
  //       options.dsn = sentryDsn;
  //     },
  //   );
  //   runApp(StoreProvider<AppState>(store: store, child: const MallApp()));
  //   if (Platform.isAndroid) {
  //     // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
  //     SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  //     SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  //   }
  // }, (exception, stackTrace) async {
  //   await Sentry.captureException(exception, stackTrace: stackTrace);
  // });

  runApp(StoreProvider<AppState>(store: store, child: const MallApp()));
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
