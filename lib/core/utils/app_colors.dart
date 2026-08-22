import 'package:flutter/material.dart';

abstract class AppColors {
  // ── Base Backgrounds ──────────────────────────────────────────────
  static const Color scaffoldColor = Color(0xff0A0A14);
  static const Color appBarColor = Color(0xff0A0A14);
  static const Color cardColor = Color(0xff0F0F1A);
  static const Color darkColor = Color(0xff050510);

  // ── Accent ───────────────────────────────────────────────────────
  static const Color primaryColor = Color(0xff7C3AED); // vibrant violet
  static const Color primaryDim = Color(0xff6D28D9);
  static const Color secondaryColor = Color(0xff06B6D4); // cyan
  static const Color accentBlue = Color(0xff3B82F6);
  static const Color primaryLight = Color(0xff1E1B4B); // deep indigo bg

  // ── Text ─────────────────────────────────────────────────────────
  static const Color white = Color(0xffffffff);
  static const Color lightColor = Color(0xffCBD5E1);
  static const Color lowPriority = Color(0xff64748B);

  // ── Glass / Frosted ──────────────────────────────────────────────
  static const Color glassBg = Color(0x0DFFFFFF); // 5% white
  static const Color glassBorder = Color(0x1AFFFFFF); // 10% white

  // ── Utility ──────────────────────────────────────────────────────
  static const Color transparent = Color(0x00000000);

  // ── Gradients ────────────────────────────────────────────────────
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xff7C3AED), Color(0xff06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradientHoriz = LinearGradient(
    colors: [Color(0xff7C3AED), Color(0xff06B6D4)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0x1A7C3AED), Color(0x0D06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const SweepGradient ringGradient = SweepGradient(
    colors: [
      Color(0xff7C3AED),
      Color(0xff3B82F6),
      Color(0xff06B6D4),
      Color(0xff7C3AED),
    ],
  );
}
