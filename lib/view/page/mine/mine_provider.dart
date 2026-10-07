// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_refresh/easy_refresh.dart';

// Project imports:
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';
import 'package:jd_mall_flutter/view/page/mine/service.dart';

class MineProvider extends ChangeNotifier {

  bool isLoading = true;

  double pageScrollY = 0.0;

  /// 滚动偏移量单独用 ValueNotifier 驱动，避免滚动时 notifyListeners 导致整页重建
  final ValueNotifier<double> scrollYNotifier = ValueNotifier<double>(0);

  //是否显示返回顶部
  bool showBackTop = false;

  bool isTabClick = false;

  int menuIndex = 0;

  String currentTab = "";

  MineMenuTabInfo menuTabInfo = MineMenuTabInfo.fromJson({});


  void setLoading(bool va) {
    if (isLoading == va) return;
    isLoading = va;
    notifyListeners();
  }

  void recordPageY(double y) {
    if ((pageScrollY - y).abs() < 0.5) return;
    pageScrollY = y;
    scrollYNotifier.value = y;
  }

  void setShowBackTop(bool va) {
    if (showBackTop == va) return;
    showBackTop = va;
    notifyListeners();
  }

  void setIsTabClick(bool va) {
    if (isTabClick == va) return;
    isTabClick = va;
    notifyListeners();
  }

  void changeMenuIndex(int index) {
    if (menuIndex == index) return;
    menuIndex = index;
    notifyListeners();
  }

  void changeCurrentTab(String va) {
    if (currentTab == va) return;
    currentTab = va;
    notifyListeners();
  }

  @override
  void dispose() {
    scrollYNotifier.dispose();
    super.dispose();
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
