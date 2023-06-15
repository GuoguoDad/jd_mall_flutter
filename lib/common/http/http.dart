import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:jd_mall_flutter/common/http/base_response.dart';
import 'package:jd_mall_flutter/common/http/code.dart';
import 'package:jd_mall_flutter/common/http/interceptors/error_interceptor.dart';
import 'package:jd_mall_flutter/common/http/interceptors/logs_interceptors.dart';
import 'package:jd_mall_flutter/common/http/interceptors/response_interceptor.dart';
import 'package:jd_mall_flutter/common/http/interceptors/token_Interceptor.dart';

class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORMDATA = "multipart/form-data";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  final Dio _dio = Dio(); // 使用默认配置

  HttpManager() {
    _dio.interceptors.add(TokenInterceptors());
    _dio.interceptors.add(LogsInterceptors());
    _dio.interceptors.add(ErrorInterceptors());
    _dio.interceptors.add(ResponseInterceptors());
  }

  Future<BaseResponse?> request<T>(String url, params, Options option, bool? noTip) async {
    noTip ??= false;
    option.headers ??= HashMap();
    option.headers!['content-type'] = CONTENT_TYPE_JSON;
    option.headers!['accept'] = CONTENT_TYPE_JSON;
    option.headers!['connectTimeout'] = 30000;
    option.headers!['receiveTimeout'] = 30000;

    exceptionHandler(DioError err) {
      Response? errResponse;
      if (err.response != null) {
        errResponse = err?.response;
      } else {
        errResponse = Response(statusCode: err.response?.statusCode, requestOptions: RequestOptions(path: url));
      }
      if (err.type == DioErrorType.connectionTimeout || err.type == DioErrorType.receiveTimeout) {
        errResponse!.statusCode = Code.NETWORK_TIMEOUT;
      }
      return BaseResponse(
          code: Code.errorHandleFunction(errResponse?.statusCode, err.response?.toString() ?? err.error.toString(), false),
          msg: err.message,
          data: null);
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      return exceptionHandler(e);
    }
    if (response.data is DioError) {
      return exceptionHandler(response.data as DioError);
    }
    return BaseResponse<T>.fromJson(response.data?.data as Map<String, dynamic>);
  }

  ///get发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ option] 配置
  Future<BaseResponse?> get<T>(String url, params, Options? option, bool? noTip) async {
    option ??= Options();
    option.method = "get";
    return await request<T>(url, params, option, noTip);
  }

  ///post发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ option] 配置
  Future<BaseResponse?> post<T>(String url, params, Options? option, bool? noTip) async {
    option ??= Options();
    option.method = "post";
    return await request<T>(url, params, option, noTip);
  }
}

final HttpManager httpManager = HttpManager();
