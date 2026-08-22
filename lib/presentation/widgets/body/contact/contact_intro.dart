import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/animated_entrance.dart';
import '../../../../core/widgets/section_label.dart';
import 'social_medial_icons.dart';

class ContactIntro extends StatelessWidget {
  const ContactIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedEntrance(
          child: const SectionLabel(
            title: AppStrings.contact,
            badge: 'Get In Touch',
          ),
        ),
        const SizedBox(height: 16),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 100),
          child: Text(
            AppStrings.contactMsg,
            style: AppStyles.s18.copyWith(height: 1.7),
            softWrap: true,
          ),
        ),
        const SizedBox(height: 24),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 200),
          child: const SocialMediaIcons(),
        ),
      ],
    );
  }
}
