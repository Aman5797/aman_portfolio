import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';

import 'skills_grid.dart';

class MySkillsSection extends StatelessWidget {
  const MySkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            AppStrings.mySkills,
            style: AppStyles.s32,
          ),
        ),
        const SizedBox(height: 32),
        const SkillsGrid(),
      ],
    );
  }
}
