import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jd_mall_flutter/view/page/home/home_page.dart';
import 'package:jd_mall_flutter/view/page/category/category.dart';
import 'package:jd_mall_flutter/view/page/cart/cart_page.dart';
import 'package:jd_mall_flutter/view/page/mine/mine_page.dart';
import 'package:jd_mall_flutter/component/image/asset_image.dart';
import 'package:jd_mall_flutter/common/localization/default_localizations.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const String name = "/mainPage";

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
      {"iconPath": "images/ic_home.png", "activeIconPath": "images/ic_home_active.png", "label": MallLocalizations.i18n(context).tab_main_home},
      {"iconPath": "images/ic_category.png", "activeIconPath": "images/ic_category_active.png", "label": MallLocalizations.i18n(context).tab_main_category},
      {"iconPath": "images/ic_cart.png", "activeIconPath": "images/ic_cart_active.png", "label": MallLocalizations.i18n(context).tab_main_cart},
      {"iconPath": "images/ic_mine.png", "activeIconPath": "images/ic_mine_active.png", "label": MallLocalizations.i18n(context).tab_main_mine},
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: [0, 1].contains(_selectedIndex) ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Material(
        child: Scaffold(
          body: IndexedStack(
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
            selectedLabelStyle: const TextStyle(fontSize: 14),
            unselectedLabelStyle: const TextStyle(fontSize: 14),
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
      ),
    );
  }
}
