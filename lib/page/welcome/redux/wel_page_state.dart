import 'package:jd_mall_flutter/models/home_page_info.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';

class WelPageState {
  bool isLoading = true;

  //首页页面滚动条位置
  late final double pageScrollY;

  //横向滚动菜单PageView索引
  int menuSliderIndex = 0;

  //当前选中的分类tab
  String currentTab = "1";

  //首页数据
  late final HomePageInfo homePageInfo;

  int pageNum = 1;

  //商品数据
  late final GoodsPageInfo goodsPageInfo;

  WelPageState(
      this.isLoading, this.pageScrollY, this.menuSliderIndex, this.currentTab, this.homePageInfo, this.pageNum, this.goodsPageInfo);
}
