// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/app.dart';
import 'package:jd_mall_flutter/common/event/http_error_event.dart';
import 'package:jd_mall_flutter/common/event/index.dart';
import 'package:jd_mall_flutter/http/code.dart';

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
