import 'package:jd_mall_flutter/models/goods_detail_res.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';

class DetailPageState {
  //滚动条位置
  double pageScrollY;

  int index;

  GoodsDetailRes goodsDetailRes;

  BannerInfo selectInfo;

  int pageNum = 1;

  //商品数据
  GoodsPageInfo goodsPageInfo;

  DetailPageState(this.pageScrollY, this.index, this.goodsDetailRes, this.selectInfo, this.pageNum, this.goodsPageInfo);
}
