// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/local_storage_util.dart';

class TokenInterceptors extends InterceptorsWrapper {
  String? _token;

  @override
  onRequest(RequestOptions options, handler) async {
    if (_token == null) {
      var authorizationCode = await LocalStorageUtil.getString("token");
      if (authorizationCode != null) {
        _token = authorizationCode;
      }
    }
    if (_token != null) {
      options.headers["Authorization"] = _token;
    }
    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, handler) async {
    try {
      var responseJson = response.data;
      if (response.statusCode == 201 && responseJson["token"] != null) {
        _token = responseJson["token"];
        await LocalStorageUtil.save("token", _token);
      }
    } catch (e) {
      print(e);
    }
    return super.onResponse(response, handler);
  }
}
