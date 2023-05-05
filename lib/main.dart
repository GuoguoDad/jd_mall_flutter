import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/page/home/home_page.dart';

void main() {
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(splashColor: const Color.fromRGBO(0, 0, 0, 0)),
      initialRoute: HomePage.name,
      routes: {
        HomePage.name: (context) => const HomePage()
      },
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
