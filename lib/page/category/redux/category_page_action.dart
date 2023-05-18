import '../../../models/primary_category_list.dart';
import 'category_page_state.dart';

class InitDataAction {
  InitDataAction();
}

class InitCategoryPageAction {
  SelectedCategoryInfo? selectedCategoryInfo;
  List<CategoryInfo>? categoryList;

  InitCategoryPageAction(this.selectedCategoryInfo, this.categoryList);
}

class SelectCategoryAction {
  SelectedCategoryInfo? selectedCategoryInfo;

  SelectCategoryAction(this.selectedCategoryInfo);
}
