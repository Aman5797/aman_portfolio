import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class SkillTile extends StatefulWidget {
  const SkillTile(
    this.skill, {
    super.key,
  });

  final String skill;

  @override
  State<SkillTile> createState() => _SkillTileState();
}

class _SkillTileState extends State<SkillTile> {
  Color itemColor = AppColors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: itemColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: MouseRegion(
        onEnter: _onEnter,
        onExit: _onExit,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                widget.skill,
                style: AppStyles.s18.copyWith(color: itemColor),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onExit(event) {
    setState(() => itemColor = AppColors.white);
  }

  void _onEnter(event) {
    setState(() => itemColor = AppColors.primaryColor);
  }
}
