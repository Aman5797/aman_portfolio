import 'package:flutter/material.dart';
import 'scroll_controller_provider.dart';

/// Wraps [child] with a scroll-triggered fade + slide-up entrance animation.
/// The animation plays once the widget enters the visible viewport.
/// Use [delay] to stagger multiple items within the same section.
class AnimatedEntrance extends StatefulWidget {
  const AnimatedEntrance({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.slideDy = 0.12,
    this.duration = const Duration(milliseconds: 600),
  });

  final Widget child;
  final Duration delay;

  /// Fractional vertical offset to start from (fraction of child height).
  /// 0.12 means start 12% lower and slide up into place.
  final double slideDy;
  final Duration duration;

  @override
  State<AnimatedEntrance> createState() => _AnimatedEntranceState();
}

class _AnimatedEntranceState extends State<AnimatedEntrance>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: Offset(0, widget.slideDy), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    WidgetsBinding.instance.addPostFrameCallback((_) => _setup());
  }

  void _setup() {
    final sc = ScrollControllerProvider.of(context);
    if (sc != null) {
      _checkVisibility(sc);
      sc.addListener(() => _checkVisibility(sc));
    } else {
      // No scroll controller found: just animate in after delay
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  void _checkVisibility(ScrollController sc) {
    if (_hasAnimated || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;

    final pos = box.localToGlobal(Offset.zero);
    final screenH = MediaQuery.of(context).size.height;

    // Trigger when top of widget is within the lower 90% of the screen
    if (pos.dy < screenH * 0.95 && pos.dy > -box.size.height) {
      _hasAnimated = true;
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
