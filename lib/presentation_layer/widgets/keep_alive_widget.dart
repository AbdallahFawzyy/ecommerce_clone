import 'package:flutter/material.dart';

/// A widget that prevents its child from being rebuilt when the widget tree is rebuilt.
///
/// The [KeepAliveWidget] is a stateful widget that utilizes the [AutomaticKeepAliveClientMixin]
/// to keep the [child] widget alive in the widget tree, preventing it from being
/// rebuilt when the parent widget tree gets rebuilt. This can help maintain the state
/// within the [child] widget and potentially improve the performance of your app
/// by avoiding unnecessary rebuilds.
///
/// This widget takes a single [child] widget as a parameter, which is the widget
/// you want to preserve across rebuilds.
///
/// Example Usage:
/// ```dart
/// KeepAliveWidget(
///   child: YourChildWidget(),
/// ),
/// ```
class KeepAliveWidget extends StatefulWidget {
  /// Creates an instance of [KeepAliveWidget].
  ///
  /// The [child] parameter must not be null.
  const KeepAliveWidget({
    super.key,
    required this.child,
  });

  /// The widget that should be preserved across rebuilds.
  ///
  /// This widget will not be rebuilt when the parent widget tree is rebuilt.
  final Widget child;

  @override
  State<KeepAliveWidget> createState() => _KeepAliveWidgetState();
}

class _KeepAliveWidgetState extends State<KeepAliveWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
