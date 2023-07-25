// Flutter imports:
import 'package:flutter/material.dart';

class SizeReportingWidget extends StatefulWidget {
  const SizeReportingWidget({
    Key? key,
    required this.child,
    required this.onSizeChange,
  }) : super(key: key);

  final Widget child;
  final ValueChanged<Size> onSizeChange;

  @override
  SizeReportingWidgetState createState() => SizeReportingWidgetState();
}

class SizeReportingWidgetState extends State<SizeReportingWidget> {
  Size? _oldSize;
  final _widgetKey = GlobalKey();

  void _notifySize() {
    final context = _widgetKey.currentContext;
    if (context == null) return;
    final size = context.size;
    if (_oldSize != size) {
      _oldSize = size;
      widget.onSizeChange(size!);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Container(
          key: _widgetKey,
          child: widget.child,
        ),
      ),
    );
  }
}
