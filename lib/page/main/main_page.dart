import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jd_mall_flutter/page/home/home_page.dart';
import 'package:jd_mall_flutter/page/category/category.dart';
import 'package:jd_mall_flutter/page/cart/cart_page.dart';
import 'package:jd_mall_flutter/page/mine/mine_page.dart';
import 'package:jd_mall_flutter/common/widget/image/asset_image.dart';
import 'package:jd_mall_flutter/common/localization/default_localizations.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const String name = "/home";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> pages = [const HomePage(), const CategoryPage(), const CartPage(), const MinePage()];

  @override
  Widget build(BuildContext context) {
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
          items: [
            BottomNavigationBarItem(
              icon: assetImage('images/ic_home.png', 30, 30),
              activeIcon: assetImage('images/ic_home_active.png', 30, 30),
              label: MallLocalizations.i18n(context).tab_main_home,
            ),
            BottomNavigationBarItem(
              icon: assetImage('images/ic_category.png', 30, 30),
              activeIcon: assetImage('images/ic_category_active.png', 30, 30),
              label: MallLocalizations.i18n(context).tab_main_category,
            ),
            BottomNavigationBarItem(
              icon: assetImage('images/ic_cart.png', 30, 30),
              activeIcon: assetImage('images/ic_cart_active.png', 30, 30),
              label: MallLocalizations.i18n(context).tab_main_cart,
            ),
            BottomNavigationBarItem(
              icon: assetImage('images/ic_mine.png', 30, 30),
              activeIcon: assetImage("images/ic_mine_active.png", 30, 30),
              label: MallLocalizations.i18n(context).tab_main_mine,
            )
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      )),
    );
  }
}
