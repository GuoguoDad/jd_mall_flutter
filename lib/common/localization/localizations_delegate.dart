import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'default_localizations.dart';

/// 多语言代理
class MallLocalizationsDelegate extends LocalizationsDelegate<MallLocalizations> {
  MallLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    ///支持中文和英语
    return true;
  }

  ///根据locale，创建一个对象用于提供当前locale下的文本显示
  @override
  Future<MallLocalizations> load(Locale locale) {
    return SynchronousFuture<MallLocalizations>(MallLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<MallLocalizations> old) {
    return false;
  }

  ///全局静态的代理
  static LocalizationsDelegate<MallLocalizations> delegate = MallLocalizationsDelegate();
}
