// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/component/lazy_load_indexed_stack.dart';
import 'package:jd_mall_flutter/generated/assets.dart';
import 'package:jd_mall_flutter/generated/l10n.dart';
import 'package:jd_mall_flutter/view/page/cart/cart_page.dart';
import 'package:jd_mall_flutter/view/page/category/category.dart';
import 'package:jd_mall_flutter/view/page/home/home_page.dart';
import 'package:jd_mall_flutter/view/page/mine/mine_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  double iconSize = 30;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> pages = [const HomePage(), const CategoryPage(), const CartPage(), const MinePage()];

  @override
  Widget build(BuildContext context) {
    List<Map> barItems = [
      {"iconPath": Assets.imagesIcHome, "activeIconPath": Assets.imagesIcHomeActive, "label": S.of(context).tabMainHome},
      {"iconPath": Assets.imagesIcCategory, "activeIconPath": Assets.imagesIcCategoryActive, "label": S.of(context).tabMainCategory},
      {"iconPath": Assets.imagesIcCart, "activeIconPath": Assets.imagesIcCartActive, "label": S.of(context).tabMainCart},
      {"iconPath": Assets.imagesIcMine, "activeIconPath": Assets.imagesIcMineActive, "label": S.of(context).tabMainMine},
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: [0, 1].contains(_selectedIndex) ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: LazyLoadIndexedStack(
          index: _selectedIndex,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 24,
          enableFeedback: false,
          showUnselectedLabels: true,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.black87,
          selectedItemColor: CommonStyle.themeColor,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: barItems
              .map((item) => BottomNavigationBarItem(
                    icon: assetImage(item["iconPath"], iconSize, iconSize),
                    activeIcon: assetImage(item["activeIconPath"], iconSize, iconSize),
                    label: item["label"],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
