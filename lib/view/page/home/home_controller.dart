import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:jd_mall_flutter/models/home_page_info.dart';
import 'package:jd_mall_flutter/view/page/home/service.dart';
import 'package:jd_mall_flutter/common/types/common.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;

  //横向滚动菜单PageView索引
  RxInt menuSliderIndex = 0.obs;

  //首页数据
  Rx<HomePageInfo> homePageInfo = HomePageInfo.fromJson({}).obs;

  @override
  void onReady() {
    initPageData();
    super.onReady();
  }

  setLoading(bool va) => isLoading.value = va;

  initPageData() async {
    isLoading.value = true;
    var info = await HomeApi.queryHomeInfo();
    isLoading.value = false;
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
