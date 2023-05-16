import 'package:jd_mall_flutter/models/home_page_info.dart';

class WelPageState {
  bool isLoading = false;
  //首页页面滚动条位置
  late final double pageScrollY;
  //横向滚动菜单PageView索引
  int menuSliderIndex = 0;
  //当前选中的分类tab
  late final String currentTab;
  //首页数据
  late final HomePageInfo homePageInfo;

  WelPageState(this.isLoading, this.pageScrollY, this.menuSliderIndex, this.currentTab, this.homePageInfo);
}
