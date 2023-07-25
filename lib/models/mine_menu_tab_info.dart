// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'mine_menu_tab_info.g.dart';

@JsonSerializable()
class MineMenuTabInfo {
  final List<FunctionInfo>? functionList;
  final List<TabInfo>? tabList;

  const MineMenuTabInfo({
    this.functionList,
    this.tabList,
  });

  factory MineMenuTabInfo.fromJson(Map<String, dynamic> json) => _$MineMenuTabInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MineMenuTabInfoToJson(this);
}

@JsonSerializable()
class FunctionInfo {
  final String? menuIcon;
  final String? menuName;
  final String? menuCode;
  final String? h5url;

  const FunctionInfo({
    this.menuIcon,
    this.menuName,
    this.menuCode,
    this.h5url,
  });

  factory FunctionInfo.fromJson(Map<String, dynamic> json) => _$FunctionInfoFromJson(json);

  Map<String, dynamic> toJson() => _$FunctionInfoToJson(this);
}

@JsonSerializable()
class TabInfo {
  final String? name;
  final String? code;

  const TabInfo({
    this.name,
    this.code,
  });

  factory TabInfo.fromJson(Map<String, dynamic> json) => _$TabInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TabInfoToJson(this);
}
