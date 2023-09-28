// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/common_header.dart';

class SnowManDemo extends StatefulWidget {
  const SnowManDemo({super.key});

  @override
  State<SnowManDemo> createState() => _SnowManDemoState();
}

double screenWidth = 0;
double screenHeight = 0;

class _SnowManDemoState extends State<SnowManDemo> with SingleTickerProviderStateMixin {
  late AnimationController _container;

  @override
  void initState() {
    _container = AnimationController(duration: const Duration(milliseconds: 100), vsync: this)..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _container.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = getScreenWidth(context);
    screenHeight = getScreenHeight(context);

    List<SnowFlake> snowflakes = List.generate(1000, (index) => SnowFlake());

    return Scaffold(
      body: Column(
        children: [
          commonHeader(context, title: "CustomPointer Demo"),
          Expanded(
            flex: 1,
            child: Container(
              width: screenWidth,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue, Colors.white],
                  stops: [0.0, 0.95],
                ),
              ),
              child: AnimatedBuilder(
                animation: _container,
                builder: (BuildContext context, Widget? child) {
                  return CustomPaint(
                    size: Size(screenWidth, 300), //指定画布大小
                    painter: MyPainter(snowflakes),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  List<SnowFlake> snowflakes;

  MyPainter(this.snowflakes);

  @override
  void paint(Canvas canvas, Size size) {
    Paint whitePaint = Paint()..color = Colors.white;
    //头
    canvas.drawCircle(Offset(size.width / 2, size.height / 2 + 100), 50, whitePaint);

    canvas.drawOval(Rect.fromCenter(center: Offset(size.width / 2, size.height / 2 + 270), width: 200, height: 280), whitePaint);

    for (var snowflake in snowflakes) {
      canvas.drawCircle(Offset(snowflake.x, snowflake.y), snowflake.radius, whitePaint);
      snowflake.fall();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class SnowFlake {
  double x = Random().nextDouble() * screenWidth;
  double y = Random().nextDouble() * screenHeight;
  double radius = Random().nextDouble() * 2 + 2;
  double speed = Random().nextDouble() * 4 + 4;

  fall() {
    y += speed;
    if (y > screenHeight) {
      y = 0;
      x = Random().nextDouble() * screenWidth;
      radius = Random().nextDouble() * 2 + 2;
      speed = Random().nextDouble() * 4 + 4;
    }
  }
}
