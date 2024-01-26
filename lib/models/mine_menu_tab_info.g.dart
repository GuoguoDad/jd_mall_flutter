// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mine_menu_tab_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MineMenuTabInfo _$MineMenuTabInfoFromJson(Map<String, dynamic> json) =>
    MineMenuTabInfo(
      functionList: (json['functionList'] as List<dynamic>?)
          ?.map((e) => FunctionInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      tabList: (json['tabList'] as List<dynamic>?)
          ?.map((e) => TabInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MineMenuTabInfoToJson(MineMenuTabInfo instance) =>
    <String, dynamic>{
      'functionList': instance.functionList,
      'tabList': instance.tabList,
    };

FunctionInfo _$FunctionInfoFromJson(Map<String, dynamic> json) => FunctionInfo(
      menuIcon: json['menuIcon'] as String?,
      menuName: json['menuName'] as String?,
      menuCode: json['menuCode'] as String?,
      h5url: json['h5url'] as String?,
    );

Map<String, dynamic> _$FunctionInfoToJson(FunctionInfo instance) =>
    <String, dynamic>{
      'menuIcon': instance.menuIcon,
      'menuName': instance.menuName,
      'menuCode': instance.menuCode,
      'h5url': instance.h5url,
    };

TabInfo _$TabInfoFromJson(Map<String, dynamic> json) => TabInfo(
      name: json['name'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$TabInfoToJson(TabInfo instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
    };
