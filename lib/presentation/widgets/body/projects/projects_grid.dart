import 'package:flutter/material.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_extensions.dart';
import '../../../../core/widgets/animated_entrance.dart';
import 'project_item.dart';

class ProjectsGrid extends StatelessWidget {
  const ProjectsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = AppConstants.projects;
    final crossAxisCount = _getCrossAxisCount(context.width);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        mainAxisExtent: _getMainAxisExtent(context.width),
      ),
      itemBuilder: (context, index) {
        return AnimatedEntrance(
          delay: Duration(milliseconds: 100 * index),
          child: ProjectItem(
            project: projects[index],
            index: index,
          ),
        );
      },
      itemCount: projects.length,
    );
  }

  int _getCrossAxisCount(double deviceWidth) {
    if (deviceWidth < DeviceType.mobile.getMaxWidth()) {
      return 1;
    } else if (deviceWidth < DeviceType.smallScreenLaptop.getMaxWidth()) {
      return 2;
    } else {
      return 3;
    }
  }

  double _getMainAxisExtent(double deviceWidth) {
    if (deviceWidth < DeviceType.mobile.getMaxWidth()) {
      return 360;
    } else if (deviceWidth < DeviceType.ipad.getMaxWidth()) {
      return 360;
    } else if (deviceWidth < DeviceType.smallScreenLaptop.getMaxWidth()) {
      return 360;
    } else {
      return 360;
    }
  }
}
