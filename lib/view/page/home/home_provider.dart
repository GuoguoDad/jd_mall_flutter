// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:jd_mall_flutter/models/home_page_info.dart';
import 'package:jd_mall_flutter/view/page/home/service.dart';

class HomeProvider extends ChangeNotifier {
  bool isLoading = true;
  double pageScrollY = 0.0;
  bool showBackTop = false;
  bool isTabClick = false;
  String currentTab = "";
  int menuSliderIndex = 0;
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
    isLoading = va;
    notifyListeners();
  }

  void recordPageY(double y){
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

  void changeCurrentTab(String va) {
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
