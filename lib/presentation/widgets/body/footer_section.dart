import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      margin: const EdgeInsets.only(top: 60),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.glassBorder, width: 1),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Designed & Built by ${AppStrings.developerName}',
            style: AppStyles.s14.copyWith(
              color: AppColors.lightColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '© ${DateTime.now().year} All rights reserved. Built with Flutter Web',
            style: AppStyles.s12.copyWith(
              color: AppColors.lowPriority,
            ),
          ),
        ],
      ),
    );
  }
}
