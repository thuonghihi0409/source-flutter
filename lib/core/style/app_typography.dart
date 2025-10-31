import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTypography {
  // Private constructor to prevent instantiation
  AppTypography._();

  // Font Family
  static const String fontFamily = 'Inter';

  // Font Weights
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // Heading Styles
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: bold,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: semiBold,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: semiBold,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle h5 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: semiBold,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle h6 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: semiBold,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Title Styles (Material Design 3)
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: semiBold,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: medium,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: medium,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Body Text Styles
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 17,
    fontWeight: regular,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: regular,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: regular,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle buttonLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: bold,
    color: AppColors.buttonTextPrimary,
    height: 1.2,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: bold,
    color: AppColors.buttonTextPrimary,
    height: 1.2,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: bold,
    color: AppColors.buttonTextPrimary,
    height: 1.2,
  );

  // Secondary Button Text Styles
  static const TextStyle buttonSecondaryLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 17,
    fontWeight: bold, // 700 as requested
    color: AppColors.buttonTextSecondary,
    height: 1.2,
  );

  static const TextStyle buttonSecondaryMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: bold, // 700 as requested
    color: AppColors.buttonTextSecondary,
    height: 1.2,
  );

  static const TextStyle buttonSecondarySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: bold, // 700 as requested
    color: AppColors.buttonTextSecondary,
    height: 1.2,
  );

  // Caption and Label Styles
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: regular,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: medium,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: medium,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: medium,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Input Field Styles
  static const TextStyle inputText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 17,
    fontWeight: regular, // 400 as requested
    color: AppColors.inputText,
    height: 1.5,
  );

  static const TextStyle inputPlaceholder = TextStyle(
    fontFamily: fontFamily,
    fontSize: 17,
    fontWeight: regular,
    color: AppColors.inputPlaceholder,
    height: 1.5,
  );

  static const TextStyle inputLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: medium,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Error and Helper Text Styles
  static const TextStyle errorText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: regular,
    color: AppColors.error,
    height: 1.3,
  );

  static const TextStyle helperText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: regular,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  // App Bar Styles
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: semiBold,
    color: AppColors.hexWhite,
    height: 1.3,
  );

  // Splash Screen Styles
  static const TextStyle splashTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: bold,
    color: AppColors.hexWhite,
    height: 1.2,
  );

  static const TextStyle splashSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: regular,
    color: AppColors.hexWhite,
    height: 1.3,
  );

  static const TextStyle splashVersion = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: regular,
    color: AppColors.hexWhite,
    height: 1.2,
  );

  // Status Text Styles
  static const TextStyle statusActive = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: medium,
    color: AppColors.statusActive,
    height: 1.3,
  );

  static const TextStyle statusPending = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: medium,
    color: AppColors.statusPending,
    height: 1.3,
  );

  static const TextStyle statusCompleted = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: medium,
    color: AppColors.statusCompleted,
    height: 1.3,
  );

  static const TextStyle statusCancelled = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: medium,
    color: AppColors.statusCancelled,
    height: 1.3,
  );

  // Helper methods
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  static TextStyle withSize(TextStyle style, double fontSize) {
    return style.copyWith(fontSize: fontSize);
  }

  static TextStyle withWeight(TextStyle style, FontWeight fontWeight) {
    return style.copyWith(fontWeight: fontWeight);
  }

  static TextStyle withOpacity(TextStyle style, double opacity) {
    return style.copyWith(color: style.color?.withOpacity(opacity));
  }
}
