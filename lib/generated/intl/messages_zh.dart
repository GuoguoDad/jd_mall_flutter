// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("商城"),
        "author": MessageLookupByLibrary.simpleMessage("GuoguoDad"),
        "connectRefused": MessageLookupByLibrary.simpleMessage(
            "[Connection refused]. Please switch networks or try again later "),
        "loadMoreNot": MessageLookupByLibrary.simpleMessage("nothing"),
        "loadMoreText": MessageLookupByLibrary.simpleMessage("加载中"),
        "networkError": MessageLookupByLibrary.simpleMessage("网络错误"),
        "networkError401": MessageLookupByLibrary.simpleMessage(
            "[401错误可能: 未授权 \\\\ 授权登录失败 \\\\ 登录过期]"),
        "networkError403": MessageLookupByLibrary.simpleMessage("403权限错误"),
        "networkError404": MessageLookupByLibrary.simpleMessage("404错误"),
        "networkError422": MessageLookupByLibrary.simpleMessage(
            "请求实体异常，请确保 Github ClientId 、账号秘密等信息正确。"),
        "networkErrorTimeout": MessageLookupByLibrary.simpleMessage("请求超时"),
        "networkErrorUnknown": MessageLookupByLibrary.simpleMessage("其他异常"),
        "tabMainCart": MessageLookupByLibrary.simpleMessage("购物车"),
        "tabMainCategory": MessageLookupByLibrary.simpleMessage("分类"),
        "tabMainHome": MessageLookupByLibrary.simpleMessage("首页"),
        "tabMainMine": MessageLookupByLibrary.simpleMessage("我的")
      };
}
