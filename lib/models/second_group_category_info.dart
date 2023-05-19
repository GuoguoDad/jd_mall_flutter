import 'package:json_annotation/json_annotation.dart';

part 'second_group_category_info.g.dart';

@JsonSerializable()
class SecondGroupCategoryInfo {
  final String? bannerUrl;
  final List<CateList>? cateList;

  const SecondGroupCategoryInfo({
    this.bannerUrl,
    this.cateList,
  });

  factory SecondGroupCategoryInfo.fromJson(Map<String, dynamic> json) => _$SecondGroupCategoryInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SecondGroupCategoryInfoToJson(this);
}

@JsonSerializable()
class CateList {
  final String? iconUrl;
  final String? categoryName;
  final String? categoryCode;

  const CateList({
    this.iconUrl,
    this.categoryName,
    this.categoryCode,
  });

  factory CateList.fromJson(Map<String, dynamic> json) => _$CateListFromJson(json);

  Map<String, dynamic> toJson() => _$CateListToJson(this);
}
