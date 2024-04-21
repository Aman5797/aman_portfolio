import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_extensions.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_enums.dart';
import '../../../core/utils/app_styles.dart';
import '../../blocs/home_bloc/home_bloc.dart';

class CustomHeaderBtn extends StatelessWidget {
  const CustomHeaderBtn({super.key, required this.headerIndex, this.onTap});

  final int headerIndex;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<HomeBloc>().add(ChangeAppBarHeadersIndex(headerIndex));
        onTap?.call();
      },
      style: TextButton.styleFrom(
        textStyle: AppStyles.s16,
        foregroundColor: _getHeaderColor(
          currentIndex: context.read<HomeBloc>().appBarHeaderIndex,
          headerIndex: headerIndex,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 26,
        ),
        child: Text(
          AppBarHeaders.values[headerIndex].getString(),
        ),
      ),
    );
  }

  Color _getHeaderColor({required currentIndex, required int headerIndex}) {
    if (currentIndex == headerIndex) {
      return AppColors.primaryColor;
    } else {
      return AppColors.white;
    }
  }
}
