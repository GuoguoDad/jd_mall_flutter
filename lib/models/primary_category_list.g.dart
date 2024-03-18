// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'primary_category_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrimaryCategoryList _$PrimaryCategoryListFromJson(Map<String, dynamic> json) => PrimaryCategoryList(
      categoryList: (json['categoryList'] as List<dynamic>?)?.map((e) => CategoryInfo.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$PrimaryCategoryListToJson(PrimaryCategoryList instance) => <String, dynamic>{
      'categoryList': instance.categoryList,
    };

CategoryInfo _$CategoryInfoFromJson(Map<String, dynamic> json) => CategoryInfo(
      name: json['name'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$CategoryInfoToJson(CategoryInfo instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
    };
