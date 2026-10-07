// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:jd_mall_flutter/models/home_page_info.dart';
import 'package:jd_mall_flutter/view/page/home/service.dart';

class HomeProvider extends ChangeNotifier {
  bool isLoading = true;
  double pageScrollY = 0.0;

  /// 滚动偏移量单独用 ValueNotifier 驱动，避免滚动时 notifyListeners 导致整页重建
  final ValueNotifier<double> scrollYNotifier = ValueNotifier<double>(0);

  bool showBackTop = false;
  bool isTabClick = false;
  String currentTab = "";
  int menuSliderIndex = 0;
  int imgSliderIndex = 0;
  HomePageInfo homePageInfo = HomePageInfo.fromJson({});

  Future<void> initPageData() async {
    isLoading = true;
    notifyListeners();

    var info = await HomeApi.queryHomeInfo();
    isLoading = false;
    currentTab = info.tabList.isNotEmpty ? info.tabList[0].code : "";
    homePageInfo = info;
    notifyListeners();
  }

   void setLoading(bool va){
    if (isLoading == va) return;
    isLoading = va;
    notifyListeners();
  }

  void setImgSliderIndex(int va){
    if (imgSliderIndex == va) return;
    imgSliderIndex = va;
    notifyListeners();
  }

  @override
  void dispose() {
    scrollYNotifier.dispose();
    super.dispose();
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

  void changeCurrentTab(String va) {
    if (currentTab == va) return;
    currentTab = va;
    notifyListeners();
  }

  Future<void> refreshPage(VoidCallback freshSuccess, VoidCallback freshFail) async {
    var info = await HomeApi.queryHomeInfo();
    if (info != null) {
      homePageInfo = info;
      freshSuccess();
    } else {
      freshFail();
    }
    notifyListeners();
  }
}
