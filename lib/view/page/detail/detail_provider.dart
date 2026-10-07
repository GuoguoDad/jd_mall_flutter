// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/common/constant/index.dart';
import 'package:jd_mall_flutter/models/goods_detail_res.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/view/page/detail/service.dart';

class DetailProvider extends ChangeNotifier {
  bool isLoading = true;

  double pageScrollY = 0.0;

  /// 滚动偏移量单独用 ValueNotifier 驱动，避免滚动时 notifyListeners 导致整页重建
  final ValueNotifier<double> scrollYNotifier = ValueNotifier<double>(0);

  //是否是floatingHeader中的tab点击
  bool isTabClick = false;

  int index = 0;

  GoodsDetailRes goodsDetailRes = GoodsDetailRes.fromJson({});

  BannerInfo selectInfo = BannerInfo.fromJson({});

  int pageNum = 1;

  //商品数据
  GoodsPageInfo goodsPageInfo = GoodsPageInfo.fromJson({});

  void setLoading(bool va) {
    if (isLoading == va) return;
    isLoading = va;
    notifyListeners();
  }

  void recordPageY(double y) {
    if ((pageScrollY - y).abs() < 0.5) return;
    pageScrollY = y;
    scrollYNotifier.value = y;
  }

  void setIsTabClick(bool va) {
    if (isTabClick == va) return;
    isTabClick = va;
    notifyListeners();
  }

  void setIndex(int i) {
    if (index == i) return;
    index = i;
    notifyListeners();
  }

  void selectBanner(BannerInfo info) {
    if (selectInfo == info) return;
    selectInfo = info;
    notifyListeners();
  }

  @override
  void dispose() {
    scrollYNotifier.dispose();
    super.dispose();
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
