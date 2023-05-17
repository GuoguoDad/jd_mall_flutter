import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/page/welcome/welcome.dart';
import 'package:jd_mall_flutter/page/category/category_page.dart';
import 'package:jd_mall_flutter/page/cart/cart_page.dart';
import 'package:jd_mall_flutter/page/mine/mine_page.dart';
import 'package:jd_mall_flutter/common/widget/image/asset_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String name = "/home";

  @override
  State<HomePage> createState() => _TabPageState();
}

class _TabPageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> pages = [const WelcomePage(), const CategoryPage(), const CartPage(), const MinePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        selectedItemColor: Colors.red,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        items: [
          BottomNavigationBarItem(
            icon: assetImage('images/ic_home.png', 30, 30),
            activeIcon: assetImage('images/ic_home_active.png', 30, 30),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: assetImage('images/ic_category.png', 30, 30),
            activeIcon: assetImage('images/ic_category_active.png', 30, 30),
            label: '分类',
          ),
          BottomNavigationBarItem(
            icon: assetImage('images/ic_cart.png', 30, 30),
            activeIcon: assetImage('images/ic_cart_active.png', 30, 30),
            label: '购物车',
          ),
          BottomNavigationBarItem(
            icon: assetImage('images/ic_mine.png', 30, 30),
            activeIcon: assetImage("images/ic_mine_active.png", 30, 30),
            label: '我的',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
