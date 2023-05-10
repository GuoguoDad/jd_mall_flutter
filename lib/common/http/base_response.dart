class BaseResponse {
  int? code;
  String msg;
  var data;
  var headers;

  BaseResponse(this.code, this.msg, this.data, {this.headers});
}