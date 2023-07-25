// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:jd_mall_flutter/component/carousel/components/overflow_page.dart';
import 'package:jd_mall_flutter/component/carousel/enums/carousel_page_changed_reason.dart';
import 'package:jd_mall_flutter/component/carousel/helpers/flutter_carousel_controller.dart';
import 'package:jd_mall_flutter/component/carousel/helpers/flutter_carousel_options.dart';
import 'package:jd_mall_flutter/component/carousel/helpers/flutter_carousel_state.dart';
import 'package:jd_mall_flutter/component/carousel/typedefs/widget_builder.dart';
import 'package:jd_mall_flutter/component/carousel/utils/flutter_carousel_utils.dart';

class ExpandableCarousel extends StatefulWidget {
  /// The default constructor
  const ExpandableCarousel({
    required this.items,
    required this.options,
    this.estimatedPageSize = 0.0,
    Key? key,
  })  : itemBuilder = null,
        itemCount = items != null ? items.length : 0,
        assert(items != null),
        super(key: key);

  /// The on demand item builder constructor
  const ExpandableCarousel.builder({
    required this.itemCount,
    required this.itemBuilder,
    required this.options,
    this.estimatedPageSize = 0.0,
    Key? key,
  })  : items = null,
        assert(itemCount != null),
        assert(itemBuilder != null),
        super(key: key);

  /// Setting it to a value much bigger than most pages' sizes might result in a
  /// reversed - "expand and shrink" - effect.
  final double estimatedPageSize;

  /// The widget item builder that will be used to build item on demand
  /// The third argument is the PageView's real index, can be used to cooperate
  /// with Hero.
  final ExtendedWidgetBuilder? itemBuilder;

  /// The count of items to be shown in the carousel
  final int? itemCount;

  /// The widgets to be shown in the carousel of default constructor
  final List<Widget>? items;

  /// [ExpandableCarouselOptions] to create a [ExpandableCarouselState] with
  final CarouselOptions options;

  @override
  ExpandableCarouselState createState() => ExpandableCarouselState();
}

class ExpandableCarouselState extends State<ExpandableCarousel> with TickerProviderStateMixin {
  /// mode is related to why the page is being changed
  CarouselPageChangedReason mode = CarouselPageChangedReason.controller;

  CarouselState? _carouselState;
  int _currentPage = 0;
  bool _firstPageLoaded = false;
  PageController? _pageController;
  double _pageDelta = 0.0;
  int _previousPage = 0;
  bool _shouldDisposePageController = false;
  late List<double> _sizes;
  Timer? _timer;

  @override
  void didUpdateWidget(covariant ExpandableCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    _carouselState!.options = options;
    _carouselState!.itemCount = widget.itemCount;

    /// [_pageController] needs to be re-initialized to respond
    /// to state changes
    _pageController = PageController(
      viewportFraction: options.viewportFraction,
      keepPage: options.keepPage,
      initialPage: _carouselState!.realPage,
    );

    _carouselState!.pageController = _pageController;

    /// handle autoplay when state changes
    _handleAutoPlay();

    _pageController?.addListener(() {
      setState(() {
        _currentPage = _pageController!.page!.floor();
        _pageDelta = _pageController!.page! - _pageController!.page!.floor();
      });
    });

    if (oldWidget.options.controller != widget.options.controller) {
      _pageController?.addListener(_updatePage);
      _shouldDisposePageController = widget.options.controller == null;
    }

    if (_shouldReinitializeHeights(oldWidget)) {
      _reinitializeSizes();
    }
  }

  @override
  void dispose() {
    _pageController?.removeListener(_updatePage);
    if (_shouldDisposePageController) {
      _pageController?.dispose();
    }
    _clearTimer();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _carouselState = CarouselState(
      options,
      _clearTimer,
      _resumeTimer,
      _changeMode,
    );

    _carouselState!.itemCount = widget.itemCount;
    carouselController.state = _carouselState;
    _carouselState!.initialPage = widget.options.initialPage;
    _carouselState!.realPage =
        options.enableInfiniteScroll ? _carouselState!.realPage + _carouselState!.initialPage : _carouselState!.initialPage;

    /// For Indicator
    _currentPage = widget.options.initialPage;

    _handleAutoPlay();

    _pageController = PageController(
      viewportFraction: options.viewportFraction,
      keepPage: options.keepPage,
      initialPage: _carouselState!.realPage,
    );

    _carouselState!.pageController = _pageController;

    _pageController!.addListener(() {
      setState(() {
        _currentPage = _pageController!.page!.floor();
        _pageDelta = _pageController!.page! - _pageController!.page!.floor();
      });
    });

    _sizes = _prepareSizes();
    _pageController?.addListener(_updatePage);
    _currentPage = _pageController!.initialPage.clamp(0, _sizes.length - 1);
    _previousPage = _currentPage - 1 < 0 ? 0 : _currentPage - 1;
    _shouldDisposePageController = widget.options.controller == null;
  }

