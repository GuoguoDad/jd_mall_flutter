// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jd_mall_flutter/view/page/cart/cart_provider.dart';
import 'package:jd_mall_flutter/view/page/category/category_provider.dart';
import 'package:jd_mall_flutter/view/page/detail/detail_provider.dart';
import 'package:jd_mall_flutter/view/page/home/home_provider.dart';
import 'package:jd_mall_flutter/view/page/mine/mine_provider.dart';
import 'package:provider/provider.dart';

// Package imports:
import 'package:sentry_flutter/sentry_flutter.dart';

// Project imports:
import 'package:jd_mall_flutter/app.dart';
import 'package:jd_mall_flutter/common/constant/index.dart';
import 'package:jd_mall_flutter/common/global/Global.dart';
import 'package:jd_mall_flutter/config/env_config.dart' as configs;
import 'package:jd_mall_flutter/config/global_configs.dart';

void initApp(Map<String, dynamic> envMap) async {
  WidgetsFlutterBinding.ensureInitialized();
  GlobalConfigs().loadFromMap(envMap);
  await Global.initPreferences();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => MineProvider()),
        ChangeNotifierProvider(create: (_) => DetailProvider()),
      ],
      child: const MallApp()
  ));

  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

Future<void> main() async {
  if (kReleaseMode) {
    runZonedGuarded(() async {
      await SentryFlutter.init(
        (options) {
          options.dsn = sentryDsn;
        },
      );
      initApp(configs.prd);
    }, (exception, stackTrace) async {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    });
  } else {
    initApp(configs.prd);
  }
}
