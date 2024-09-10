// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';

// Project imports:
import 'package:jd_mall_flutter/models/home_page_info.dart';
import 'package:jd_mall_flutter/view/page/home/service.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final EasyRefreshController freshController = EasyRefreshController(controlFinishRefresh: true);
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController();

  RxBool isLoading = true.obs;

  RxDouble pageScrollY = 0.0.obs;

  //是否显示返回顶部
  RxBool showBackTop = false.obs;

  RxBool isTabClick = false.obs;

  RxString currentTab = "".obs;

  //横向滚动菜单PageView索引
  RxInt menuSliderIndex = 0.obs;

  //首页数据
  Rx<HomePageInfo> homePageInfo = HomePageInfo.fromJson({}).obs;

  @override
  void onInit() {
    initPageData();
    super.onInit();
  }

  @override
  void onClose() {
    freshController.dispose();
    scrollController.dispose();
    pageController.dispose();
    super.onClose();
  }

  setLoading(bool va) => isLoading.value = va;

  recordPageY(double y) => pageScrollY.value = y;

  setShowBackTop(bool va) => showBackTop.value = va;

  setIsTabClick(bool va) => isTabClick.value = va;

  changeCurrentTab(String va) => currentTab.value = va;

  initPageData() async {
    isLoading.value = true;
    var info = await HomeApi.queryHomeInfo();
    isLoading.value = false;
    currentTab.value = info.tabList.isNotEmpty ? info.tabList[0].code : "";
    homePageInfo.value = info;
  }

  refreshPage(VoidCallback freshSuccess, VoidCallback freshFail) async {
    var info = await HomeApi.queryHomeInfo();
    if (info != null) {
      homePageInfo.value = info;
      freshSuccess();
    } else {
      freshFail();
    }
  }
}
