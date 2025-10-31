import 'package:flutter/material.dart';

/// Utility class for keyboard and popup management
class KeyboardUtils {
  /// Dismiss keyboard by unfocusing the current focus node
  static void dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Dismiss keyboard and close all popups
  static void dismissAll(BuildContext context) {
    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    // Close any open bottom sheets
    if (Scaffold.of(context).isDrawerOpen) {
      Navigator.of(context).pop();
    }

    if (Scaffold.of(context).isEndDrawerOpen) {
      Navigator.of(context).pop();
    }

    // Close any open snackbars
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  /// Check if keyboard is currently visible
  static bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  /// Get keyboard height
  static double getKeyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  /// Hide keyboard and show a snackbar
  static void hideKeyboardAndShowSnackBar(
    BuildContext context,
    String message, {
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 2),
  }) {
    dismissKeyboard(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }
}

/// Extension for easy keyboard dismissal
extension KeyboardDismissExtension on BuildContext {
  /// Dismiss keyboard
  void dismissKeyboard() {
    KeyboardUtils.dismissKeyboard(this);
  }

  /// Dismiss keyboard and all popups
  void dismissAll() {
    KeyboardUtils.dismissAll(this);
  }

  /// Check if keyboard is visible
  bool get isKeyboardVisible => KeyboardUtils.isKeyboardVisible(this);

  /// Get keyboard height
  double get keyboardHeight => KeyboardUtils.getKeyboardHeight(this);
}
