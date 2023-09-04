import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/component/common_header.dart';

class GestureSpring extends StatefulWidget {
  const GestureSpring({super.key});

  static const String name = "/gestureSpring";

  @override
  State<GestureSpring> createState() => _GestureSpringState();
}

const double _defaultSpringHeight = 100; //默认高度
const double _rateOfMove = 1.5; //移动距离与形变量比值

class _GestureSpringState extends State<GestureSpring> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  ValueNotifier<double> height = ValueNotifier<double>(_defaultSpringHeight);

  double offsetY = 0; //位移
  double lastMoveDistance = 0;

  double get distanceY => -offsetY / _rateOfMove;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400))
      ..addListener(() {
        //滑动结束，400毫秒animation.value值从0变为1， height逐渐变为原始值
        offsetY = _defaultSpringHeight * (1 - animation.value);
        height.value = _defaultSpringHeight + (-offsetY / _rateOfMove);
      });
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
  }

  @override
  void dispose() {
    height.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          commonHeader(context, title: "【手势】之弹簧"),
          Expanded(
            flex: 1,
            child: Center(
              child: GestureDetector(
                onVerticalDragUpdate: (dragUpdateDetails) {
                  offsetY += dragUpdateDetails.delta.dy;
                  double h = _defaultSpringHeight + distanceY;

                  if (h > 20 && h < 300) {
                    height.value = h;
                  }
                },
                onVerticalDragEnd: (dragEndDetails) {
                  lastMoveDistance = offsetY;
                  _controller.forward(from: 0); //滑动结束触发弹簧归位动画
                },
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: CustomPaint(
                    painter: SpringPainter(
                      count: 20,
                      height: height,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const double _springWidth = 40;

class SpringPainter extends CustomPainter {
  final int count;
  final ValueListenable<double> height;

  SpringPainter({required this.count, required this.height}) : super(repaint: height);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    //移动坐标点
    canvas.translate(size.width / 2 + _springWidth / 2, size.height);
    double hSpace = height.value / (count - 1);

    Path springPath = Path();
    //第一条线（最下面的直线）
    springPath.relativeLineTo(-_springWidth, 0);
    //循环画斜线
    for (int i = 1; i < count; i++) {
      springPath.relativeLineTo(i.isOdd ? _springWidth : -_springWidth, -hSpace);
    }
    //最后一条线(最上面的直线)
    springPath.relativeLineTo(count.isOdd ? _springWidth : -_springWidth, 0);
    canvas.drawPath(springPath, paint);
  }

  @override
  bool shouldRepaint(covariant SpringPainter oldDelegate) => oldDelegate.count != count || oldDelegate.height.value != height.value;
}
