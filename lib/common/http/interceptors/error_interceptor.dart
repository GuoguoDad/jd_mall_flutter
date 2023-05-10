import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:jd_mall_flutter/common/http/base_response.dart';
import 'package:jd_mall_flutter/common/http/code.dart';

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
              data: BaseResponse(Code.NETWORK_ERROR,Code.errorHandleFunction(Code.NETWORK_ERROR, "", false),'')
          )
      ));
    }
    return super.onRequest(options, handler);
  }
}