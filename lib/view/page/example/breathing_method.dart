import 'package:flutter/material.dart';

import 'package:jd_mall_flutter/component/common_header.dart';

class BreathingMethod extends StatefulWidget {
  const BreathingMethod({super.key});

  static const String name = "/breathingMethod";

  @override
  State<BreathingMethod> createState() => _BreathingMethodState();
}

class _BreathingMethodState extends State<BreathingMethod> with TickerProviderStateMixin {
  late AnimationController _extendController;
  late AnimationController _fadeController;

  @override
  void initState() {
    _extendController = AnimationController(vsync: this);
    _fadeController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _extendController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          commonHeader(context, title: "478呼吸法"),
          Expanded(
            child: Center(
              child: AnimatedBuilder(
                animation: _extendController,
                builder: (BuildContext context, Widget? child) {
                  return FadeTransition(
                    opacity: Tween(begin: 1.0, end: 0.4).animate(_fadeController),
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [Colors.blue.shade600, Colors.blue.shade100],
                          stops: [_extendController.value, _extendController.value + 0.1],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _extendController.duration = const Duration(seconds: 4);
          _extendController.forward();

          await Future.delayed(const Duration(seconds: 4));
          _fadeController.duration = const Duration(milliseconds: 2100);
          _fadeController.repeat(reverse: true);

          await Future.delayed(const Duration(seconds: 7));
          _fadeController.stop();
          _extendController.duration = const Duration(seconds: 7);
          _extendController.reverse();
        },
        backgroundColor: Colors.white,
        child: const Text(
          "开始",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
