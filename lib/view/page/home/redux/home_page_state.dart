// Project imports:
import 'package:jd_mall_flutter/models/home_page_info.dart';

class HomePageState {
  bool isLoading = true;

  //横向滚动菜单PageView索引
  int menuSliderIndex = 0;

  //首页数据
  HomePageInfo homePageInfo;

  HomePageState(this.isLoading, this.menuSliderIndex, this.homePageInfo);
}
