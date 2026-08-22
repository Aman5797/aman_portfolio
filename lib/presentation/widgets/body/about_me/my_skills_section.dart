import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/animated_entrance.dart';
import '../../../../core/widgets/gradient_text.dart';
import '../../../../core/utils/app_constants.dart';
import 'skills_grid.dart';

class MySkillsSection extends StatelessWidget {
  const MySkillsSection({super.key});

  // Category groups matching the order in AppConstants.skills
  static const _categories = [
    _Category(label: '📱 Mobile Development', start: 0, count: 12),
    _Category(label: '⚙️ Backend & APIs', start: 12, count: 5),
    _Category(label: '🛠 Dev Tools', start: 17, count: 5),
    _Category(label: '🔐 Auth & Payments', start: 22, count: 6),
    _Category(label: '🤖 AI / LLM', start: 28, count: 2),
  ];

  @override
  Widget build(BuildContext context) {
    final skills = AppConstants.skills;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedEntrance(
          child: GradientText(
            'Skills & Technologies',
            style: AppStyles.s36,
          ),
        ),
        const SizedBox(height: 36),
        ..._categories.asMap().entries.map((entry) {
          final i = entry.key;
          final cat = entry.value;
          final end = (cat.start + cat.count).clamp(0, skills.length);
          final catSkills = skills.sublist(cat.start, end);

          return AnimatedEntrance(
            delay: Duration(milliseconds: 80 * i),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: const Color(0x0DFFFFFF),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    child: Text(
                      cat.label,
                      style: AppStyles.s14.copyWith(
                        color: AppColors.lightColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SkillsGrid(skills: catSkills),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _Category {
  final String label;
  final int start;
  final int count;
  const _Category(
      {required this.label, required this.start, required this.count});
}
