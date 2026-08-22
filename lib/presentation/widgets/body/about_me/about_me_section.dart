import 'package:flutter/material.dart';

import '../../../../core/utils/app_extensions.dart';
import '../../../../core/widgets/animated_entrance.dart';
import '../../../../core/widgets/section_label.dart';
import 'about_me_intro.dart';
import 'experience_info.dart';
import 'my_skills_section.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 100,
        top: context.height * .05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedEntrance(
            child: const SectionLabel(
              title: 'About Me',
              badge: 'Who I Am',
            ),
          ),
          const SizedBox(height: 40),
          const AboutMeIntro(),
          const SizedBox(height: 52),
          const ExperienceInfo(),
          const SizedBox(height: 80),
          const MySkillsSection(),
        ],
      ),
    );
  }
}
