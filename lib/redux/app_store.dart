import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/redux/app_reducer.dart';
import 'package:jd_mall_flutter/redux/app_state.dart';
import 'package:jd_mall_flutter/page/welcome/redux/wel_page_state.dart';
import 'package:jd_mall_flutter/models/home_page_info.dart';
import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:jd_mall_flutter/models/primary_category_list.dart';
import 'package:jd_mall_flutter/models/second_group_category_info.dart';
import 'package:jd_mall_flutter/page/cart/redux/cart_page_state.dart';
import 'package:jd_mall_flutter/page/category/redux/category_page_state.dart';

import '../page/cart/redux/cart_page_middleware.dart';
import '../page/category/redux/category_page_middleware.dart';
import '../page/welcome/redux/wel_page_middleware.dart';

final store = Store<AppState>(reducers,
    initialState: AppState(
        WelPageState(true, 0, 0, "1", HomePageInfo.fromJson({}), 1, GoodsPageInfo.fromJson({})),
        CategoryPageState(SelectedCategoryInfo(CategoryInfo.fromJson({}), CategoryInfo.fromJson({}), CategoryInfo.fromJson({})),
            PrimaryCategoryList.fromJson({}).categoryList, SecondGroupCategoryInfo.fromJson({}), SecondCateList.fromJson({})),
        CartPageState([], 1, GoodsPageInfo.fromJson({}))),
    middleware: [WelPageMiddleware(), CategoryPageMiddleware(), CartPageMiddleware()]);
