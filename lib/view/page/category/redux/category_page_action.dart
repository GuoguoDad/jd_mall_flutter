import 'package:jd_mall_flutter/models/primary_category_list.dart';
import 'package:jd_mall_flutter/models/second_group_category_info.dart';
import 'category_page_state.dart';

class InitDataAction {
  InitDataAction();
}

class InitCategoryPageAction {
  SelectedCategoryInfo? selectedCategoryInfo;
  List<CategoryInfo>? categoryList;
  SecondGroupCategoryInfo? secondGroupCategoryInfo;

  SecondCateList? selectSecondCategoryInfo;

  InitCategoryPageAction(this.selectedCategoryInfo, this.categoryList, this.secondGroupCategoryInfo, this.selectSecondCategoryInfo);
}

class SelectCategoryAction {
  SelectedCategoryInfo? selectedCategoryInfo;

  SelectCategoryAction(this.selectedCategoryInfo);
}

class SelectSecondCategoryAction {
  SecondCateList? selectSecondCategoryInfo;

  SelectSecondCategoryAction(this.selectSecondCategoryInfo);
}
