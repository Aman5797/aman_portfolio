import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_enums.dart';
import '../../../core/utils/app_extensions.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/widgets/gradient_text.dart';

class DeveloperNameButton extends StatelessWidget {
  const DeveloperNameButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => html.window.location.reload(),
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: SizedBox(
          width: context.width < DeviceType.ipad.getMaxWidth()
              ? context.width * .5
              : context.width * .22,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: GradientText(
              AppStrings.developerName,
              style: AppStyles.s28,
            ),
          ),
        ),
      ),
    );
  }
}
