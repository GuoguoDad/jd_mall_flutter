import 'package:flutter/material.dart';

void main() {
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TabPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: const Text('text'),
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
}
