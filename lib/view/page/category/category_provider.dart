// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:jd_mall_flutter/models/primary_category_list.dart';
import 'package:jd_mall_flutter/models/second_group_category_info.dart';
import 'package:jd_mall_flutter/view/page/category/service.dart';

class CategoryProvider extends ChangeNotifier {

  //左侧一级分类默认选中信息
  CategoryInfo previous = CategoryInfo.fromJson({});
  CategoryInfo current = CategoryInfo.fromJson({});
  CategoryInfo next = CategoryInfo.fromJson({});

  bool isLoading = true;
  bool isTabClicked = false;
  List<CategoryInfo> categoryList = [];

  //二三级分类信息分组列表
  SecondGroupCategoryInfo secondGroupCategoryInfo = SecondGroupCategoryInfo.fromJson({});
  //二级分类默认选中的信息
  SecondCateList selectSecondCategoryInfo = SecondCateList.fromJson({});

  void setLoading(bool va) {
    isLoading = va;
    notifyListeners();
  }

  void setTabClicked(bool va) {
    isTabClicked = va;
    notifyListeners();
  }

  //选中左侧一级分类
  void selectLeftCategory(CategoryInfo prev, CategoryInfo curr, CategoryInfo nex) {
    previous = prev;
    current = curr;
    next = nex;
    notifyListeners();
  }

  //选中右侧二级分类
  void selectSecondCategory(SecondCateList selectSecondCateInfo, bool isClicked) {
    selectSecondCategoryInfo = selectSecondCateInfo;
    isTabClicked = isClicked;
    notifyListeners();
  }

  //加载页面数据
  Future<void> initPageData() async {
    isLoading = true;
    notifyListeners();

    PrimaryCategoryList res = await CategoryApi.queryCategoryInfo();
    List<CategoryInfo> list = res.categoryList ?? [];
    if (list.isNotEmpty) {
      SecondGroupCategoryInfo info = await CategoryApi.querySecondGroupCategoryInfo(list[0].code!);
      isLoading = false;
      SecondCateList selectSecondCateInfo = info.secondCateList!.isNotEmpty ? info.secondCateList![0] : SecondCateList.fromJson({});

      //一级分类列表
      categoryList = list;
      //设置默认选中的一级分类
      previous = CategoryInfo.fromJson({});
      current = list[0];
      next = list[1];

      //二三级分类信息分组列表
      secondGroupCategoryInfo = info;
      //二级分类默认选中
      selectSecondCategoryInfo = selectSecondCateInfo;
    } else {
      isLoading = false;
    }
    notifyListeners();
  }
}
