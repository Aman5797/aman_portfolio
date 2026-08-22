import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_extensions.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/animated_entrance.dart';
import '../../../../core/widgets/gradient_text.dart';
import 'intro_actions.dart';

class IntroText extends StatelessWidget {
  const IntroText({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.width < DeviceType.mobile.getMaxWidth();
    final align = isMobile ? TextAlign.center : TextAlign.start;
    final crossAxis =
        isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: crossAxis,
      children: [
        AnimatedEntrance(
          delay: const Duration(milliseconds: 100),
          child: Text(
            AppStrings.helloIM,
            style: context.width < DeviceType.ipad.getMaxWidth()
                ? AppStyles.s16.copyWith(color: AppColors.lowPriority)
                : AppStyles.s20.copyWith(color: AppColors.lowPriority),
            textAlign: align,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 200),
          child: GradientText(
            AppStrings.developerName,
            style: context.width < DeviceType.ipad.getMaxWidth()
                ? AppStyles.s36
                : AppStyles.s56,
            textAlign: align,
          ),
        ),
        const SizedBox(height: 4),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 300),
          child: _TypewriterText(
            text: AppStrings.developerTitle,
            style: context.width < DeviceType.ipad.getMaxWidth()
                ? AppStyles.s16.copyWith(color: AppColors.secondaryColor)
                : AppStyles.s24.copyWith(color: AppColors.secondaryColor),
          ),
        ),
        const SizedBox(height: 20),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 400),
          child: SizedBox(
            width: context.width < DeviceType.mobile.getMaxWidth()
                ? context.width - 20
                : context.width / 2.5,
            child: Text(
              AppStrings.introMsg,
              style: context.width < DeviceType.ipad.getMaxWidth()
                  ? AppStyles.s14.copyWith(height: 1.8)
                  : AppStyles.s18.copyWith(height: 1.8),
              textAlign: align,
              softWrap: true,
            ),
          ),
        ),
        const SizedBox(height: 36),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 500),
          child: const IntoActions(),
        ),
      ],
    );
  }
}

/// Renders [text] letter-by-letter with a blinking cursor.
class _TypewriterText extends StatefulWidget {
  const _TypewriterText({required this.text, required this.style});
  final String text;
  final TextStyle style;

  @override
  State<_TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<_TypewriterText>
    with SingleTickerProviderStateMixin {
  String _displayed = '';
  int _index = 0;
  Timer? _typeTimer;
  late AnimationController _cursorController;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    // Delay typewriter start so it fires after the slide-in animation
    Future.delayed(const Duration(milliseconds: 500), _startTyping);
  }

  void _startTyping() {
    if (!mounted) return;
    _typeTimer = Timer.periodic(const Duration(milliseconds: 55), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_index < widget.text.length) {
        setState(() => _displayed = widget.text.substring(0, ++_index));
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _typeTimer?.cancel();
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(_displayed, style: widget.style),
        AnimatedBuilder(
          animation: _cursorController,
          builder: (_, __) => Opacity(
            opacity: _cursorController.value > 0.5 ? 1.0 : 0.0,
            child: Text(
              '|',
              style: widget.style.copyWith(color: AppColors.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
