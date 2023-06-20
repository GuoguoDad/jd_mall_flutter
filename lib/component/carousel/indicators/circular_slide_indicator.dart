import 'package:flutter/material.dart';

import 'slide_indicator.dart';

class CircularSlideIndicator implements SlideIndicator {
  const CircularSlideIndicator({
    this.itemSpacing = 20,
    this.indicatorRadius = 6,
    this.indicatorBorderWidth = 1,
    this.indicatorBorderColor,
    this.padding,
    this.alignment = Alignment.bottomCenter,
    this.currentIndicatorColor,
    this.indicatorBackgroundColor,
  });

  final AlignmentGeometry alignment;
  final Color? currentIndicatorColor;
  final Color? indicatorBackgroundColor;
  final Color? indicatorBorderColor;
  final double indicatorBorderWidth;
  final double indicatorRadius;
  final double itemSpacing;
  final EdgeInsets? padding;

  @override
  Widget build(int currentPage, double pageDelta, int itemCount) {
    var activeColor = const Color(0xFFFFFFFF);
    var backgroundColor = const Color(0x66FFFFFF);

    // if (SchedulerBinding.instance.window.platformBrightness ==
    //     Brightness.light) {
    //   activeColor = const Color(0xFF000000);
    //   backgroundColor = const Color.fromARGB(255, 163, 159, 159);
    // }

    return Container(
      alignment: alignment,
      padding: padding,
      child: SizedBox(
        width: itemCount * itemSpacing,
        height: indicatorRadius * 2,
        child: CustomPaint(
          painter: CircularIndicatorPainter(
            currentIndicatorColor: currentIndicatorColor ?? activeColor,
            indicatorBackgroundColor: indicatorBackgroundColor ?? backgroundColor,
            currentPage: currentPage,
            pageDelta: pageDelta,
            itemCount: itemCount,
            radius: indicatorRadius,
            indicatorBorderColor: indicatorBorderColor,
            borderWidth: indicatorBorderWidth,
          ),
        ),
      ),
    );
  }
}

class CircularIndicatorPainter extends CustomPainter {
  CircularIndicatorPainter({
    required this.currentPage,
    required this.pageDelta,
    required this.itemCount,
    this.radius = 12,
    double borderWidth = 2,
    required Color currentIndicatorColor,
    required Color indicatorBackgroundColor,
    this.indicatorBorderColor,
  }) {
    indicatorPaint.color = indicatorBackgroundColor;
    indicatorPaint.style = PaintingStyle.fill;
    indicatorPaint.isAntiAlias = true;
    currentIndicatorPaint.color = currentIndicatorColor;
    currentIndicatorPaint.style = PaintingStyle.fill;
    currentIndicatorPaint.isAntiAlias = true;

    if (indicatorBorderColor != null) {
      borderIndicatorPaint.color = indicatorBorderColor!;
      borderIndicatorPaint.style = PaintingStyle.stroke;
      borderIndicatorPaint.strokeWidth = borderWidth;
      borderIndicatorPaint.isAntiAlias = true;
    }
  }

  final Paint borderIndicatorPaint = Paint();
  final Paint currentIndicatorPaint = Paint();
  final int currentPage;
  final Color? indicatorBorderColor;
  final Paint indicatorPaint = Paint();
  final int itemCount;
  final double pageDelta;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final dx = itemCount < 2 ? size.width : (size.width - 2 * radius) / (itemCount - 1);
    final y = size.height / 2;
    var x = radius;

    for (var i = 0; i < itemCount; i++) {
      canvas.drawCircle(Offset(x, y), radius, indicatorPaint);
      x += dx;
    }

    canvas.save();
    var midX = radius + dx * currentPage;
    var midY = size.height / 2;
    final path = Path();
    path.addOval(Rect.fromLTRB(midX - radius, midY - radius, midX + radius, midY + radius));
    if (currentPage == itemCount - 1) {
      path.addOval(Rect.fromLTRB(0, midY - radius, 2 * radius, midY + radius));
      canvas.clipPath(path);
      canvas.drawCircle(Offset(2 * radius * pageDelta - radius, midY), radius, currentIndicatorPaint);
      midX += 2 * radius * pageDelta;
    } else {
      midX += dx;
      path.addOval(Rect.fromLTRB(midX - radius, midY - radius, midX + radius, midY + radius));
      midX -= dx;
      canvas.clipPath(path);
      midX += dx * pageDelta;
    }
    canvas.drawCircle(Offset(midX, midY), radius, currentIndicatorPaint);
    canvas.restore();

    if (indicatorBorderColor != null) {
      x = radius;
      for (var i = 0; i < itemCount; i++) {
        canvas.drawCircle(Offset(x, y), radius, borderIndicatorPaint);
        x += dx;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
