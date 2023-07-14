// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Mall`
  String get appName {
    return Intl.message(
      'Mall',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Http 401`
  String get networkError401 {
    return Intl.message(
      'Http 401',
      name: 'networkError401',
      desc: '',
      args: [],
    );
  }

  /// `Http 403`
  String get networkError403 {
    return Intl.message(
      'Http 403',
      name: 'networkError403',
      desc: '',
      args: [],
    );
  }

  /// `Http 404`
  String get networkError404 {
    return Intl.message(
      'Http 404',
      name: 'networkError404',
      desc: '',
      args: [],
    );
  }

  /// `Request Body Error，Please Check Github ClientId or Account/PW`
  String get networkError422 {
    return Intl.message(
      'Request Body Error，Please Check Github ClientId or Account/PW',
      name: 'networkError422',
      desc: '',
      args: [],
    );
  }

  /// `Http timeout`
  String get networkErrorTimeout {
    return Intl.message(
      'Http timeout',
      name: 'networkErrorTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Http unknown error`
  String get networkErrorUnknown {
    return Intl.message(
      'Http unknown error',
      name: 'networkErrorUnknown',
      desc: '',
      args: [],
    );
  }

  /// `network error`
  String get networkError {
    return Intl.message(
      'network error',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `[Connection refused]. Please switch networks or try again later `
  String get connectRefused {
    return Intl.message(
      '[Connection refused]. Please switch networks or try again later ',
      name: 'connectRefused',
      desc: '',
      args: [],
    );
  }

  /// `nothing`
  String get loadMoreNot {
    return Intl.message(
      'nothing',
      name: 'loadMoreNot',
      desc: '',
      args: [],
    );
  }

  /// `loading`
  String get loadMoreText {
    return Intl.message(
      'loading',
      name: 'loadMoreText',
      desc: '',
      args: [],
    );
  }

  /// `home`
  String get tabMainHome {
    return Intl.message(
      'home',
      name: 'tabMainHome',
      desc: '',
      args: [],
    );
  }

  /// `category`
  String get tabMainCategory {
    return Intl.message(
      'category',
      name: 'tabMainCategory',
      desc: '',
      args: [],
    );
  }

  /// `cart`
  String get tabMainCart {
    return Intl.message(
      'cart',
      name: 'tabMainCart',
      desc: '',
      args: [],
    );
  }

  /// `mine`
  String get tabMainMine {
    return Intl.message(
      'mine',
      name: 'tabMainMine',
      desc: '',
      args: [],
    );
  }

  /// `GuoguoDad`
  String get author {
    return Intl.message(
      'GuoguoDad',
      name: 'author',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
