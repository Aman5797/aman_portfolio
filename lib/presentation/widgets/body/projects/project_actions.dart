import 'package:aman_portfolio/data/models/project.dart';
import 'package:flutter/material.dart';

import 'package:aman_portfolio/core/utils/app_colors.dart';
import 'package:aman_portfolio/core/widgets/custom_button.dart';
import 'package:universal_html/html.dart' as html;

class ProjectActions extends StatelessWidget {
  const ProjectActions({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: CustomButton(
              label: 'iOS',
              borderColor: AppColors.primaryColor,
              onPressed: () {
                if (project.iosApp != null) {
                  html.window.open(project.iosApp!, '_blank');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Coming Soon...")));
                }
              },
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: CustomButton(
              label: 'Android',
              borderColor: AppColors.primaryColor,
              onPressed: () {
                if (project.iosApp != null) {
                  html.window.open(project.googlePlay!, '_blank');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Coming Soon...")));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
