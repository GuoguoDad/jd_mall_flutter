import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/common_header.dart';

class InterlacedAnimationDemo extends StatefulWidget {
  const InterlacedAnimationDemo({super.key});

  static const String name = "/interlacedAnimationDemo";

  @override
  State<InterlacedAnimationDemo> createState() => _State();
}

class _State extends State<InterlacedAnimationDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          commonHeader(context, title: "交错动画Demo"),
          Expanded(
              flex: 1,
              child: Container(
                width: getScreenWidth(context),
                padding: EdgeInsets.only(top: 50, left: (getScreenWidth(context) - 300) / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimationBox(
                      _controller,
                      const Interval(0.0, 0.2),
                      Colors.blue[100],
                    ),
                    AnimationBox(
                      _controller,
                      const Interval(0.2, 0.4),
                      Colors.blue[300],
                    ),
                    AnimationBox(
                      _controller,
                      const Interval(0.4, 0.6),
                      Colors.blue[500],
                    ),
                    AnimationBox(
                      _controller,
                      const Interval(0.6, 0.8),
                      Colors.blue[700],
                    ),
                    AnimationBox(
                      _controller,
                      const Interval(0.8, 1.0),
                      Colors.blue[900],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class AnimationBox extends StatelessWidget {
  final AnimationController _controller;
  final Interval interval;
  final Color? color;

  const AnimationBox(this._controller, this.interval, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween(begin: Offset.zero, end: const Offset(0.1, 0))
          .chain(CurveTween(curve: Curves.bounceOut))
          .chain(CurveTween(curve: interval))
          .animate(_controller),
      child: Container(
        width: 300,
        height: 80,
        color: color,
      ),
    );
  }
}