  CarouselControllerImpl get carouselController => widget.options.controller != null
      ? widget.options.controller as CarouselControllerImpl
      : CarouselController() as CarouselControllerImpl;

  CarouselOptions get options => widget.options;

  bool get isBuilder => widget.itemBuilder != null;

  double get _currentSize => _sizes[_currentPage];

  double get _previousSize => _sizes[_previousPage];

  bool get _isHorizontalScroll => widget.options.scrollDirection == Axis.horizontal;

  void _changeMode(CarouselPageChangedReason mode) {
    mode = mode;
  }

  /// Timer
  Timer? _getTimer() {
    if (widget.options.autoPlay == true) {
      return Timer.periodic(widget.options.autoPlayInterval, (_) {
        final route = ModalRoute.of(context);
        if (route?.isCurrent == false) {
          return;
        }

        var previousReason = mode;
        _changeMode(CarouselPageChangedReason.timed);
        var nextPage = _carouselState!.pageController!.page!.round() + 1;
        var itemCount = widget.itemCount ?? widget.items!.length;

        if (nextPage >= itemCount && widget.options.enableInfiniteScroll == false) {
          if (widget.options.pauseAutoPlayInFiniteScroll) {
            _clearTimer();
            return;
          }
          nextPage = 0;
        }

        _carouselState!.pageController!
            .animateToPage(nextPage, duration: widget.options.autoPlayAnimationDuration, curve: widget.options.autoPlayCurve)
            .then((_) => _changeMode(previousReason));
      });
    }

    return null;
  }

