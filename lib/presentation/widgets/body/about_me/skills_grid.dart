import 'package:flutter/material.dart';

import '../../../../core/utils/app_constants.dart';
import 'skills_tile.dart';

class SkillsGrid extends StatelessWidget {
  const SkillsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: AppConstants.skills.map((skill) => SkillTile(skill)).toList(),
    );
  }
}
