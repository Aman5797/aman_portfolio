import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_enums.dart';
import '../../../core/utils/app_extensions.dart';
import 'custom_menu_btn.dart';
import 'developer_name_btn.dart';
import 'horizontal_headers.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: AppConstants.appBarHeight,
          decoration: BoxDecoration(
            color: AppColors.scaffoldColor.withValues(alpha: 0.75),
            border: const Border(
              bottom: BorderSide(color: AppColors.glassBorder, width: 1),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: _getHorizontalPadding(context),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const DeveloperNameButton(),
              context.width > DeviceType.ipad.getMaxWidth()
                  ? const HorizontalHeaders()
                  : const CustomMenuBtn(),
            ],
          ),
        ),
      ),
    );
  }

  double _getHorizontalPadding(BuildContext context) {
    return context.width < DeviceType.ipad.getMaxWidth()
        ? context.width * .04
        : context.width * .08;
  }
}
