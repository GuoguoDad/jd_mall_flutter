// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_goods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartGoods _$CartGoodsFromJson(Map<String, dynamic> json) => CartGoods(
      storeName: json['storeName'] as String?,
      storeCode: json['storeCode'] as String?,
      h5url: json['h5url'] as String?,
      goodsList: (json['goodsList'] as List<dynamic>?)?.map((e) => GoodsInfo.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$CartGoodsToJson(CartGoods instance) => <String, dynamic>{
      'storeName': instance.storeName,
      'storeCode': instance.storeCode,
      'h5url': instance.h5url,
      'goodsList': instance.goodsList,
    };

GoodsInfo _$GoodsInfoFromJson(Map<String, dynamic> json) => GoodsInfo(
      code: json['code'] as String?,
      imgUrl: json['imgUrl'] as String?,
      description: json['description'] as String?,
      price: json['price'] as String?,
      num: json['num'] as int?,
    );

Map<String, dynamic> _$GoodsInfoToJson(GoodsInfo instance) => <String, dynamic>{
      'code': instance.code,
      'imgUrl': instance.imgUrl,
      'description': instance.description,
      'price': instance.price,
      'num': instance.num,
    };
