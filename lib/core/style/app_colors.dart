import 'package:flutter/material.dart';

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors (Based on HEX ERP Design)
  static const Color primary = Color(0xFF0066FF); // Main blue from design
  static const Color primaryLight = Color(
    0xFF3388FF,
  ); // Light blue variant of #0066FF
  static const Color primaryDark = Color(
    0xFF0044CC,
  ); // Dark blue variant of #0066FF
  static const Color primaryContainer = Color(0xFFE8F0FF);

  // Secondary Colors
  static const Color secondary = Color(0xFF64748B);
  static const Color secondaryLight = Color(0xFF94A3B8);
  static const Color secondaryDark = Color(0xFF475569);
  static const Color secondaryContainer = Color(0xFFF6F6F6);

  // Success Colors (Updated to #0066FF)
  static const Color success = Color(0xFF0066FF); // Main blue #0066FF
  static const Color successLight = Color(0xFF3388FF); // Light blue variant
  static const Color successDark = Color(0xFF0044CC); // Dark blue variant
  static const Color successContainer = Color(
    0xFFE6F2FF,
  ); // Light blue container

  // Warning Colors
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color yellowLight = Color(0xFFFEE685);

  // Error Colors
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);
  static const Color errorContainer = Color(0xFFFEE2E2);

  // Info Colors
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoDark = Color(0xFF2563EB);
  static const Color infoContainer = Color(0xFFDBEAFE);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  // Gray Scale
  static const Color gray50 = Color(0xFFF8FAFC);
  static const Color gray100 = Color(0xFFF1F5F9);
  static const Color gray200 = Color(0xFFE2E8F0);
  static const Color gray300 = Color(0xFFCBD5E1);
  static const Color gray400 = Color(0xFF94A3B8);
  static const Color gray500 = Color(0xFF64748B);
  static const Color gray600 = Color(0xFF475569);
  static const Color gray700 = Color(0xFF334155);
  static const Color gray800 = Color(0xFF1E293B);
  static const Color gray900 = Color(0xFF0F172A);

  // Background Colors
  static const Color background = Color(0xFF121320);
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color surfaceVariant = Color(0xFFF8FAFC);
  static const Color surfaceVariantDark = Color(0xFF334155);

  // Text Colors
  static const Color onSurface = Color(0xFF1E293B);
  static const Color onBackground = Color(0xFFFFFFFF);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Outline Colors
  static const Color outline = Color(0xFFE2E8F0);
  static const Color outlineVariant = Color(0xFFF1F5F9);

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textDisabled = Color(0xFFCBD5E1);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFFFFFFFF);

  // Border Colors
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF334155);
  static const Color borderFocus = Color(0xFF126CEE);
  static const Color borderError = Color(0xFFEF4444);

  // Custom Colors
  static const Color darkCard = Color(0xFF262B36); // Card background dark
  static const Color customGray = Color(0xFF617289);

  // HRM Specific Colors (Updated to #0066FF)
  static const Color attendance = Color(
    0xFF0066FF,
  ); // Blue for attendance #0066FF
  static const Color leave = Color(
    0xFF0066FF,
  ); // Blue for leave (using primary)
  static const Color expense = Color(0xFFF59E0B); // Orange for expense
  static const Color approval = Color(0xFF8B5CF6); // Purple for approval
  static const Color pending = Color(0xFFF59E0B); // Orange for pending
  static const Color approved = Color(0xFF0066FF); // Blue for approved #0066FF
  static const Color rejected = Color(0xFFEF4444); // Red for rejected
  static const Color disabled = Color(0xFFD9D9D9); // Gray for cancelled

  // HEX ERP Brand Colors (Updated to #0066FF)
  static const Color hexBlue = Color(0xFF0066FF); // Main HEX blue #0066FF
  static const Color hexBlueLight = Color(0xFF3388FF); // Light HEX blue
  static const Color hexBlueDark = Color(0xFF0044CC); // Dark HEX blue
  static const Color hexWhite = Color(0xFFFFFFFF); // White for text on blue
  static const Color hexGray = Color(0xFF6B7280); // Gray for secondary text

  // Status Colors (Updated to #0066FF)
  static const Color statusActive = Color(0xFF0066FF); // Main blue #0066FF
  static const Color statusInactive = Color(0xFF64748B);
  static const Color statusPending = Color(0xFFF59E0B);
  static const Color statusCompleted = Color(0xFF0066FF); // Main blue #0066FF
  static const Color statusCancelled = Color(0xFFEF4444);

  // Gradient Colors (Based on HEX ERP Design)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDark, primaryLight], // #2855AE to #7292CF
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, primaryDark],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondary, secondaryLight],
  );

  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [success, successLight],
  );

  // Background Gradient Colors (Based on your background image)
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE8F4FD), // Very light blue (top-left)
      Color(0xFFF8FBFF), // Almost white (center)
      Color(0xFFFFFFFF), // Pure white (right and bottom)
    ],
    stops: [0.0, 0.3, 1.0],
  );

  // DnPay Brand Gradient (Updated to #0066FF)
  static const LinearGradient dnpayGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0066FF), // Main blue #0066FF
      Color(0xFF3388FF), // Light blue variant
      Color(0xFFE6F2FF), // Very light blue container
    ],
  );

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);

  // Overlay Colors
  static const Color overlayLight = Color(0x1AFFFFFF);
  static const Color overlayMedium = Color(0x33FFFFFF);
  static const Color overlayDark = Color(0x4D000000);

  // Button Colors (Updated to #0066FF)
  static const Color buttonPrimary = Color(
    0xFF0066FF,
  ); // Main button color #0066FF
  static const Color buttonPrimaryHover = Color(
    0xFF0052CC,
  ); // Button hover state
  static const Color buttonSecondary = Color(
    0xFFFFFFFF,
  ); // Secondary button (white)
  static const Color buttonSecondaryBorder = Color(
    0xFF0066FF,
  ); // Secondary button border #0066FF
  static const Color buttonTextPrimary = Color(
    0xFFFFFFFF,
  ); // White text on primary button
  static const Color buttonTextSecondary = Color(
    0xFF0066FF,
  ); // Blue text on secondary button #0066FF

  // Input Field Colors
  static const Color inputBackground = Color(
    0xFFFFFFFF,
  ); // White input background
  static const Color inputBorder = Color(0xFFE5E7EB); // Light gray border
  static const Color inputBorderFocus = Color(
    0xFF0066FF,
  ); // Blue border when focused #0066FF
  static const Color inputText = Color(0xFF1F2937); // Dark text in inputs
  static const Color inputPlaceholder = Color(
    0xFF9CA3AF,
  ); // Placeholder text color

  // Screen Background Colors
  static const Color screenBackground = Color(
    0xFFFFFFFF,
  ); // White background for login screens
  static const Color splashBackground = Color(
    0xFF0066FF,
  ); // Blue background for splash screen #0066FF

  // Additional colors for status chips (already defined above, just for reference)

  // QR Code Slider Background
  static const Color qrCodeSliderBackground = Color(0xFF182437);

  // Helper methods
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  static Color lighten(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness(
      (hsl.lightness + amount).clamp(0.0, 1.0),
    );
    return hslLight.toColor();
  }

  static Color darken(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  // Design System Constants
  static const double buttonHeight = 45.0; // Button height from design
  static const double buttonWidth = 254.0; // Button width from design
  static const double borderRadius = 30.0; // Border radius from design
  static const double inputHeight = 45.0; // Input field height
  static const double screenWidth = 375.0; // Screen width from design
  static const double screenHeight = 844.0; // Screen height from design

  static const Color successGreen = Color(0xFF356F22);
}
