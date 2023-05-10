import 'package:jd_mall_flutter/model/HomePageInfo.dart';

class WelPageState {
  //首页页面滚动条位置
  late final double pageScrollY;
  //横向滚动菜单PageView索引
  int menuSliderIndex = 0;
  //首页数据
  late final HomePageInfo homePageInfo;
  WelPageState(this.pageScrollY, this.menuSliderIndex, this.homePageInfo);
}