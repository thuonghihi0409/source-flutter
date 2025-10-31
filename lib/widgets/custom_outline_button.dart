import 'package:flutter/material.dart';
import 'package:flutter_app/core/style/index.dart';

class CustomOutlineButton extends StatelessWidget {
  // Button label
  final String text;
  // Callback when pressed
  final VoidCallback? onPressed;
  // Appearance
  final Color borderColor;
  final Color? textColor;
  final double borderRadius;
  final double borderWidth;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  // Optional icons
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  // State
  final bool isLoading;
  final bool isDisabled;
  // Size
  final double? width;
  final double? height;

  const CustomOutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.borderColor,
    this.textColor,
    this.borderRadius = 12,
    this.borderWidth = 1,
    this.padding,
    this.textStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    // Determine text color and style based on state
    final Color displayTextColor = textColor ?? borderColor;
    final TextStyle displayTextStyle =
        textStyle ??
        TextStyle(
          color: isDisabled ? AppColors.gray500 : displayTextColor,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        );

    // Button content: loading indicator or label with icons
    Widget buttonContent;
    if (isLoading) {
      buttonContent = SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: displayTextColor,
        ),
      );
    } else {
      buttonContent = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null) ...[prefixIcon!, const SizedBox(width: 8)],
          Text(text, style: displayTextStyle),
          if (suffixIcon != null) ...[const SizedBox(width: 8), suffixIcon!],
        ],
      );
    }

    // Build the button
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: (isDisabled || isLoading) ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: isDisabled
              ? null
              : BorderSide(color: borderColor, width: borderWidth),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: isDisabled
              ? AppColors.white.withOpacity(0.05)
              : null,
          padding:
              padding ??
              const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
        ),
        child: buttonContent,
      ),
    );
  }
}
