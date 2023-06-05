import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/style/common_style.dart';
import 'package:shimmer/shimmer.dart';
import '../../common/skeleton/placeholders.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  static const String name = "/mine";

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Ink(
      width: 100,
      height: 42,
      decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFDE2F21), Color(0xFFEC592F)]),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        highlightColor: CommonStyle.themeColor,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          alignment: Alignment.center,
          child: const Text(
            '去结算',
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () {},
      ),
    )));
  }
}
