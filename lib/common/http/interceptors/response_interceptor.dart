import 'package:dio/dio.dart';
import 'package:jd_mall_flutter/common/http/base_response.dart';
import 'package:jd_mall_flutter/common/http/code.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response, handler) async {
    RequestOptions option = response.requestOptions;
    var value;
    try {
      var header = response.headers[Headers.contentTypeHeader];
      if ((header != null && header.toString().contains("text"))) {
        value = BaseResponse(Code.SUCCESS, '', response.data);
      } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
        value = BaseResponse(Code.SUCCESS, '', response.data, headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + option.path);
      value = BaseResponse(response.statusCode, '', response.data,
          headers: response.headers);
    }
    response.data = value;
    return handler.next(response);
  }
}