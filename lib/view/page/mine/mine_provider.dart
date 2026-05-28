import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';
import 'package:jd_mall_flutter/view/page/mine/service.dart';

class MineProvider extends ChangeNotifier {

  bool isLoading = true;

  double pageScrollY = 0.0;

  //是否显示返回顶部
  bool showBackTop = false;

  bool isTabClick = false;

  int menuIndex = 0;

  String currentTab = "";

  MineMenuTabInfo menuTabInfo = MineMenuTabInfo.fromJson({});


  void setLoading(bool va) {
    isLoading = va;
    notifyListeners();
  }

  void recordPageY(double y) {
    pageScrollY = y;
    notifyListeners();
  }

  void setShowBackTop(bool va) {
    showBackTop = va;
    notifyListeners();
  }

  void setIsTabClick(bool va) {
    isTabClick = va;
    notifyListeners();
  }

  void changeMenuIndex(int index) {
    menuIndex = index;
    notifyListeners();
  }

  void changeCurrentTab(String va) {
    currentTab = va;
    notifyListeners();
  }

  Future<void> initPageData() async {
    isLoading = true;
    notifyListeners();

    MineMenuTabInfo res = await MineApi.queryInfo();
    isLoading = false;
    menuTabInfo = res;
    if (res.tabList!.isNotEmpty) {
      currentTab = res.tabList![0].code!;
    }
    notifyListeners();
  }

  Future<void> refreshPage(VoidCallback freshSuccess, VoidCallback freshFail) async {
    var info = await MineApi.queryInfo();
    if (info != null) {
      menuTabInfo = info;
      freshSuccess();
      notifyListeners();
    } else {
      freshFail();
    }
  }
}
