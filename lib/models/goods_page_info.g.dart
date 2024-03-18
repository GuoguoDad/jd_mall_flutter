// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_page_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsPageInfo _$GoodsPageInfoFromJson(Map<String, dynamic> json) => GoodsPageInfo(
      goodsList: (json['goodsList'] as List<dynamic>?)?.map((e) => GoodsList.fromJson(e as Map<String, dynamic>)).toList(),
      totalCount: json['totalCount'] as int?,
      totalPageCount: json['totalPageCount'] as int?,
    );

Map<String, dynamic> _$GoodsPageInfoToJson(GoodsPageInfo instance) => <String, dynamic>{
      'goodsList': instance.goodsList,
      'totalCount': instance.totalCount,
      'totalPageCount': instance.totalPageCount,
    };

GoodsList _$GoodsListFromJson(Map<String, dynamic> json) => GoodsList(
      imgUrl: json['imgUrl'] as String?,
      tag: json['tag'] as String?,
      description: json['description'] as String?,
      price: json['price'] as String?,
      des1: json['des1'] as String?,
      des2: json['des2'] as String?,
      type: json['type'] as String?,
      h5url: json['h5url'] as String?,
    );

Map<String, dynamic> _$GoodsListToJson(GoodsList instance) => <String, dynamic>{
      'imgUrl': instance.imgUrl,
      'tag': instance.tag,
      'description': instance.description,
      'price': instance.price,
      'des1': instance.des1,
      'des2': instance.des2,
      'type': instance.type,
      'h5url': instance.h5url,
    };
