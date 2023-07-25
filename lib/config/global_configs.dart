// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/services.dart' show rootBundle;

// Package imports:
import 'package:gato/gato.dart' as gato;

/// A singleton class to set and get global configs.
///
/// Use GlobalConfigs() to access the singleton.
class GlobalConfigs {
  static final GlobalConfigs _singleton = GlobalConfigs._internal();

  /// The current configs
  Map<String, dynamic> configs = <String, dynamic>{};

  /// Returns the singleton object
  factory GlobalConfigs() => _singleton;

  GlobalConfigs._internal();

  /// Load your [GlobalConfigs] from a [map] into the current configs
  ///
  /// Load your configs into a specific path by [path]
  /// It will create new path if the [path] doesn't exist
  ///
  /// ```dart
  /// Map<String, dynamic> map = { 'a': 1, 'b': {'c': 2}};
  /// GlobalConfigs.loadFromMap(map, path: 'b.c');
  /// ```
  GlobalConfigs loadFromMap(Map<String, dynamic> map, {String? path}) {
    path == null ? configs.addAll(map) : set(path, map);

    return _singleton;
  }

  /// Load your [GlobalConfigs] from a `JSON` file into the current configs
  ///
  /// Load your configs into a specific path by [path]
  /// It will create new key if the [path] doesn't exist
  ///
  /// ```dart
  /// await GlobalConfigs().loadJsonFromDir(dir, 'assets/config.json');
  /// ```
  Future<GlobalConfigs> loadJsonFromDir(String dir, {String? path}) async {
    String content = await rootBundle.loadString(dir);
    Map<String, dynamic> res = json.decode(content);
    path == null ? configs.addAll(res) : set(path, res);

    return _singleton;
  }

  /// Reads from the configs
  ///
  /// Use [path] to access to a specific key
  ///
  /// Use [convertor] to cast the valeu to your custom type
  ///
  /// ```dart
  /// Map<String, dynamic> map = { 'a': 1, 'b': {'c': 2}};
  /// GlobalConfigs.loadFromMap(map);
  ///
  /// GlobalConfigs().get('a'); // 1
  /// GlobalConfigs().get('b.c'); // 2
  /// ```dart
  T? get<T>(String path, {T Function(dynamic)? converter}) => gato.get(configs, path, converter: converter);

  /// Sets new data to the configs
  ///
  /// Use [path] to access to a specific key
  /// and pass your new value to [value].
  /// It will create new key if the [path] doesn't exist.
  ///
  /// ```dart
  /// Map<String, dynamic> map = { 'a': 1, 'b': {'c': 2}};
  /// GlobalConfigs.loadFromMap(map);
  ///
  /// GlobalConfigs().set('a', 3); // { 'a': 3, 'b': {'c': 2}}
  /// GlobalConfigs().set('b.d', 4); // { 'a': 3, 'b': {'c': 2, 'd': 4}}
  /// ```dart
  void set<T>(String path, T value) => configs = gato.set<T>(configs, path, value);

  /// Removes data to the configs
  ///
  /// Use [path] to access to a specific key
  ///
  /// ```dart
  /// Map<String, dynamic> map = { 'a': 1, 'b': {'c': 2}};
  /// GlobalConfigs.loadFromMap(map);
  ///
  /// GlobalConfigs().unset('b'); // { 'a': 3}
  /// ```dart
  void unset(String path) => configs = gato.unset(configs, path);

  /// Clear the current configs
  void clear() => configs.clear();
}
