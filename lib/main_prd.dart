// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// Project imports:
import 'package:jd_mall_flutter/app.dart';
import 'package:jd_mall_flutter/common/constant/index.dart';
import 'package:jd_mall_flutter/config/env_config.dart' as configs;
import 'package:jd_mall_flutter/config/global_configs.dart';
import 'package:jd_mall_flutter/store/app_state.dart';
import 'package:jd_mall_flutter/store/app_store.dart';
import 'package:jd_mall_flutter/common/global/Global.dart';

void initApp(Map<String, dynamic> envMap) {
  WidgetsFlutterBinding.ensureInitialized();
  GlobalConfigs().loadFromMap(envMap);

  runApp(
    StoreProvider<AppState>(
      store: store,
      child: const MallApp(),
    ),
  );
  Global.initPreferences();
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
