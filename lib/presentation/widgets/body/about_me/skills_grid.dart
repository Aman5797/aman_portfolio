import 'package:flutter/material.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../data/models/skill.dart';
import 'skills_tile.dart';

class SkillsGrid extends StatelessWidget {
  const SkillsGrid({super.key, this.skills});

  final List<Skill>? skills;

  @override
  Widget build(BuildContext context) {
    final list = skills ?? AppConstants.skills;
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: list.map((skill) => SkillTile(skill)).toList(),
    );
  }
}
