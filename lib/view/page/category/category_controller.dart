// Package imports:
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

// Project imports:
import 'package:jd_mall_flutter/models/primary_category_list.dart';
import 'package:jd_mall_flutter/models/second_group_category_info.dart';
import 'package:jd_mall_flutter/view/page/category/service.dart';

class CategoryController extends GetxController {
  //左侧一级分类默认选中信息
  Rx<CategoryInfo> previous = CategoryInfo.fromJson({}).obs;
  Rx<CategoryInfo> current = CategoryInfo.fromJson({}).obs;
  Rx<CategoryInfo> next = CategoryInfo.fromJson({}).obs;

  RxBool isLoading = true.obs;

  RxBool isTabClicked = false.obs;

  //左侧一级分类列表
  RxList<CategoryInfo> categoryList = <CategoryInfo>[].obs;

  //二三级分类信息分组列表
  Rx<SecondGroupCategoryInfo> secondGroupCategoryInfo = SecondGroupCategoryInfo.fromJson({}).obs;

  //二级分类默认选中的信息
  Rx<SecondCateList> selectSecondCategoryInfo = SecondCateList.fromJson({}).obs;

  @override
  void onReady() {
    initPageData();
    super.onReady();
  }

  setLoading(bool va) => isLoading.value = va;

  setTabClicked(bool va) => isTabClicked.value = va;

  //选中左侧一级分类
  selectLeftCategory(CategoryInfo prev, CategoryInfo curr, CategoryInfo nex) {
    previous.value = prev;
    current.value = curr;
    next.value = nex;
  }

  //选中右侧二级分类
  selectSecondCategory(SecondCateList selectSecondCateInfo, bool isClicked) {
    selectSecondCategoryInfo.value = selectSecondCateInfo;
    isTabClicked.value = isClicked;
  }

  //加载页面数据
  initPageData() async {
    isLoading.value = true;
    PrimaryCategoryList res = await CategoryApi.queryCategoryInfo();
    List<CategoryInfo> list = res.categoryList ?? [];
    if (list.isNotEmpty) {
      SecondGroupCategoryInfo info = await CategoryApi.querySecondGroupCategoryInfo(list[0].code!);
      isLoading.value = false;
      SecondCateList selectSecondCateInfo = info.secondCateList!.isNotEmpty ? info.secondCateList![0] : SecondCateList.fromJson({});

      //一级分类列表
      categoryList.value = list;
      //设置默认选中的一级分类
      previous.value = CategoryInfo.fromJson({});
      current.value = list[0];
      next.value = list[1];

      //二三级分类信息分组列表
      secondGroupCategoryInfo.value = info;
      //二级分类默认选中
      selectSecondCategoryInfo.value = selectSecondCateInfo;
    } else {
      isLoading.value = false;
    }
  }
}
