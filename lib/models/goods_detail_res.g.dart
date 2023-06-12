// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_detail_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsDetailRes _$GoodsDetailResFromJson(Map<String, dynamic> json) => GoodsDetailRes(
      bannerList: (json['bannerList'] as List<dynamic>?)?.map((e) => BannerInfo.fromJson(e as Map<String, dynamic>)).toList(),
      goodsInfo: json['goodsInfo'] == null ? null : GoodsInfo.fromJson(json['goodsInfo'] as Map<String, dynamic>),
      detailInfo: json['detailInfo'] == null ? null : DetailInfo.fromJson(json['detailInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GoodsDetailResToJson(GoodsDetailRes instance) => <String, dynamic>{
      'bannerList': instance.bannerList,
      'goodsInfo': instance.goodsInfo,
      'detailInfo': instance.detailInfo,
    };

BannerInfo _$BannerInfoFromJson(Map<String, dynamic> json) => BannerInfo(
      colorId: json['colorId'] as String?,
      colorName: json['colorName'] as String?,
      thumb: json['thumb'] as String?,
      imgList: (json['imgList'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$BannerInfoToJson(BannerInfo instance) => <String, dynamic>{
      'colorId': instance.colorId,
      'colorName': instance.colorName,
      'thumb': instance.thumb,
      'imgList': instance.imgList,
    };

GoodsInfo _$GoodsInfoFromJson(Map<String, dynamic> json) => GoodsInfo(
      originalPrice: json['originalPrice'] as String?,
      specialPrice: json['specialPrice'] as String?,
      tagList: (json['tagList'] as List<dynamic>?)?.map((e) => e as String).toList(),
      goodsName: json['goodsName'] as String?,
      appraiseList: (json['appraiseList'] as List<dynamic>?)?.map((e) => AppraiseInfo.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$GoodsInfoToJson(GoodsInfo instance) => <String, dynamic>{
      'originalPrice': instance.originalPrice,
      'specialPrice': instance.specialPrice,
      'tagList': instance.tagList,
      'goodsName': instance.goodsName,
      'appraiseList': instance.appraiseList,
    };

AppraiseInfo _$AppraiseInfoFromJson(Map<String, dynamic> json) => AppraiseInfo(
      headerUrl: json['headerUrl'] as String?,
      userName: json['userName'] as String?,
      content: json['content'] as String?,
      type: json['type'] as int?,
      color: json['color'] as String?,
      size: json['size'] as String?,
    );

Map<String, dynamic> _$AppraiseInfoToJson(AppraiseInfo instance) => <String, dynamic>{
      'headerUrl': instance.headerUrl,
      'userName': instance.userName,
      'content': instance.content,
      'type': instance.type,
      'color': instance.color,
      'size': instance.size,
    };

DetailInfo _$DetailInfoFromJson(Map<String, dynamic> json) => DetailInfo(
      hdzq: json['hdzq'] as String?,
      dnyx: json['dnyx'] as String?,
      introductionList: (json['introductionList'] as List<dynamic>?)?.map((e) => e as String).toList(),
      serviceList: (json['serviceList'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DetailInfoToJson(DetailInfo instance) => <String, dynamic>{
      'hdzq': instance.hdzq,
      'dnyx': instance.dnyx,
      'introductionList': instance.introductionList,
      'serviceList': instance.serviceList,
    };
