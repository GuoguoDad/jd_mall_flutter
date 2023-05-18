import 'package:jd_mall_flutter/models/primary_category_list.dart';

class SelectedCategoryInfo {
  CategoryInfo? previous;
  CategoryInfo? current;
  CategoryInfo? next;

  SelectedCategoryInfo(this.previous, this.current, this.next);
}

class CategoryPageState {
  SelectedCategoryInfo? selectedCategoryInfo;
  List<CategoryInfo>? categoryList;

  CategoryPageState(this.selectedCategoryInfo, this.categoryList);
}
