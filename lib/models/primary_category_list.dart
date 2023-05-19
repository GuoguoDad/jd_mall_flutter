import 'package:json_annotation/json_annotation.dart';

part 'primary_category_list.g.dart';

@JsonSerializable()
class PrimaryCategoryList {
  final List<CategoryInfo>? categoryList;

  const PrimaryCategoryList({
    this.categoryList,
  });

  factory PrimaryCategoryList.fromJson(Map<String, dynamic> json) => _$PrimaryCategoryListFromJson(json);

  Map<String, dynamic> toJson() => _$PrimaryCategoryListToJson(this);
}

@JsonSerializable()
class CategoryInfo {
  final String? name;
  final String? code;

  const CategoryInfo({
    this.name,
    this.code,
  });

  factory CategoryInfo.fromJson(Map<String, dynamic> json) => _$CategoryInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryInfoToJson(this);
}
