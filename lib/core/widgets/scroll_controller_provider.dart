import 'package:flutter/material.dart';

/// Provides the main [ScrollController] to the widget subtree via InheritedWidget.
/// [AnimatedEntrance] uses this to detect scroll position for visibility-triggered animations.
class ScrollControllerProvider extends InheritedWidget {
  const ScrollControllerProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  final ScrollController controller;

  static ScrollController? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ScrollControllerProvider>()
        ?.controller;
  }

  @override
  bool updateShouldNotify(ScrollControllerProvider oldWidget) => false;
}