  /// Clear Timer
  void _clearTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
  }

  /// Resume Timer
  void _resumeTimer() {
    _timer ??= _getTimer();
  }

  /// Autoplay
  void _handleAutoPlay() {
    var autoPlayEnabled = widget.options.autoPlay;

    if (autoPlayEnabled && _timer != null) return;

    _clearTimer();
    if (autoPlayEnabled) {
      _resumeTimer();
    }
  }

  void _onStart() {
    _changeMode(CarouselPageChangedReason.manual);
  }

  void _onPanDown() {
    if (widget.options.pauseAutoPlayOnTouch) {
      _clearTimer();
    }

    _changeMode(CarouselPageChangedReason.manual);
  }

  void _onPanUp() {
    if (widget.options.pauseAutoPlayOnTouch) {
      _resumeTimer();
    }
  }

  bool _shouldReinitializeHeights(ExpandableCarousel oldWidget) {
    if (oldWidget.itemBuilder != null && isBuilder) {
      return oldWidget.itemCount != widget.itemCount;
    }
    return oldWidget.items?.length != widget.items?.length;
  }

  void _reinitializeSizes() {
    final currentPageSize = _sizes[_currentPage];
    _sizes = _prepareSizes();

    if (_currentPage >= _sizes.length) {
      final differenceFromPreviousToCurrent = _previousPage - _currentPage;
      _currentPage = _sizes.length - 1;
      var previousReason = mode;
      _changeMode(CarouselPageChangedReason.timed);
      widget.options.onPageChanged?.call(_currentPage, previousReason);

      _previousPage = (_currentPage + differenceFromPreviousToCurrent).clamp(0, _sizes.length - 1);
    }

    _previousPage = _previousPage.clamp(0, _sizes.length - 1);
    _sizes[_currentPage] = currentPageSize;
  }

  Duration _getDuration() {
    if (_firstPageLoaded) {
      return widget.options.autoPlayAnimationDuration;
    }
    return Duration.zero;
  }

  List<double> _prepareSizes() {
    if (isBuilder) {
      return List.filled(widget.itemCount!, widget.estimatedPageSize);
    } else {
      return widget.items!.map((child) => widget.estimatedPageSize).toList();
    }
  }

  void _updatePage() {
    final newPage = _pageController?.page!.round();
    if (_currentPage != newPage) {
      setState(() {
        _firstPageLoaded = true;
        _previousPage = _currentPage;
        _currentPage = newPage!;
      });
    }
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final idx = getRealIndex(
      index + _carouselState!.initialPage,
      _carouselState!.realPage,
      widget.itemCount,
    );
    final item = widget.itemBuilder!(context, idx, index);
    return OverflowPage(
      onSizeChange: (size) => setState(
        () => _sizes[index] = _isHorizontalScroll ? size.height : size.width,
      ),
      alignment: Alignment.topCenter,
      scrollDirection: widget.options.scrollDirection,
      child: item,
    );
  }

  List<Widget> _sizeReportingChildren() => widget.items!
      .asMap()
      .map(
        (index, child) => MapEntry(
          index,
          OverflowPage(
            onSizeChange: (size) => setState(
              () => _sizes[index] = _isHorizontalScroll ? size.height : size.width,
            ),
            alignment: Alignment.topCenter,
            scrollDirection: widget.options.scrollDirection,
            child: child,
          ),
        ),
      )
      .values
      .toList();

  Widget _getGestureWrapper({required Widget child}) {
    var wrapper = child;

    return RawGestureDetector(
      gestures: {
        _MultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<_MultipleGestureRecognizer>(_MultipleGestureRecognizer.new,
            (_MultipleGestureRecognizer instance) {
          instance.onStart = (_) {
            _onStart();
          };
          instance.onDown = (_) {
            _onPanDown();
          };
          instance.onEnd = (_) {
            _onPanUp();
          };
          instance.onCancel = _onPanUp;
        }),
      },
      child: NotificationListener(
        onNotification: (dynamic notification) {
          if (widget.options.onScrolled != null && notification is ScrollUpdateNotification) {
            widget.options.onScrolled!(_carouselState!.pageController!.page);
          }
          return false;
        },
        child: wrapper,
      ),
    );
  }

  /// The method that builds the carousel
  Widget _buildCarouselWidget(BuildContext context) {
    if (isBuilder) {
      return PageView.builder(
        key: widget.options.pageViewKey,
        controller: _pageController,
        itemBuilder: _itemBuilder,
        itemCount: widget.itemCount,
        scrollBehavior: widget.options.scrollBehavior ??
            ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
              overscroll: false,
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
            ),
        onPageChanged: (int index) {
          var currentPage = getRealIndex(index + _carouselState!.initialPage, _carouselState!.realPage, widget.itemCount);
          if (widget.options.onPageChanged != null) {
            widget.options.onPageChanged!(currentPage, mode);
          }
        },
        reverse: widget.options.reverse,
        physics: widget.options.physics,
        pageSnapping: widget.options.pageSnapping,
        clipBehavior: widget.options.clipBehavior,
        scrollDirection: widget.options.scrollDirection,
        dragStartBehavior: widget.options.dragStartBehavior,
        allowImplicitScrolling: widget.options.allowImplicitScrolling,
        restorationId: widget.options.restorationId,
        padEnds: widget.options.padEnds,
      );
    }
    return PageView(
      key: widget.options.pageViewKey,
      controller: _pageController,
      scrollBehavior: widget.options.scrollBehavior ??
          ScrollConfiguration.of(context).copyWith(
            scrollbars: false,
            overscroll: false,
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
          ),
      onPageChanged: (int index) {
        var currentPage = getRealIndex(index + _carouselState!.initialPage, _carouselState!.realPage, widget.itemCount);
        if (widget.options.onPageChanged != null) {
          widget.options.onPageChanged!(currentPage, mode);
        }
      },
      reverse: widget.options.reverse,
      physics: widget.options.physics,
      pageSnapping: widget.options.pageSnapping,
      clipBehavior: widget.options.clipBehavior,
      scrollDirection: widget.options.scrollDirection,
      dragStartBehavior: widget.options.dragStartBehavior,
      allowImplicitScrolling: widget.options.allowImplicitScrolling,
      restorationId: widget.options.restorationId,
      padEnds: widget.options.padEnds,
      children: _sizeReportingChildren(),
    );
  }

  /// The method to build the slide indicator
  Widget _buildSlideIndicator() {
    return widget.options.slideIndicator!.build(
      _currentPage % widget.itemCount!,
      _pageDelta,
      widget.itemCount!,
    );
  }

  /// The method to build the carousel widget
  Widget _buildWidget(BuildContext context) {
    if (widget.options.showIndicator && widget.options.slideIndicator != null && widget.itemCount! > 1) {
      /// If [floatingIndicator] option is [true]
      if (widget.options.floatingIndicator) {
        return _getGestureWrapper(
          child: Stack(
            children: [
              _buildCarouselWidget(context),
              Positioned(
                bottom: 8.0,
                left: 0.0,
                right: 0.0,
                child: _buildSlideIndicator(),
              ),
            ],
          ),
        );
      }

      /// If [floatingIndicator] option is [false]
      return _getGestureWrapper(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: _buildCarouselWidget(context),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              flex: 0,
              child: _buildSlideIndicator(),
            ),
          ],
        ),
      );
    }

    return _getGestureWrapper(child: _buildCarouselWidget(context));
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: widget.options.autoPlayCurve,
      duration: _getDuration(),
      tween: Tween<double>(begin: _previousSize, end: _currentSize),
      builder: (context, value, child) => SizedBox(
        height: _isHorizontalScroll ? value : null,
        width: !_isHorizontalScroll ? value : null,
        child: child,
      ),
      child: _buildWidget(context),
    );
  }
}

class _MultipleGestureRecognizer extends PanGestureRecognizer {}
