import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_extensions.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/animated_entrance.dart';
import '../../../../core/widgets/gradient_text.dart';
import '../../../../core/widgets/scroll_controller_provider.dart';

class ExperienceInfo extends StatefulWidget {
  const ExperienceInfo({super.key});

  @override
  State<ExperienceInfo> createState() => _ExperienceInfoState();
}

class _ExperienceInfoState extends State<ExperienceInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController _counterController;
  late Animation<double> _counterAnim;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _counterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _counterAnim = CurvedAnimation(
      parent: _counterController,
      curve: Curves.easeOut,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => _setupVisibility());
  }

  void _setupVisibility() {
    final sc = ScrollControllerProvider.of(context);
    if (sc != null) {
      sc.addListener(() => _checkAndStart(sc));
    }
  }

  void _checkAndStart(ScrollController sc) {
    if (_started || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final pos = box.localToGlobal(Offset.zero);
    final screenH = MediaQuery.of(context).size.height;
    if (pos.dy < screenH * 0.92) {
      _started = true;
      _counterController.forward();
    }
  }

  @override
  void dispose() {
    _counterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedEntrance(
      delay: const Duration(milliseconds: 100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Animated counter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: 0.4),
                  blurRadius: 30,
                  spreadRadius: 2,
                )
              ],
            ),
            child: AnimatedBuilder(
              animation: _counterAnim,
              builder: (_, __) {
                final count = (_counterAnim.value * 5).floor();
                final display = _counterController.isCompleted
                    ? AppStrings.numOfExperience
                    : '$count+';
                return GradientText(
                  display,
                  gradient: const LinearGradient(
                    colors: [Colors.white, Colors.white70],
                  ),
                  style: context.width < DeviceType.mobile.getMaxWidth()
                      ? AppStyles.s48.copyWith(fontSize: 52)
                      : AppStyles.s56.copyWith(fontSize: 72),
                );
              },
            ),
          ),
          const SizedBox(width: 24),
          Flexible(
            child: Text(
              AppStrings.experienceMsg,
              style: _getStyle(context.width),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _getStyle(double w) {
    if (w < DeviceType.mobile.getMaxWidth()) return AppStyles.s14;
    if (w < DeviceType.ipad.getMaxWidth()) return AppStyles.s16;
    return AppStyles.s20.copyWith(color: AppColors.lightColor);
  }
}
