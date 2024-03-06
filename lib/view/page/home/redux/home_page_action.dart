// Project imports:
import 'package:jd_mall_flutter/common/types/common.dart';
import 'package:jd_mall_flutter/models/home_page_info.dart';

//页面初始化
class InitDataAction {}

class SetLoadingAction {
  final bool value;

  SetLoadingAction(this.value);
}

//滚动菜单滚动页面索引
class SetMenuSliderIndex {
  final int value;

  SetMenuSliderIndex(this.value);
}

//页面刷新
class RefreshAction {
  late VoidCallback freshSuccess;
  late VoidCallback freshFail;

  RefreshAction(this.freshSuccess, this.freshFail);
}

//首页数据
class SetHomePageInfoAction {
  final HomePageInfo value;

  SetHomePageInfoAction(this.value);
}
