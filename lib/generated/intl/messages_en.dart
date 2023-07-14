// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("Mall"),
        "author": MessageLookupByLibrary.simpleMessage("GuoguoDad"),
        "connectRefused": MessageLookupByLibrary.simpleMessage(
            "[Connection refused]. Please switch networks or try again later "),
        "loadMoreNot": MessageLookupByLibrary.simpleMessage("nothing"),
        "loadMoreText": MessageLookupByLibrary.simpleMessage("loading"),
        "networkError": MessageLookupByLibrary.simpleMessage("network error"),
        "networkError401": MessageLookupByLibrary.simpleMessage("Http 401"),
        "networkError403": MessageLookupByLibrary.simpleMessage("Http 403"),
        "networkError404": MessageLookupByLibrary.simpleMessage("Http 404"),
        "networkError422": MessageLookupByLibrary.simpleMessage(
            "Request Body Error，Please Check Github ClientId or Account/PW"),
        "networkErrorTimeout":
            MessageLookupByLibrary.simpleMessage("Http timeout"),
        "networkErrorUnknown":
            MessageLookupByLibrary.simpleMessage("Http unknown error"),
        "tabMainCart": MessageLookupByLibrary.simpleMessage("cart"),
        "tabMainCategory": MessageLookupByLibrary.simpleMessage("category"),
        "tabMainHome": MessageLookupByLibrary.simpleMessage("home"),
        "tabMainMine": MessageLookupByLibrary.simpleMessage("mine")
      };
}
