import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/page/welcome/welcome_page.dart';
import 'package:jd_mall_flutter/page/category/category_page.dart';
import 'package:jd_mall_flutter/page/cart/cart_page.dart';
import 'package:jd_mall_flutter/page/mine/mine_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getContent(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 24,
        enableFeedback: false,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black87,
        selectedItemColor: Colors.red,
        selectedLabelStyle: const TextStyle( fontSize: 14 ),
        unselectedLabelStyle: const TextStyle( fontSize: 14 ),
        items: const [
          BottomNavigationBarItem(
            icon: Image(image: AssetImage('images/ic_home.png'), width: 30, height: 30, fit: BoxFit.cover),
            activeIcon: Image(image: AssetImage('images/ic_home_active.png'), width: 30, height: 30, fit: BoxFit.cover),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage('images/ic_category.png'), width: 30, height: 30, fit: BoxFit.cover),
            activeIcon: Image(image: AssetImage('images/ic_category_active.png'), width: 30, height: 30, fit: BoxFit.cover),
            label: '分类',
          ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage('images/ic_cart.png'), width: 30, height: 30, fit: BoxFit.cover),
            activeIcon: Image(image: AssetImage('images/ic_cart_active.png'), width: 30, height: 30, fit: BoxFit.cover),
            label: '购物车',
          ),
          BottomNavigationBarItem(
            icon: Image(image: AssetImage('images/ic_mine.png'), width: 30, height: 30, fit: BoxFit.cover),
            activeIcon: Image(image: AssetImage('images/ic_mine_active.png'), width: 30, height: 30, fit: BoxFit.cover),
            label: '我的',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  _getContent(int selectIndex) {
    StatefulWidget content = const WelcomePage();
    switch(selectIndex){
      case 0:
        content = const WelcomePage();
        break;
      case 1:
        content = const CategoryPage();
        break;
      case 2:
        content = const CartPage();
        break;
      case 3:
        content = const MinePage();
        break;
    }
    return content;
  }
}