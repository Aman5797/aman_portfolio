import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/animated_entrance.dart';
import '../../../../core/widgets/section_label.dart';

class ProjectsIntro extends StatelessWidget {
  const ProjectsIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedEntrance(
          child: const SectionLabel(
            title: AppStrings.featuredProjects,
            badge: 'Portfolio',
          ),
        ),
        const SizedBox(height: 12),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 100),
          child: Text(
            AppStrings.projectsMsg,
            style: AppStyles.s18,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
