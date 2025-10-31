import 'package:flutter/material.dart';

class AppSpacing {
  // Private constructor to prevent instantiation
  AppSpacing._();

  // Base spacing unit (4px)
  static const double baseUnit = 4.0;

  // Spacing scale
  static const double xs = baseUnit; // 4px
  static const double sm = baseUnit * 2; // 8px
  static const double md = baseUnit * 4; // 16px
  static const double lg = baseUnit * 6; // 24px
  static const double xl = baseUnit * 8; // 32px
  static const double xxl = baseUnit * 12; // 48px
  static const double xxxl = baseUnit * 16; // 64px

  // Specific spacing values
  static const double paddingXS = xs;
  static const double paddingSM = sm;
  static const double paddingMD = md;
  static const double paddingLG = lg;
  static const double paddingXL = xl;

  static const double marginXS = xs;
  static const double marginSM = sm;
  static const double marginMD = md;
  static const double marginLG = lg;
  static const double marginXL = xl;

  // Screen padding
  static const double screenPadding = md; // 16px
  static const double screenPaddingHorizontal = md;
  static const double screenPaddingVertical = md;

  // Component spacing
  static const double buttonPadding = md; // 16px
  static const double inputPadding = md; // 16px
  static const double cardPadding = md; // 16px
  static const double listItemPadding = md; // 16px

  // Gap between elements
  static const double gapXS = xs; // 4px
  static const double gapSM = sm; // 8px
  static const double gapMD = md; // 16px
  static const double gapLG = lg; // 24px
  static const double gapXL = xl; // 32px

  // Border radius
  static const double radiusXS = 2.0;
  static const double radiusSM = 4.0;
  static const double radiusMD = 8.0;
  static const double radiusLG = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusXXL = 24.0;

  // Icon sizes
  static const double iconXS = 12.0;
  static const double iconSM = 16.0;
  static const double iconMD = 20.0;
  static const double iconLG = 24.0;
  static const double iconXL = 32.0;
  static const double iconXXL = 48.0;

  // Helper methods
  static EdgeInsets paddingAll(double value) => EdgeInsets.all(value);
  static EdgeInsets paddingHorizontal(double value) =>
      EdgeInsets.symmetric(horizontal: value);
  static EdgeInsets paddingVertical(double value) =>
      EdgeInsets.symmetric(vertical: value);
  static EdgeInsets paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);

  static const EdgeInsets cardPaddingAll = EdgeInsets.all(cardPadding);
  static const EdgeInsets buttonPaddingAll = EdgeInsets.all(buttonPadding);
  static const EdgeInsets inputPaddingAll = EdgeInsets.all(inputPadding);
}
