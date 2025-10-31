import 'package:flutter/material.dart';

/// Global wrapper to handle dismissing keyboard and popups when tapping outside
class GlobalDismissWrapper extends StatelessWidget {
  final Widget child;

  const GlobalDismissWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Always dismiss keyboard when tapping outside
        FocusScope.of(context).unfocus();
        // Dismiss popups
        _dismissPopupsSafely(context);
      },
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }

  void _dismissPopupsSafely(BuildContext context) {
    try {
      // Close any open bottom sheets
      if (Scaffold.of(context).isDrawerOpen) {
        Navigator.of(context).pop();
      }

      // Close any open bottom sheets
      if (Scaffold.of(context).isEndDrawerOpen) {
        Navigator.of(context).pop();
      }

      // Close any open snackbars (but not toasts)
      // Only clear snackbars, not overlay-based toasts
      ScaffoldMessenger.of(context).clearSnackBars();

      // Close any open popup menus
      // Note: PopupMenuButton automatically dismisses when tapping outside
      // but we can add additional logic here if needed
    } catch (e) {
      // Ignore errors if Scaffold is not available or context is invalid
      // This prevents crashes when dismissing popups
    }
  }
}

/// Extension to easily wrap any widget with dismiss functionality
extension DismissWrapperExtension on Widget {
  Widget withDismissWrapper() {
    return GlobalDismissWrapper(child: this);
  }
}
