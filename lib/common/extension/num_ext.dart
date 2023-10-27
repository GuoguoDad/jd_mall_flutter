//
//  NumExtension.dart
//  lib
//
//  Created by shang on 11/29/21 3:38 PM.
//  Copyright © 11/29/21 shang. All rights reserved.
//

// Dart imports:
import 'dart:math';

int randomInt({required int min, required int max}) {
  return min + Random().nextInt(max - min);
}

extension NumExt on num {}

extension DoubleExt on double {
  /// 2位小数
  double get fixed2 => double.parse(toStringAsFixed(2));

  /// 3位小数
  double get fixed3 => double.parse(toStringAsFixed(3));

  /// 转为百分比描述
  String toStringAsPercent(int fractionDigits) {
    if (this >= 1.0) {
      return "100%";
    }
    final result = toStringAsFixed(fractionDigits);
    var percentDes = "${result.replaceAll("0.", "")}%";
    if (percentDes.startsWith("0")) {
      percentDes = percentDes.substring(1);
    }
    return percentDes;
  }
}

extension IntExt on int {
  // /// 数字格式化
  // String numFormat([String? newPattern = '0,000', String? locale]) {
  //   final fmt = NumberFormat(newPattern, locale);
  //   return fmt.format(this);
  // }
}

extension IntFileExt on int {
  /// length 转为 MB 描述
  String get fileSizeDesc {
    final result = this / (1024 * 1024);
    final desc = "${result.toStringAsFixed(2)}MB";
    return desc;
  }

  /// 压缩质量( )
  int get compressQuality {
    int length = this;
    // var quality = 100;
    const mb = 1024 * 1024;
    if (length > 10 * mb) {
      return 20;
    }

    if (length > 8 * mb) {
      return 30;
    }

    if (length > 6 * mb) {
      return 40;
    }

    if (length > 4 * mb) {
      return 50;
    }

    if (length > 2 * mb) {
      return 60;
    }
    return 90;
  }
}
