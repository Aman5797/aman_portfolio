import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppStyles {
  static const TextStyle s56 = TextStyle(
    color: AppColors.white,
    fontSize: 56,
    fontWeight: FontWeight.w700,
    height: 1.1,
  );
  static const TextStyle s48 = TextStyle(
    color: AppColors.white,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: 1.15,
  );
  static const TextStyle s36 = TextStyle(
    color: AppColors.white,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );
  static const TextStyle s32 = TextStyle(
    color: AppColors.primaryColor,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );
  static const TextStyle s28 = TextStyle(
    color: AppColors.primaryColor,
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle s24 = TextStyle(
    color: AppColors.white,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle s20 = TextStyle(
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle s18 = TextStyle(
    color: AppColors.lightColor,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.7,
  );
  static const TextStyle s17 = TextStyle(
    color: AppColors.white,
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle s16 = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle s14 = TextStyle(
    color: AppColors.lightColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle s12 = TextStyle(
    color: AppColors.lowPriority,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  // Legacy alias kept for compatibility
  static const TextStyle s52 = s48;
}
