import 'package:aman_portfolio/presentation/widgets/body/intro/intro_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_extensions.dart';
import '../../../../data/models/responsive_size.dart';

/// Profile image wrapped in a rotating gradient ring with a glow effect.
class IntroCircleImageBox extends StatelessWidget {
  const IntroCircleImageBox({super.key});

  @override
  Widget build(BuildContext context) {
    final size = ResponsiveSize(
      deviceWidth: context.width,
      mobileSize: context.width * .62,
      ipadSize: context.width * .4,
      smallScreenSize: context.width * .29,
    ).getSize()!;
    final outerSize = ResponsiveSize(
      deviceWidth: context.width,
      mobileSize: context.width * .78,
      ipadSize: context.width * .50,
      smallScreenSize: context.width * .37,
    ).getSize()!;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Outer glow
        OuterGlowWidget(size: size),
        SizedBox(
          height: outerSize,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2000),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Rotating gradient ring
                RotatedRingWidget(size: size),
                // Profile image (counter-rotated so it stays still)
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: IntroImage(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RotatedRingWidget extends StatefulWidget {
  const RotatedRingWidget({
    super.key,
    required this.size,
  });

  final double size;

  @override
  State<RotatedRingWidget> createState() => _RotatedRingWidgetState();
}

class _RotatedRingWidgetState extends State<RotatedRingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Transform.rotate(
        angle: _controller.value * 2 * 3.14159,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.ringGradient,
          ),
        ),
      ),
    );
  }
}

class OuterGlowWidget extends StatelessWidget {
  const OuterGlowWidget({
    super.key,
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.35),
            blurRadius: 60,
            spreadRadius: 8,
          ),
          BoxShadow(
            color: AppColors.secondaryColor.withValues(alpha: 0.2),
            blurRadius: 90,
            spreadRadius: -10,
          ),
        ],
      ),
    );
  }
}
