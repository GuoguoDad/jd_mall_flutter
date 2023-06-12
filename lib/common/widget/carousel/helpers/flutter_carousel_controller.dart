import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jd_mall_flutter/common/widget/carousel/enums/carousel_page_changed_reason.dart';
import 'package:jd_mall_flutter/common/widget/carousel/helpers/flutter_carousel_state.dart';
import 'package:jd_mall_flutter/common/widget/carousel/utils/flutter_carousel_utils.dart';

abstract class CarouselController {
  factory CarouselController() => CarouselControllerImpl();

  bool get ready;

  Future<void> get onReady;

  Future<void> nextPage({Duration? duration, Curve? curve});

  Future<void> previousPage({Duration? duration, Curve? curve});

  void jumpToPage(int page);

  Future<void> animateToPage(int page, {Duration? duration, Curve? curve});

  void startAutoPlay();

  void stopAutoPlay();
}

class CarouselControllerImpl implements CarouselController {
  final Completer<void> _readyCompleter = Completer<void>();
  CarouselState? _state;

  /// Animates the controlled [FlutterCarouselWidget] from the current page to the given page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  @override
  Future<void> animateToPage(int page, {Duration? duration = const Duration(milliseconds: 300), Curve? curve = Curves.linear}) async {
    final isNeedResetTimer = _state!.options.pauseAutoPlayOnManualNavigate;
    if (isNeedResetTimer) {
      _state!.onResetTimer();
    }
    final index = getRealIndex(_state!.pageController!.page!.toInt(), _state!.realPage - _state!.initialPage, _state!.itemCount);
    _setModeController();
    await _state!.pageController!.animateToPage(_state!.pageController!.page!.toInt() + page - index, duration: duration!, curve: curve!);
    if (isNeedResetTimer) {
      _state!.onResumeTimer();
    }
  }

  /// Changes which page is displayed in the controlled [FlutterCarouselWidget].
  ///
  /// Jumps the page position from its current value to the given value,
  /// without animation, and without checking if the new value is in range.
  @override
  void jumpToPage(int page) {
    final index = getRealIndex(_state!.pageController!.page!.toInt(), _state!.realPage - _state!.initialPage, _state!.itemCount);

    _setModeController();
    final pageToJump = _state!.pageController!.page!.toInt() + page - index;
    return _state!.pageController!.jumpToPage(pageToJump);
  }

  /// Animates the controlled [FlutterCarouselWidget] to the next page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  @override
  Future<void> nextPage({Duration? duration = const Duration(milliseconds: 300), Curve? curve = Curves.linear}) async {
    final isNeedResetTimer = _state!.options.pauseAutoPlayOnManualNavigate;
    if (isNeedResetTimer) {
      _state!.onResetTimer();
    }
    _setModeController();
    await _state!.pageController!.nextPage(duration: duration!, curve: curve!);
    if (isNeedResetTimer) {
      _state!.onResumeTimer();
    }
  }

  @override
  Future<void> get onReady => _readyCompleter.future;

  /// Animates the controlled [FlutterCarouselWidget] to the previous page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  @override
  Future<void> previousPage({Duration? duration = const Duration(milliseconds: 300), Curve? curve = Curves.linear}) async {
    final isNeedResetTimer = _state!.options.pauseAutoPlayOnManualNavigate;
    if (isNeedResetTimer) {
      _state!.onResetTimer();
    }
    _setModeController();
    await _state!.pageController!.previousPage(duration: duration!, curve: curve!);
    if (isNeedResetTimer) {
      _state!.onResumeTimer();
    }
  }

  @override
  bool get ready => _state != null;

  /// Starts the controlled [FlutterCarouselWidget] autoplay.
  ///
  /// The carousel will only autoPlay if the [autoPlay] parameter
  /// in [CarouselOptions] is true.
  @override
  void startAutoPlay() {
    _state!.onResumeTimer();
  }

  /// Stops the controlled [FlutterCarouselWidget] from autoplaying.
  ///
  /// This is a more on-demand way of doing this. Use the [autoPlay]
  /// parameter in [CarouselOptions] to specify the autoPlay behaviour of the carousel.
  @override
  void stopAutoPlay() {
    _state!.onResetTimer();
  }

  set state(CarouselState? state) {
    _state = state;
    if (!_readyCompleter.isCompleted) {
      _readyCompleter.complete();
    }
  }

  void _setModeController() => _state!.changeMode(CarouselPageChangedReason.controller);
}
