import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/redux/app_state.dart';
import 'package:jd_mall_flutter/redux/app_store.dart';
import 'package:jd_mall_flutter/page/home/home_page.dart';

void main() {
  runApp(
    StoreProvider<AppState>(
      store: store,
      child: const MallApp()
    )
  );
}

class MallApp extends StatelessWidget {
  const MallApp({super.key});

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
