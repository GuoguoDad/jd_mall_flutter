// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:loading_indicator/loading_indicator.dart';

Widget loadingWidget(BuildContext context) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.white,
    child: const Center(
      child: SizedBox(
        width: 120,
        height: 120,
        child: LoadingIndicator(
          indicatorType: Indicator.ballClipRotateMultiple,
          colors: [Colors.grey],
          strokeWidth: 3,
          backgroundColor: Colors.transparent,
        ),
      ),
    ),
  );
}
