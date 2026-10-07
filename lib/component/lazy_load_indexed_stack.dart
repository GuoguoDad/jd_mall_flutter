// Flutter imports:
import 'package:flutter/widgets.dart';

/// An extended IndexedStack that builds the required widget only when it is needed, and returns the pre-built widget when it is needed again.
class LazyLoadIndexedStack extends StatefulWidget {
  /// Widget to be built when not loaded. Default widget is [Container].
  late final Widget unloadWidget;

  /// Same as alignment attribute of original IndexedStack.
  final AlignmentGeometry alignment;

  /// Same as sizing attribute of original IndexedStack.
  final StackFit sizing;

  /// Same as textDirection attribute of original IndexedStack.
  final TextDirection? textDirection;

  /// The index of the child to show.
  final int index;

  /// The widgets below this widget in the tree.
  ///
  /// A child widget will not be built until the index associated with it is specified.
  /// When the index associated with the widget is specified again, the built widget is returned.
  final List<Widget> children;

  /// Creates LazyLoadIndexedStack that wraps IndexedStack.
  LazyLoadIndexedStack({
    Key? key,
    Widget? unloadWidget,
    this.alignment = AlignmentDirectional.topStart,
    this.sizing = StackFit.loose,
    this.textDirection,
    required this.index,
    required this.children,
  }) : super(key: key) {
    this.unloadWidget = unloadWidget ?? Container();
  }

  @override
  LazyLoadIndexedStackState createState() => LazyLoadIndexedStackState();
}

class LazyLoadIndexedStackState extends State<LazyLoadIndexedStack> {
  late List<Widget> _children;
  final _stackKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _children = _initialChildren();
  }

  @override
  void didUpdateWidget(final LazyLoadIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.children.length != oldWidget.children.length) {
      _children = _initialChildren();
    }

    _children[widget.index] = widget.children[widget.index];
  }

  @override
  Widget build(final BuildContext context) {
    // 非当前页用 Offstage 跳过 layout/paint，并用 TickerMode 关闭动画。
    // 否则首页轮播等隐藏 tab 里的动画仍会持续驱动布局，造成周期性掉帧。
    return Stack(
      key: _stackKey,
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      fit: widget.sizing,
      children: [
        for (int i = 0; i < _children.length; i++)
          TickerMode(
            enabled: i == widget.index,
            child: Offstage(
              offstage: i != widget.index,
              child: _children[i],
            ),
          ),
      ],
    );
  }

  List<Widget> _initialChildren() {
    return widget.children.asMap().entries.map((entry) {
      final index = entry.key;
      final childWidget = entry.value;
      return index == widget.index ? childWidget : widget.unloadWidget;
    }).toList();
  }
}
