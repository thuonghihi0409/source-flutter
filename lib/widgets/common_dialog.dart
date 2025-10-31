import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/style/app_colors.dart';
import '../core/style/app_text_styles.dart';

enum DialogType { info, warning, error, success, confirmation }

class CommonDialog {
  /// Show a confirmation dialog with Yes/No buttons
  static Future<bool?> showConfirmation({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Xác nhận',
    String cancelText = 'Hủy',
    DialogType type = DialogType.warning,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => _CommonDialogWidget(
        title: title,
        message: message,
        type: type,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: () {
          onConfirm?.call();
          Navigator.of(context).pop(true);
        },
        onCancel: () {
          onCancel?.call();
          Navigator.of(context).pop(false);
        },
      ),
    );
  }

  /// Show an alert dialog with OK button only
  static Future<void> showAlert({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    DialogType type = DialogType.info,
    VoidCallback? onPressed,
  }) {
    return showDialog(
      context: context,
      builder: (context) => _CommonDialogWidget(
        title: title,
        message: message,
        type: type,
        confirmText: buttonText,
        onConfirm: () {
          onPressed?.call();
          Navigator.of(context).pop();
        },
        showCancelButton: false,
      ),
    );
  }

  /// Show a success dialog
  static Future<void> showSuccess({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
  }) {
    return showAlert(
      context: context,
      title: title,
      message: message,
      buttonText: buttonText,
      type: DialogType.success,
      onPressed: onPressed,
    );
  }

  /// Show an error dialog
  static Future<void> showError({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
  }) {
    return showAlert(
      context: context,
      title: title,
      message: message,
      buttonText: buttonText,
      type: DialogType.error,
      onPressed: onPressed,
    );
  }

  /// Show a custom dialog with custom content and actions
  static Future<T?> showCustom<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    List<Widget>? actions,
    DialogType type = DialogType.info,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => _CommonDialogWidget(
        title: title,
        type: type,
        customContent: content,
        customActions: actions,
      ),
    );
  }
}

class _CommonDialogWidget extends StatelessWidget {
  final String title;
  final String? message;
  final DialogType type;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool showCancelButton;
  final Widget? customContent;
  final List<Widget>? customActions;

  const _CommonDialogWidget({
    required this.title,
    this.message,
    required this.type,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.showCancelButton = true,
    this.customContent,
    this.customActions,
  });

  Color _getTypeColor() {
    switch (type) {
      case DialogType.info:
        return AppColors.primary;
      case DialogType.warning:
        return Colors.orange;
      case DialogType.error:
        return AppColors.error;
      case DialogType.success:
        return Colors.green;
      case DialogType.confirmation:
        return AppColors.primary;
    }
  }

  IconData _getTypeIcon() {
    switch (type) {
      case DialogType.info:
        return Icons.info_outline;
      case DialogType.warning:
        return Icons.warning_amber_outlined;
      case DialogType.error:
        return Icons.error_outline;
      case DialogType.success:
        return Icons.check_circle_outline;
      case DialogType.confirmation:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Row(
        children: [
          Icon(_getTypeIcon(), color: _getTypeColor(), size: 28.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.onBackground,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content:
          customContent ??
          (message != null
              ? Text(
                  message!,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onBackground.withOpacity(0.7),
                  ),
                )
              : null),
      actions:
          customActions ??
          [
            if (showCancelButton)
              TextButton(
                onPressed: onCancel,
                child: Text(
                  cancelText ?? 'Hủy',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.gray600,
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: _getTypeColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
              child: Text(
                confirmText ?? 'OK',
                style: AppTextStyles.labelLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
    );
  }
}
