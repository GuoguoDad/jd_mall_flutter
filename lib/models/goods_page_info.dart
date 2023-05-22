import 'package:json_annotation/json_annotation.dart';

part 'goods_page_info.g.dart';

@JsonSerializable()
class GoodsPageInfo {
  final List<GoodsList>? goodsList;
  final int? totalCount;
  final int? totalPageCount;

  const GoodsPageInfo({
    this.goodsList,
    this.totalCount,
    this.totalPageCount,
  });

  factory GoodsPageInfo.fromJson(Map<String, dynamic> json) =>
      _$GoodsPageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GoodsPageInfoToJson(this);
}

@JsonSerializable()
class GoodsList {
  final String? imgUrl;
  final String? tag;
  final String? description;
  final String? price;
  final String? des1;
  final String? des2;
  final String? type;

  const GoodsList({
    this.imgUrl,
    this.tag,
    this.description,
    this.price,
    this.des1,
    this.des2,
    this.type,
  });

  factory GoodsList.fromJson(Map<String, dynamic> json) =>
      _$GoodsListFromJson(json);

  Map<String, dynamic> toJson() => _$GoodsListToJson(this);
}