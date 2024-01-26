// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePageInfo _$HomePageInfoFromJson(Map<String, dynamic> json) => HomePageInfo(
      bannerList: (json['bannerList'] as List<dynamic>?)
          ?.map((e) => BannerList.fromJson(e as Map<String, dynamic>))
          .toList(),
      adUrl: json['adUrl'] as String?,
      nineMenuList: (json['nineMenuList'] as List<dynamic>?)
          ?.map((e) => NineMenuList.fromJson(e as Map<String, dynamic>))
          .toList(),
      tabList: (json['tabList'] as List<dynamic>?)
          ?.map((e) => TabList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomePageInfoToJson(HomePageInfo instance) =>
    <String, dynamic>{
      'bannerList': instance.bannerList,
      'adUrl': instance.adUrl,
      'nineMenuList': instance.nineMenuList,
      'tabList': instance.tabList,
    };

BannerList _$BannerListFromJson(Map<String, dynamic> json) => BannerList(
      imgUrl: json['imgUrl'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$BannerListToJson(BannerList instance) =>
    <String, dynamic>{
      'imgUrl': instance.imgUrl,
      'type': instance.type,
    };

NineMenuList _$NineMenuListFromJson(Map<String, dynamic> json) => NineMenuList(
      menuIcon: json['menuIcon'] as String?,
      menuName: json['menuName'] as String?,
      menuCode: json['menuCode'] as String?,
      h5url: json['h5url'] as String?,
    );

Map<String, dynamic> _$NineMenuListToJson(NineMenuList instance) =>
    <String, dynamic>{
      'menuIcon': instance.menuIcon,
      'menuName': instance.menuName,
      'menuCode': instance.menuCode,
      'h5url': instance.h5url,
    };

TabList _$TabListFromJson(Map<String, dynamic> json) => TabList(
      name: json['name'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$TabListToJson(TabList instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
    };
