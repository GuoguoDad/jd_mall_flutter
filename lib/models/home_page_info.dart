// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'home_page_info.g.dart';

@JsonSerializable()
class HomePageInfo {
  final List<BannerList>? bannerList;
  final String? adUrl;
  final List<NineMenuList>? nineMenuList;
  final List<TabList>? tabList;

  const HomePageInfo({
    this.bannerList,
    this.adUrl,
    this.nineMenuList,
    this.tabList,
  });

  factory HomePageInfo.fromJson(Map<String, dynamic> json) => _$HomePageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$HomePageInfoToJson(this);
}

@JsonSerializable()
class BannerList {
  final String? imgUrl;
  final String? type;

  const BannerList({
    this.imgUrl,
    this.type,
  });

  factory BannerList.fromJson(Map<String, dynamic> json) => _$BannerListFromJson(json);

  Map<String, dynamic> toJson() => _$BannerListToJson(this);
}

@JsonSerializable()
class NineMenuList {
  final String? menuIcon;
  final String? menuName;
  final String? menuCode;
  final String? h5url;

  const NineMenuList({this.menuIcon, this.menuName, this.menuCode, this.h5url});

  factory NineMenuList.fromJson(Map<String, dynamic> json) => _$NineMenuListFromJson(json);

  Map<String, dynamic> toJson() => _$NineMenuListToJson(this);
}

@JsonSerializable()
class TabList {
  final String? name;
  final String? code;

  const TabList({
    this.name,
    this.code,
  });

  factory TabList.fromJson(Map<String, dynamic> json) => _$TabListFromJson(json);

  Map<String, dynamic> toJson() => _$TabListToJson(this);
}
