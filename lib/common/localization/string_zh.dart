import 'package:jd_mall_flutter/common/localization/string_base.dart';

class StringZh extends StringBase {
  @override
  String app_name = "商城";

  @override
  String network_error_401 = "[401错误可能: 未授权 \\ 授权登录失败 \\ 登录过期]";
  @override
  String network_error_403 = "403权限错误";
  @override
  String network_error_404 = "404错误";
  @override
  String network_error_422 = "请求实体异常，请确保 Github ClientId 、账号秘密等信息正确。";
  @override
  String network_error_timeout = "请求超时";
  @override
  String network_error_unknown = "其他异常";
  @override
  String network_error = "网络错误";
  @override
  String connnect_refused = "[Connection refused]，建议换个网络环境或者稍后再试";
  @override
  String load_more_not = "没有更多数据";
  @override
  String load_more_text = "正在加载更多";

  @override
  String tab_main_home = "首页";

  @override
  String tab_main_category = "分类";

  @override
  String tab_main_cart = "购物车";

  @override
  String tab_main_mine = "我的";

  @override
  String author = "GuoguoDad";
}
