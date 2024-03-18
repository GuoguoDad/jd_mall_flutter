// Package imports:
import 'package:extended_scroll/extended_scroll.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:jd_mall_flutter/common/constant/index.dart';
import 'package:jd_mall_flutter/common/types/common.dart';
import 'package:jd_mall_flutter/models/goods_detail_res.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/view/page/detail/service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailController extends GetxController {
  static DetailController get to => Get.find();

  final ExtendedScrollController scrollController = ExtendedScrollController();
  final RefreshController refreshController = RefreshController();

  RxBool isLoading = true.obs;

  RxDouble pageScrollY = 0.0.obs;

  //是否是floatingHeader中的tab点击
  RxBool isTabClick = false.obs;

  RxInt index = 0.obs;

  Rx<GoodsDetailRes> goodsDetailRes = GoodsDetailRes.fromJson({}).obs;

  Rx<BannerInfo> selectInfo = BannerInfo.fromJson({}).obs;

  RxInt pageNum = 1.obs;

  //商品数据
  Rx<GoodsPageInfo> goodsPageInfo = GoodsPageInfo.fromJson({}).obs;

  @override
  void onInit() {
    initPageData();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    refreshController.dispose();
    super.onClose();
  }

  setLoading(bool va) => isLoading.value = va;

  recordPageY(double y) => pageScrollY.value = y;

  setIsTabClick(bool va) => isTabClick.value = va;

  setIndex(int i) => index.value = i;

  selectBanner(BannerInfo info) => selectInfo.value = info;

  initPageData() async {
    isLoading.value = true;
    var res = await Future.wait([DetailApi.queryDetailInfo(), DetailApi.queryStoreGoodsListByPage(1, pageSize)]);
    isLoading.value = false;
    if (res[0] != null && res[0].bannerList.length > 0 && res[1] != null) {
      goodsDetailRes.value = res[0];
      selectInfo.value = res[0].bannerList[0];
      pageNum.value = 1;
      goodsPageInfo.value = res[1];
    }
  }

  //加载商品列表下一页
  loadNextPage(VoidCallback loadMoreSuccess, VoidCallback loadMoreFail) {
    int currentPage = pageNum.value + 1;
    DetailApi.queryStoreGoodsListByPage(currentPage, pageSize).then((res) {
      var totalPage = res.totalPageCount;

      if (totalPage >= currentPage) {
        List<GoodsList> goods = goodsPageInfo.value.goodsList ?? [];
        List<GoodsList>? goodsList = [...goods, ...res.goodsList];

        pageNum.value = currentPage;
        goodsPageInfo.value = GoodsPageInfo(goodsList: goodsList, totalCount: res.totalCount, totalPageCount: res.totalPageCount);

        loadMoreSuccess();
      } else {
        loadMoreFail();
      }
    });
  }
}
