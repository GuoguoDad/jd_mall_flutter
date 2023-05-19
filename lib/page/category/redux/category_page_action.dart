import '../../../models/primary_category_list.dart';
import '../../../models/second_group_category_info.dart';
import 'category_page_state.dart';

class InitDataAction {
  InitDataAction();
}

class InitCategoryPageAction {
  SelectedCategoryInfo? selectedCategoryInfo;
  List<CategoryInfo>? categoryList;
  SecondGroupCategoryInfo? secondGroupCategoryInfo;

  CateList? selectSecondCategoryInfo;

  InitCategoryPageAction(this.selectedCategoryInfo, this.categoryList, this.secondGroupCategoryInfo, this.selectSecondCategoryInfo);
}

class SelectCategoryAction {
  SelectedCategoryInfo? selectedCategoryInfo;

  SelectCategoryAction(this.selectedCategoryInfo);
}

class SelectSecondCategoryAction {
  CateList? selectSecondCategoryInfo;

  SelectSecondCategoryAction(this.selectSecondCategoryInfo);
}
