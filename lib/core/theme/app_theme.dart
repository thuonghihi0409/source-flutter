import 'package:flutter/material.dart';

import '../style/app_colors.dart';

class AppTheme {
  const AppTheme();

  ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.backgroundDark,
      error: AppColors.error,
      onPrimary: AppColors.onPrimary,
      onSecondary: AppColors.onBackground,
      onSurface: AppColors.white,
      onError: AppColors.onBackground,
      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,
    ),
  );
}
