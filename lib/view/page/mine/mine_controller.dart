// Package imports:
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

// Project imports:
import 'package:jd_mall_flutter/common/types/common.dart';
import 'package:jd_mall_flutter/models/mine_menu_tab_info.dart';
import 'package:jd_mall_flutter/view/page/mine/service.dart';

class MineController extends GetxController {
  RxBool isLoading = true.obs;

  RxInt menuIndex = 0.obs;

  RxString currentTab = "".obs;

  Rx<MineMenuTabInfo> menuTabInfo = MineMenuTabInfo.fromJson({}).obs;

  @override
  void onReady() {
    initPageData();
    super.onReady();
  }

  setLoading(bool va) => isLoading.value = va;

  changeMenuIndex(int index) => menuIndex.value = index;

  changeCurrentTab(String va) => currentTab.value = va;

  initPageData() async {
    isLoading.value = true;
    MineMenuTabInfo res = await MineApi.queryInfo();
    isLoading.value = false;
    menuTabInfo.value = res;
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
