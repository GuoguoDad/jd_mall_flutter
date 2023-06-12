import 'package:json_annotation/json_annotation.dart';

part 'goods_detail_res.g.dart';

@JsonSerializable()
class GoodsDetailRes {
  final List<BannerInfo>? bannerList;
  final GoodsInfo? goodsInfo;
  final DetailInfo? detailInfo;

  const GoodsDetailRes({
    this.bannerList,
    this.goodsInfo,
    this.detailInfo,
  });

  factory GoodsDetailRes.fromJson(Map<String, dynamic> json) => _$GoodsDetailResFromJson(json);

  Map<String, dynamic> toJson() => _$GoodsDetailResToJson(this);
}

@JsonSerializable()
class BannerInfo {
  final String? colorId;
  final String? colorName;
  final String? thumb;
  final List<String>? imgList;

  const BannerInfo({
    this.colorId,
    this.colorName,
    this.thumb,
    this.imgList,
  });

  factory BannerInfo.fromJson(Map<String, dynamic> json) => _$BannerInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BannerInfoToJson(this);
}

@JsonSerializable()
class GoodsInfo {
  final String? originalPrice;
  final String? specialPrice;
  final List<String>? tagList;
  final String? goodsName;
  final List<AppraiseInfo>? appraiseList;

  const GoodsInfo({
    this.originalPrice,
    this.specialPrice,
    this.tagList,
    this.goodsName,
    this.appraiseList,
  });

  factory GoodsInfo.fromJson(Map<String, dynamic> json) => _$GoodsInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GoodsInfoToJson(this);
}

@JsonSerializable()
class AppraiseInfo {
  final String? headerUrl;
  final String? userName;
  final String? content;
  final int? type;
  final String? color;
  final String? size;

  const AppraiseInfo({
    this.headerUrl,
    this.userName,
    this.content,
    this.type,
    this.color,
    this.size,
  });

  factory AppraiseInfo.fromJson(Map<String, dynamic> json) => _$AppraiseInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AppraiseInfoToJson(this);
}

@JsonSerializable()
class DetailInfo {
  final String? hdzq;
  final String? dnyx;
  final List<String>? introductionList;
  final List<String>? serviceList;

  const DetailInfo({
    this.hdzq,
    this.dnyx,
    this.introductionList,
    this.serviceList,
  });

  factory DetailInfo.fromJson(Map<String, dynamic> json) => _$DetailInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DetailInfoToJson(this);
}
