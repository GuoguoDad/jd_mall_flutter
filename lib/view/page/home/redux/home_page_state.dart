import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/models/home_page_info.dart';

class HomePageState {
  bool showBackTop = false;

  bool isLoading = true;

  //首页页面滚动条位置
  double pageScrollY;

  //横向滚动菜单PageView索引
  int menuSliderIndex = 0;

  //当前选中的分类tab
  String currentTab = "1";

  //首页数据
  HomePageInfo homePageInfo;

  HomePageState(this.showBackTop, this.isLoading, this.pageScrollY, this.menuSliderIndex, this.currentTab, this.homePageInfo);
}
