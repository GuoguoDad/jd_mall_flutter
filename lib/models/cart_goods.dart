// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'cart_goods.g.dart';

@JsonSerializable()
class CartGoods {
  final String? storeName;
  final String? storeCode;
  final String? h5url;
  final List<GoodsInfo>? goodsList;

  const CartGoods({
    this.storeName,
    this.storeCode,
    this.h5url,
    this.goodsList,
  });

  factory CartGoods.fromJson(Map<String, dynamic> json) => _$CartGoodsFromJson(json);

  Map<String, dynamic> toJson() => _$CartGoodsToJson(this);
}

@JsonSerializable()
class GoodsInfo {
  final String? code;
  final String? imgUrl;
  final String? description;
  final String? price;
  int? num;

  GoodsInfo({
    this.code,
    this.imgUrl,
    this.description,
    this.price,
    this.num,
  });

  factory GoodsInfo.fromJson(Map<String, dynamic> json) => _$GoodsInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GoodsInfoToJson(this);
}
