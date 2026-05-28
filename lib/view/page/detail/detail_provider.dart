import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/constant/index.dart';
import 'package:jd_mall_flutter/models/goods_detail_res.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/view/page/detail/service.dart';

class DetailProvider extends ChangeNotifier {
  bool isLoading = true;

  double pageScrollY = 0.0;

  //是否是floatingHeader中的tab点击
  bool isTabClick = false;

  int index = 0;

  GoodsDetailRes goodsDetailRes = GoodsDetailRes.fromJson({});

  BannerInfo selectInfo = BannerInfo.fromJson({});

  int pageNum = 1;

  //商品数据
  GoodsPageInfo goodsPageInfo = GoodsPageInfo.fromJson({});

  void setLoading(bool va) {
    isLoading = va;
    notifyListeners();
  }

  void recordPageY(double y) {
    pageScrollY = y;
    notifyListeners();
  }

  void setIsTabClick(bool va) {
    isTabClick = va;
    notifyListeners();
  }

  void setIndex(int i) {
    index = i;
    notifyListeners();
  }

  void selectBanner(BannerInfo info) {
    selectInfo = info;
    notifyListeners();
  }

  Future<void> initPageData() async {
    isLoading = true;
    notifyListeners();

    var res = await Future.wait([DetailApi.queryDetailInfo(), DetailApi.queryStoreGoodsListByPage(1, pageSize)]);
    isLoading = false;
    if (res[0] != null && res[0].bannerList.length > 0 && res[1] != null) {
      goodsDetailRes = res[0];
      selectInfo = res[0].bannerList[0];
      pageNum = 1;
      goodsPageInfo = res[1];
    }
    notifyListeners();
  }

  //加载商品列表下一页
  void loadNextPage(VoidCallback loadMoreSuccess, VoidCallback loadMoreFail) {
    int currentPage = pageNum + 1;
    DetailApi.queryStoreGoodsListByPage(currentPage, pageSize).then((res) {
      var totalPage = res.totalPageCount;

      if (totalPage >= currentPage) {
        List<GoodsList> goods = goodsPageInfo.goodsList ?? [];
        List<GoodsList>? goodsList = [...goods, ...res.goodsList];

        pageNum = currentPage;
        goodsPageInfo = GoodsPageInfo(goodsList: goodsList, totalCount: res.totalCount, totalPageCount: res.totalPageCount);

        loadMoreSuccess();
        notifyListeners();
      } else {
        loadMoreFail();
      }
    });
  }
}
