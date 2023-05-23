import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/localization/string_base.dart';
import 'package:jd_mall_flutter/common/localization/string_en.dart';
import 'package:jd_mall_flutter/common/localization/string_zh.dart';

///自定义多语言实现
class MallLocalizations {
  final Locale locale;

  MallLocalizations(this.locale);

  ///根据不同 locale.languageCode 加载不同语言对应
  ///StringEn和StringZh都继承了StringBase
  static final Map<String, StringBase> _localizedValues = {
    'en': StringEn(),
    'zh': StringZh(),
  };

  StringBase get currentLocalized {
    if (_localizedValues.containsKey(locale.languageCode)) {
      return _localizedValues[locale.languageCode]!;
    }
    return _localizedValues["en"]!;
  }

  ///通过 Localizations 加载当前的 Localizations
  ///获取对应的 StringBase
  static MallLocalizations of(BuildContext context) {
    return Localizations.of(context, MallLocalizations);
  }

  ///通过 Localizations 加载当前的 Localizations
  ///获取对应的 StringBase
  static StringBase i18n(BuildContext context) {
    return (Localizations.of(context, MallLocalizations) as MallLocalizations).currentLocalized;
  }
}
