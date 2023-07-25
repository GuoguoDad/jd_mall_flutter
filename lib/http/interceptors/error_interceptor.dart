// Package imports:
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:jd_mall_flutter/http/base_response.dart';
import 'package:jd_mall_flutter/http/code.dart';

class ErrorInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, handler) async {
    //没有网络
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return handler.reject(DioError(
          requestOptions: options,
          type: DioErrorType.unknown,
          response: Response(
              requestOptions: options,
              data: BaseResponse(
                  code: Code.NETWORK_ERROR.toString(), msg: Code.errorHandleFunction(Code.NETWORK_ERROR, "", false), data: null))));
    }
    return super.onRequest(options, handler);
  }
}
