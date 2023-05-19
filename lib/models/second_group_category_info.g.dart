// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'second_group_category_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecondGroupCategoryInfo _$SecondGroupCategoryInfoFromJson(
        Map<String, dynamic> json) =>
    SecondGroupCategoryInfo(
      bannerUrl: json['bannerUrl'] as String?,
      cateList: (json['cateList'] as List<dynamic>?)
          ?.map((e) => CateList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SecondGroupCategoryInfoToJson(
        SecondGroupCategoryInfo instance) =>
    <String, dynamic>{
      'bannerUrl': instance.bannerUrl,
      'cateList': instance.cateList,
    };

CateList _$CateListFromJson(Map<String, dynamic> json) => CateList(
      iconUrl: json['iconUrl'] as String?,
      categoryName: json['categoryName'] as String?,
      categoryCode: json['categoryCode'] as String?,
    );

Map<String, dynamic> _$CateListToJson(CateList instance) => <String, dynamic>{
      'iconUrl': instance.iconUrl,
      'categoryName': instance.categoryName,
      'categoryCode': instance.categoryCode,
    };
