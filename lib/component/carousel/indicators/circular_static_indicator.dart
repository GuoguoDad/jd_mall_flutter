// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'slide_indicator.dart';

class CircularStaticIndicator extends SlideIndicator {
  CircularStaticIndicator({
    this.itemSpacing = 20,
    this.indicatorRadius = 6,
    this.padding,
    this.alignment = Alignment.bottomCenter,
    this.currentIndicatorColor,
    this.indicatorBackgroundColor,
    this.enableAnimation = false,
    this.indicatorBorderWidth = 1,
    this.indicatorBorderColor,
  });

  final AlignmentGeometry alignment;
  final Color? currentIndicatorColor;
  final bool enableAnimation;
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
    //   backgroundColor = const Color(0xFF878484);
    // }

    return Container(
      alignment: alignment,
      padding: padding,
      child: SizedBox(
        width: itemCount * itemSpacing,
        height: indicatorRadius * 2,
        child: CustomPaint(
          painter: CircularStaticIndicatorPainter(
            currentIndicatorColor: currentIndicatorColor ?? activeColor,
            indicatorBackgroundColor: indicatorBackgroundColor ?? backgroundColor,
            currentPage: currentPage,
            pageDelta: pageDelta,
            itemCount: itemCount,
            radius: indicatorRadius,
            enableAnimation: enableAnimation,
            indicatorBorderColor: indicatorBorderColor,
            borderWidth: indicatorBorderWidth,
          ),
        ),
      ),
    );
  }
}

class CircularStaticIndicatorPainter extends CustomPainter {
  CircularStaticIndicatorPainter({
    required this.currentPage,
    required this.pageDelta,
    required this.itemCount,
    this.radius = 12,
    required Color currentIndicatorColor,
    required Color indicatorBackgroundColor,
    this.enableAnimation = false,
    this.indicatorBorderColor,
    double borderWidth = 2,
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
  final bool enableAnimation;
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
      if (i == currentPage) {
        canvas.drawCircle(Offset(x, y), enableAnimation ? radius - radius * pageDelta : radius, currentIndicatorPaint);
      }
      if (enableAnimation && (i == currentPage + 1 || currentPage == itemCount - 1 && i == 0)) {
        canvas.drawCircle(Offset(x, y), enableAnimation ? radius * pageDelta : radius, currentIndicatorPaint);
      }
      x += dx;
    }
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
