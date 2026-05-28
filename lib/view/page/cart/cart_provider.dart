
import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/constant/index.dart';
import 'package:jd_mall_flutter/models/cart_goods.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/view/page/cart/service.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class CartProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  final RefreshController refreshController = RefreshController();

  bool isLoading = true;

  List<CartGoods> cartGoods = <CartGoods>[];

  List<String> selectCartGoodsList = <String>[];

  int pageNum = 1;

  //商品数据
  GoodsPageInfo goodsPageInfo = GoodsPageInfo.fromJson({});

  void setLoading(bool va) {
    isLoading = va;
    notifyListeners();
  }

  //加载购物车中的商品和可能喜欢的商品列表
  Future<void> initCartGoodsData() async {
    isLoading = true;
    notifyListeners();

    var res = await Future.wait([CartApi.queryCartGoods(), CartApi.queryGoodsListByPage(1, pageSize)]);
    isLoading = false;
    if (res[0] != null && res[1] != null) {
      cartGoods = res[0];
      pageNum = 1;
      goodsPageInfo = res[1];
    }
    notifyListeners();
  }

  Future<void> refreshPage(VoidCallback freshSuccess, VoidCallback freshFail) async {
    var res = await Future.wait([CartApi.queryCartGoods(), CartApi.queryGoodsListByPage(1, pageSize)]);
    if (res[0] != null && res[1] != null) {
      cartGoods = res[0];
      pageNum = 1;
      goodsPageInfo = res[1];
      freshSuccess();
      notifyListeners();
    } else {
      freshFail();
    }
  }

  //加载可能喜欢商品列表下一页
  void loadNextPage(VoidCallback loadMoreSuccess, VoidCallback loadMoreFail) {
    int currentPage = pageNum + 1;
    CartApi.queryGoodsListByPage(currentPage, pageSize).then((res) {
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

  //单选购物车中的商品
  void selectCartGoods(String goodsCode) {
    List<String> selectList = selectCartGoodsList;
    if (!selectList.contains(goodsCode)) {
      selectList.add(goodsCode);
    } else {
      selectList.removeAt(selectList.indexOf(goodsCode));
    }
    selectCartGoodsList = selectList;
    notifyListeners();
  }

  //店铺维度全选
  void selectStoreGoods(String storeCode, bool value) {
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
    selectCartGoodsList = selectList;
    notifyListeners();
  }

  //全选
  void selectAll(bool selectAll) {
    List<String> selectList = [];
    if (selectAll) {
      for (CartGoods element in cartGoods) {
        element.goodsList?.forEach((goodsInfo) {
          selectList.add(goodsInfo.code!);
        });
      }
    }
    selectCartGoodsList = selectList;
    notifyListeners();
  }

  //修改购物车商品数量
  void changeCartGoodsNum(String goodsCode, int num) {
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

    cartGoods = list;
    notifyListeners();
  }
}
