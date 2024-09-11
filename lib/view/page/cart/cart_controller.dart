// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

// Project imports:
import 'package:jd_mall_flutter/common/constant/index.dart';
import 'package:jd_mall_flutter/models/cart_goods.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/view/page/cart/service.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();

  final ScrollController scrollController = ScrollController();
  final RefreshController refreshController = RefreshController();

  RxBool isLoading = true.obs;

  RxList<CartGoods> cartGoods = <CartGoods>[].obs;

  RxList<String> selectCartGoodsList = <String>[].obs;

  RxInt pageNum = 1.obs;

  //商品数据
  Rx<GoodsPageInfo> goodsPageInfo = GoodsPageInfo.fromJson({}).obs;

  @override
  void onInit() {
    initCartGoodsData();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    refreshController.dispose();
    super.onClose();
  }

  setLoading(bool va) => isLoading.value = va;

  //加载购物车中的商品和可能喜欢的商品列表
  initCartGoodsData() async {
    isLoading.value = true;
    var res = await Future.wait([CartApi.queryCartGoods(), CartApi.queryGoodsListByPage(1, pageSize)]);
    isLoading.value = false;
    if (res[0] != null && res[1] != null) {
      cartGoods.value = res[0];
      pageNum.value = 1;
      goodsPageInfo.value = res[1];
    }
  }

  refreshPage(VoidCallback freshSuccess, VoidCallback freshFail) async {
    var res = await Future.wait([CartApi.queryCartGoods(), CartApi.queryGoodsListByPage(1, pageSize)]);
    if (res[0] != null && res[1] != null) {
      cartGoods.value = res[0];
      pageNum.value = 1;
      goodsPageInfo.value = res[1];
      freshSuccess();
    } else {
      freshFail();
    }
  }

  //加载可能喜欢商品列表下一页
  loadNextPage(VoidCallback loadMoreSuccess, VoidCallback loadMoreFail) {
    int currentPage = pageNum.value + 1;
    CartApi.queryGoodsListByPage(currentPage, pageSize).then((res) {
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

  //单选购物车中的商品
  selectCartGoods(String goodsCode) {
    List<String> selectList = selectCartGoodsList;
    if (!selectList.contains(goodsCode)) {
      selectList.add(goodsCode);
    } else {
      selectList.removeAt(selectList.indexOf(goodsCode));
    }
    selectCartGoodsList = RxList(selectList);
  }

  //店铺维度全选
  selectStoreGoods(String storeCode, bool value) {
    List<String> selectList = selectCartGoodsList;
    List<CartGoods> cartGoodsList = cartGoods;
    //找到相应店铺的商品信息
    CartGoods cGoods = cartGoodsList.firstWhere((element) => element.storeCode == storeCode);
    cGoods.goodsList?.forEach((element) {
      if (value && !selectList.contains(element.code!)) {
        selectList.add(element.code!);
      } else if (!value && selectList.contains(element.code!)) {
        selectList.removeAt(selectList.indexOf(element.code!));
      }
    });
    selectCartGoodsList = RxList(selectList);
  }

  //全选
  selectAll(bool selectAll) {
    List<String> selectList = [];
    if (selectAll) {
      for (CartGoods element in cartGoods) {
        element.goodsList?.forEach((goodsInfo) {
          selectList.add(goodsInfo.code!);
        });
      }
    }
    selectCartGoodsList.value = selectList;
  }

  //修改购物车商品数量
  changeCartGoodsNum(String goodsCode, int num) {
    List<CartGoods> cartGoodsList = cartGoods;
    List<CartGoods> list = cartGoodsList.map((element) {
      List<GoodsInfo>? filterList = element.goodsList?.where((goods) => goods.code == goodsCode).toList();
      if (filterList!.isNotEmpty) {
        int? index = element.goodsList?.indexWhere((goods) => goods.code == goodsCode);
        filterList[0].num = num;
        element.goodsList?[index!] = filterList[0];
      }
      return element;
    }).toList();

    cartGoods.value = list;
  }
}
