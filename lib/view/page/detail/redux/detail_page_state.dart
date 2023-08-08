// Project imports:
import 'package:jd_mall_flutter/models/goods_detail_res.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';

class DetailPageState {
  bool isLoading;

  GoodsDetailRes goodsDetailRes;

  BannerInfo selectInfo;

  int pageNum = 1;

  //商品数据
  GoodsPageInfo goodsPageInfo;

  DetailPageState(this.isLoading, this.goodsDetailRes, this.selectInfo, this.pageNum, this.goodsPageInfo);
}
