// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

// Project imports:
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';
import 'package:jd_mall_flutter/view/page/mine/service.dart';

class MineController extends GetxController {
  static MineController get to => Get.find();

  late final EasyRefreshController freshController = EasyRefreshController(controlFinishRefresh: true);
  late final ScrollController scrollController = ScrollController();
  late final PageController pageController = PageController();

  RxBool isLoading = true.obs;

  RxDouble pageScrollY = 0.0.obs;

  //是否显示返回顶部
  RxBool showBackTop = false.obs;

  RxBool isTabClick = false.obs;

  RxInt menuIndex = 0.obs;

  RxString currentTab = "".obs;

  Rx<MineMenuTabInfo> menuTabInfo = MineMenuTabInfo.fromJson({}).obs;

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

  changeMenuIndex(int index) => menuIndex.value = index;

  changeCurrentTab(String va) => currentTab.value = va;

  initPageData() async {
    isLoading.value = true;
    MineMenuTabInfo res = await MineApi.queryInfo();
    isLoading.value = false;
    menuTabInfo.value = res;
    if (res.tabList!.isNotEmpty) {
      currentTab.value = res.tabList![0].code!;
    }
  }

  refreshPage(VoidCallback freshSuccess, VoidCallback freshFail) async {
    var info = await MineApi.queryInfo();
    if (info != null) {
      menuTabInfo.value = info;
      freshSuccess();
    } else {
      freshFail();
    }
  }
}
