// Project imports:
import 'package:jd_mall_flutter/models/primary_category_list.dart';
import 'package:jd_mall_flutter/models/second_group_category_info.dart';

class SelectedCategoryInfo {
  CategoryInfo? previous;
  CategoryInfo? current;
  CategoryInfo? next;

  SelectedCategoryInfo(this.previous, this.current, this.next);
}

class CategoryPageState {
  bool isLoading;

  bool isTabClicked;

  //左侧一级分类默认选中信息
  SelectedCategoryInfo? selectedCategoryInfo;

  //左侧一级分类列表
  List<CategoryInfo>? categoryList;

  //二三级分类信息分组列表
  SecondGroupCategoryInfo? secondGroupCategoryInfo;

  //二级分类默认选中的信息
  SecondCateList? selectSecondCategoryInfo;

  CategoryPageState(this.isLoading, this.isTabClicked, this.selectedCategoryInfo, this.categoryList, this.secondGroupCategoryInfo,
      this.selectSecondCategoryInfo);
}
