import 'package:dio/dio.dart';
import 'package:jd_mall_flutter/common/util/util.dart';
import 'package:jd_mall_flutter/http/code.dart';

class DebounceInterceptor extends Interceptor {
  static final Map<String, CancelToken> _cancelTokenMap = {}; // 保存每个请求的 CancelToken
  static final Map<String, String> _urlParamsMap = {}; // 保存每个请求的url与params的序列化对应关系

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Map<String, dynamic>? parameters;
    final url = options.uri.path;
    final method = options.method;
    CancelToken? cancelToken = options.cancelToken;
    Map<String, dynamic> headers = options.headers;

    if (headers['network_debounce'] != null && headers['network_debounce'] == 'true') {
      //需要处理请求防抖去重
      parameters = _generateParameters(method, options);
      _handleNetworkDebounce(url, method, parameters, cancelToken, options, handler);
    } else {
      // 处理去重
      super.onRequest(options, handler);
    }
  }

  //根据请求方式生成不同的参数格式
  Map<String, dynamic>? _generateParameters(String method, RequestOptions options) {
    if (method == 'GET') {
      return options.queryParameters;
    } else if (method == 'POST' && options.data is FormData) {
      final formData = options.data as FormData;
      //临时Map
      final Map<String, dynamic> map = {};
      // 添加 formData.fields 到映射中
      for (var field in formData.fields) {
        map[field.key] = field.value;
      }
      // 添加 formData.files 的键和文件长度到映射中
      for (var file in formData.files) {
        logger.d("当前文件 key:${file.key} length:${file.value.length}");
        map[file.key] = file.value.length;
      }
      return map;
    } else {
      return null;
    }
  }

  //添加CancelToken的逻辑
  void addCancelToken(
    String url,
    String method,
    Map<String, dynamic>? params,
    CancelToken? cancelToken,
    RequestOptions options,
  ) {
    final cancelKey = _generateCacelKey(method, url, params);
    cancelToken ??= CancelToken();
    _cancelTokenMap[cancelKey] = cancelToken;
    options.cancelToken = cancelToken;
  }

  //移除CancelToken的逻辑
  void removeCancelToken(
    String url,
    String method,
    Map<String, dynamic>? params,
  ) {
    //自动添加CancelToken的逻辑
    final cancelKey = _generateCacelKey(method, url, params);
    if (_cancelTokenMap[cancelKey] != null) {
      _cancelTokenMap.remove(cancelKey);
    }
  }

  void _handleNetworkDebounce(
    String url,
    String method,
    Map<String, dynamic>? params,
    CancelToken? cancelToken,
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (params == null) {
      //无需处理去重
      handler.next(options);
    } else {
      addCancelToken(url, method, params, cancelToken, options);
      //加CancelToken之后
      //拿到当前的url对应的Map中的数据
      final urlkey = _generateKeyByMethodUrl(method, url);
      logger.d("请求前先查询 _urlParamsMap 集合目前的数据:${_urlParamsMap.toString()} _cancelTokenMap：${_cancelTokenMap.toString()}");
      final preSerializedParams = _urlParamsMap[urlkey];
      final curSerializedParams = _serializeAllParams(params);
      logger.d("已缓存的请求参数Value cachedValue:${preSerializedParams.toString()} 当前正在发起的请求的参数Value:${curSerializedParams.toString()}");

      if (preSerializedParams == null) {
        //说明没有缓存，添加缓存
        _urlParamsMap[urlkey] = curSerializedParams;
        //正常请求
        handler.next(options);
      } else {
        //有缓存对比
        if (curSerializedParams == preSerializedParams) {
          //如果两者相同，说明是重复的请求，舍弃当前的请求
          logger.d("是重复的请求，舍弃当前的请求");
          handler.resolve(Response(
            statusCode: Code.NETWORK_DEBOUNCE,
            statusMessage: 'Request canceled',
            requestOptions: RequestOptions(),
          ));
        } else {
          //如果两者不相，说明不是重复的请求，需要取消之前的网络请求，发起新的请求
          logger.d("不是重复的请求，需要取消之前的网络请求，发起新的请求");
          //拿到当前请求的cancelToken
          final previousCancekKey = "$urlkey - $preSerializedParams";
          final previousCancelToken = _cancelTokenMap[previousCancekKey];
          if (previousCancelToken != null) {
            previousCancelToken.cancel('Request canceled');
            _urlParamsMap.remove(urlkey);
            _cancelTokenMap.remove(previousCancekKey);
          }

          //添加缓存
          _urlParamsMap[urlkey] = curSerializedParams;

          //加CancelToken之后正常请求
          addCancelToken(url, method, params, cancelToken, options);
          handler.next(options);
        }
      }
    }
  }

  //根据请求方式和Url生成Key
  String _generateKeyByMethodUrl(String method, String url) {
    return "$method - $url";
  }

  //CancelToken Map 的 Key 生成
  String _generateCacelKey(String method, String url, Map<String, dynamic>? map) {
    return "${_generateKeyByMethodUrl(method, url)} - ${_serializeAllParams(map)}";
  }

  //参数序列化为唯一字符串
  String _serializeAllParams(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return '';
    }
    return map.toString();
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handleEndWithRequestOption(response.requestOptions);
    super.onResponse(response, handler);
  }

  void handleEndWithRequestOption(RequestOptions requestOptions) {
    final Map<String, dynamic> requestHeaders = requestOptions.headers;

    if (requestHeaders['network_debounce'] != null && requestHeaders['network_debounce'] == 'true') {
      //请求完成之后移除CancelToken，和 Params Map
      final url = requestOptions.uri.path;
      final method = requestOptions.method;
      Map<String, dynamic>? params = _generateParameters(method, requestOptions);

      final urlkey = _generateKeyByMethodUrl(method, url);
      _urlParamsMap.remove(urlkey);

      removeCancelToken(url, method, params);

      logger.d("网络请求去重的全部流程完成，移除Map内存缓存完成");
    }
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    //请求错误也需要处理清除缓存和Loading的逻辑
    handleEndWithRequestOption(err.requestOptions);
    super.onError(err, handler);
  }
}
