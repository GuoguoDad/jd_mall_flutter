import 'package:jd_mall_flutter/models/home_page_info.dart';
//记录页面滚动距离
class ChangePageScrollYAction {
  final double value;
  ChangePageScrollYAction(this.value);
}
//滚动菜单滚动页面索引
class SetMenuSliderIndex {
  final int value;
  SetMenuSliderIndex(this.value);
}
//滚动tab当前选中项
class SetCurrentTab {
  final String value;
  SetCurrentTab(this.value);
}

class LoadAction {
  final bool value;
  LoadAction(this.value);
}

//首页数据
class SetHomePageInfoAction {
  final HomePageInfo value;
  SetHomePageInfoAction(this.value);
}