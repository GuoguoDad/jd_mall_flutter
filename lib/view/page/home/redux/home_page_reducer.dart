import 'package:jd_mall_flutter/models/goods_page_info.dart';
import 'package:redux/redux.dart';
import 'package:jd_mall_flutter/view/page/home/redux/home_page_action.dart';
import 'package:jd_mall_flutter/view/page/home/redux/home_page_state.dart';

final homePageReducer = combineReducers<HomePageState>([
  //修改loading状态
  TypedReducer<HomePageState, SetLoadingAction>((state, action) => state..isLoading = action.value),
  //记录页面滚动距离
  TypedReducer<HomePageState, ChangePageScrollYAction>((state, action) => state..pageScrollY = action.value),
  //记录九宫格菜单滚动index
  TypedReducer<HomePageState, SetMenuSliderIndex>((state, action) => state..menuSliderIndex = action.value),
  //记录滚动图片index
  TypedReducer<HomePageState, SetCurrentTab>((state, action) => state..currentTab = action.value),
  //设置页面数据
  TypedReducer<HomePageState, SetHomePageInfoAction>((state, action) => state..homePageInfo = action.value),
  //初始化商品数据
  TypedReducer<HomePageState, InitGoodsPageAction>((state, action) => state
    ..pageNum = action.pageNum
    ..goodsPageInfo = action.value),
  //加载更多
  TypedReducer<HomePageState, MoreGoodsPageAction>((state, action) {
    List<GoodsList> goods = state.goodsPageInfo.goodsList ?? [];
    List<GoodsList>? goodsList = [...goods, ...?action.value.goodsList];

    return state
      ..pageNum = action.pageNum
      ..goodsPageInfo = GoodsPageInfo(
          goodsList: goodsList, totalCount: state.goodsPageInfo.totalCount, totalPageCount: state.goodsPageInfo.totalPageCount);
  }),
]);
