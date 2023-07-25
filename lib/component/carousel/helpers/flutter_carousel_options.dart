// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/component/carousel/enums/carousel_page_changed_reason.dart';
import 'package:jd_mall_flutter/component/carousel/enums/center_page_enlarge_strategy.dart';
import 'package:jd_mall_flutter/component/carousel/helpers/flutter_carousel_controller.dart';
import 'package:jd_mall_flutter/component/carousel/indicators/circular_slide_indicator.dart';
import 'package:jd_mall_flutter/component/carousel/indicators/slide_indicator.dart';

class CarouselOptions {
  CarouselOptions({
    this.height,
    this.aspectRatio,
    this.viewportFraction = 0.9,
    this.initialPage = 0,
    this.enableInfiniteScroll = false,
    this.reverse = false,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 5),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 300),
    this.autoPlayCurve = Curves.easeInCubic,
    this.enlargeCenterPage = false,
    this.controller,
    this.onPageChanged,
    this.onScrolled,
    this.physics = const BouncingScrollPhysics(),
    this.scrollDirection = Axis.horizontal,
    this.pauseAutoPlayOnTouch = true,
    this.pauseAutoPlayOnManualNavigate = true,
    this.pauseAutoPlayInFiniteScroll = false,
    this.pageViewKey,
    this.keepPage = true,
    this.enlargeStrategy = CenterPageEnlargeStrategy.scale,
    this.disableCenter = false,
    this.showIndicator = true,
    this.floatingIndicator = true,
    this.indicatorMargin = 8.0,
    this.slideIndicator = const CircularSlideIndicator(),
    this.clipBehavior = Clip.antiAlias,
    this.scrollBehavior,
    this.pageSnapping = true,
    this.padEnds = true,
    this.dragStartBehavior = DragStartBehavior.start,
    this.allowImplicitScrolling = false,
    this.restorationId,
  }) : assert(showIndicator == true ? slideIndicator != null : true);

  /// Called whenever the page in the center of the viewport changes.
  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;

  /// Controls whether the widget's pages will respond to [RenderObject.showOnScreen], which will allow for implicit accessibility scrolling.
  ///
  /// Corresponds to Material's PageView's allowImplicitScrolling parameter: https://api.flutter.dev/flutter/widgets/PageView-class.html
  final bool allowImplicitScrolling;

  /// Aspect ratio is used if no height have been declared.
  ///
  /// Defaults to 1:1 (square) aspect ratio.
  final double? aspectRatio;

  /// Enables auto play, sliding one page at a time.
  ///
  /// Use [autoPlayInterval] to determent the frequency of slides.
  /// Defaults to false.
  final bool autoPlay;

  /// The animation duration between two transitioning pages while in auto playback.
  ///
  /// Defaults to 500 ms.
  final Duration autoPlayAnimationDuration;

  /// Determines the animation curve physics.
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve autoPlayCurve;

  /// Sets Duration to determent the frequency of slides when
  ///
  /// [autoPlay] is set to true.
  /// Defaults to 5 seconds.
  final Duration autoPlayInterval;

  /// The content will be clipped (or not) according to this option.
  ///
  /// Corresponds to Material's PageView's clipBehavior parameter: https://api.flutter.dev/flutter/widgets/PageView-class.html
  final Clip clipBehavior;

  /// A [MapController], used to control the map.
  final CarouselController? controller;

  /// Whether or not to disable the `Center` widget for each slide.
  final bool disableCenter;

  /// Determines the way that drag start behavior is handled.
  ///
  /// Corresponds to Material's PageView's dragStartBehavior parameter: https://api.flutter.dev/flutter/widgets/PageView-class.html
  final DragStartBehavior dragStartBehavior;

  ///Determines if carousel should loop infinitely or be limited to item length.
  ///
  ///Defaults to true, i.e. infinite loop.
  final bool enableInfiniteScroll;

  /// Determines if current page should be larger then the side images,
  /// creating a feeling of depth in the carousel.
  ///
  /// Defaults to false.
  final bool? enlargeCenterPage;

  /// Use `enlargeStrategy` to determine which method to enlarge the center page.
  final CenterPageEnlargeStrategy enlargeStrategy;

  /// Whether or not to float `SlideIndicator` over `Carousel`.
  final bool floatingIndicator;

  /// Set carousel height and overrides any existing [aspectRatio].
  final double? height;

  /// Indicator margin
  final double? indicatorMargin;

  /// The initial page to show when first creating the [CarouselSlider].
  ///
  /// Defaults to 0.
  final int initialPage;

  /// Whether or not to keep pages in PageView
  final bool keepPage;

  /// Called whenever the carousel is scrolled
  final ValueChanged<double?>? onScrolled;

  /// Whether to add padding to both ends of the list.
  /// If this is set to true and [viewportFraction] < 1.0, padding will be
  /// added such that the first and last child slivers will be in the center
  /// of the viewport when scrolled all the way to the start or end,
  /// respectively.
  /// If [viewportFraction] >= 1.0, this property has no effect.
  /// This property defaults to true and must not be null.
  final bool padEnds;

  /// Set to false to disable page snapping, useful for custom scroll behavior.
  ///
  /// Default to `true`.
  final bool pageSnapping;

  /// Pass a `PageStorageKey` if you want to keep the PageView's position when
  /// it was recreated.
  final PageStorageKey<dynamic>? pageViewKey;

  /// If `enableInfiniteScroll` is `false`, and `autoPlay` is `true`, this option
  /// decide the carousel should go to the first item when it reach the last item or not.
  /// If set to `true`, the auto play will be paused when it reach the last item.
  /// If set to `false`, the auto play function will animate to the first item when it was
  /// in the last item.
  final bool pauseAutoPlayInFiniteScroll;

  /// If `true`, the auto play function will be paused when user is calling
  /// pageController's `nextPage` or `previousPage` or `animateToPage` method.
  /// And after the animation complete, the auto play will be resumed.
  /// Default to `true`.
  final bool pauseAutoPlayOnManualNavigate;

  /// If `true`, the auto play function will be paused when user is interacting with
  /// the carousel, and will be resumed when user finish interacting.
  /// Default to `true`.
  final bool pauseAutoPlayOnTouch;

  /// How the carousel should respond to user input.
  ///
  /// For example, determines how the items continues to animate after the
  /// user stops dragging the page view.
  ///
  /// The physics are modified to snap to page boundaries using
  /// [PageScrollPhysics] prior to being used.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /// Restoration ID to save and restore the scroll offset of the scrollable.
  ///
  /// Corresponds to Material's PageView's restorationId parameter: https://api.flutter.dev/flutter/widgets/PageView-class.html
  final String? restorationId;

  /// Reverse the order of items if set to true.
  ///
  /// Defaults to false.
  final bool reverse;

  ///A ScrollBehavior that will be applied to this widget individually.
  //
  // Defaults to null, wherein the inherited ScrollBehavior is copied and modified to alter the viewport decoration, like Scrollbars.
  //
  // ScrollBehaviors also provide ScrollPhysics. If an explicit ScrollPhysics is provided in physics, it will take precedence, followed by scrollBehavior, and then the inherited ancestor ScrollBehavior.
  //
  // The ScrollBehavior of the inherited ScrollConfiguration will be modified by default to not apply a Scrollbar.
  final ScrollBehavior? scrollBehavior;

  /// The axis along which the page view scrolls.
  ///
  /// Defaults to [Axis.horizontal].
  final Axis scrollDirection;

  /// Whether or not to show the `SlideIndicator` for each slide.
  final bool showIndicator;

  /// Use `slideIndicator` to determine which indicator you want to show for each slide.
  final SlideIndicator? slideIndicator;

  /// The fraction of the viewport that each page should occupy.
  ///
  /// Defaults to 0.8, which means each page fills 80% of the carousel.
  final double viewportFraction;

  /// Copy With Constructor
  CarouselOptions copyWith({
    double? height,
    double? aspectRatio,
    double? viewportFraction,
    int? initialPage,
    bool? enableInfiniteScroll,
    bool? reverse,
    bool? autoPlay,
    Duration? autoPlayInterval,
    Duration? autoPlayAnimationDuration,
    Curve? autoPlayCurve,
    bool? enlargeCenterPage,
    Axis? scrollDirection,
    CarouselController? carouselController,
    Function(int index, CarouselPageChangedReason reason)? onPageChanged,
    ValueChanged<double?>? onScrolled,
    ScrollPhysics? physics,
    bool? pageSnapping,
    bool? pauseAutoPlayOnTouch,
    bool? pauseAutoPlayOnManualNavigate,
    bool? pauseAutoPlayInFiniteScroll,
    PageStorageKey<dynamic>? pageViewKey,
    CenterPageEnlargeStrategy? enlargeStrategy,
    bool? disableCenter,
    SlideIndicator? slideIndicator,
    bool? showIndicator,
    bool? floatingIndicator,
    double? indicatorMargin,
    bool? keepPage,
    bool? padEnds,
    Clip? clipBehavior,
    DragStartBehavior? dragStartBehavior,
    ScrollBehavior? scrollBehavior,
    bool? allowImplicitScrolling,
    String? restorationId,
  }) {
    return CarouselOptions(
      height: height ?? this.height,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      viewportFraction: viewportFraction ?? this.viewportFraction,
      initialPage: initialPage ?? this.initialPage,
      enableInfiniteScroll: enableInfiniteScroll ?? this.enableInfiniteScroll,
      reverse: reverse ?? this.reverse,
      autoPlay: autoPlay ?? this.autoPlay,
      autoPlayInterval: autoPlayInterval ?? this.autoPlayInterval,
      autoPlayAnimationDuration: autoPlayAnimationDuration ?? this.autoPlayAnimationDuration,
      autoPlayCurve: autoPlayCurve ?? this.autoPlayCurve,
      enlargeCenterPage: enlargeCenterPage ?? this.enlargeCenterPage,
      onPageChanged: onPageChanged ?? this.onPageChanged,
      onScrolled: onScrolled ?? this.onScrolled,
      physics: physics ?? this.physics,
      pageSnapping: pageSnapping ?? this.pageSnapping,
      scrollDirection: scrollDirection ?? this.scrollDirection,
      pauseAutoPlayOnTouch: pauseAutoPlayOnTouch ?? this.pauseAutoPlayOnTouch,
      pauseAutoPlayOnManualNavigate: pauseAutoPlayOnManualNavigate ?? this.pauseAutoPlayOnManualNavigate,
      pauseAutoPlayInFiniteScroll: pauseAutoPlayInFiniteScroll ?? this.pauseAutoPlayInFiniteScroll,
      pageViewKey: pageViewKey ?? this.pageViewKey,
      keepPage: keepPage ?? this.keepPage,
      enlargeStrategy: enlargeStrategy ?? this.enlargeStrategy,
      disableCenter: disableCenter ?? this.disableCenter,
      showIndicator: showIndicator ?? this.showIndicator,
      floatingIndicator: floatingIndicator ?? this.floatingIndicator,
      indicatorMargin: indicatorMargin ?? this.indicatorMargin,
      slideIndicator: slideIndicator ?? this.slideIndicator,
      padEnds: padEnds ?? this.padEnds,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      dragStartBehavior: dragStartBehavior ?? this.dragStartBehavior,
      scrollBehavior: scrollBehavior ?? this.scrollBehavior,
      allowImplicitScrolling: allowImplicitScrolling ?? this.allowImplicitScrolling,
      restorationId: restorationId ?? this.restorationId,
    );
  }
}
