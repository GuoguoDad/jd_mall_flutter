// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:loading_indicator/loading_indicator.dart';

Widget loadingWidget(BuildContext context) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.transparent,
    child: const Center(
      child: SizedBox(
        width: 98,
        height: 98,
        child: LoadingIndicator(
          indicatorType: Indicator.ballClipRotateMultiple,
          colors: [Colors.grey],
          strokeWidth: 2,
          backgroundColor: Colors.transparent,
        ),
      ),
    ),
  );
}
