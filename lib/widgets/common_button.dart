import 'package:flutter/material.dart';

import '../core/style/app_colors.dart';
import '../core/style/app_spacing.dart';
import '../core/style/app_text_styles.dart';

enum ButtonType { primary, secondary, outline, text, danger }

enum ButtonSize { small, medium, large }

class CommonButton extends StatelessWidget {
  final String text;
  final ButtonType type;
  final ButtonSize size;
  final bool isDisabled;
  final bool isLoading;
  final double? width;
  final double? height;
  final VoidCallback? onPressed;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? child;
  final ButtonStyle? style;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? textColor;
  final Color? borderColor;
  final TextStyle? textStyle;

  const CommonButton({
    super.key,
    required this.text,
    this.type = ButtonType.primary,
    this.size = ButtonSize.medium,
    this.isDisabled = false,
    this.isLoading = false,
    this.width,
    this.height,
    this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.child,
    this.style,
    this.borderRadius,
    this.padding,
    this.textColor,
    this.borderColor,
    this.textStyle,
  });

  /// Primary button constructor
  const CommonButton.primary({
    super.key,
    required this.text,
    this.size = ButtonSize.medium,
    this.isDisabled = false,
    this.isLoading = false,
    this.width,
    this.height,
    this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.child,
    this.style,
    this.borderRadius,
    this.padding,
    this.textColor,
    this.borderColor,
    this.textStyle,
  }) : type = ButtonType.primary;

  /// Secondary button constructor
  const CommonButton.secondary({
    super.key,
    required this.text,
    this.size = ButtonSize.medium,
    this.isDisabled = false,
    this.isLoading = false,
    this.width,
    this.height,
    this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.child,
    this.style,
    this.borderRadius,
    this.padding,
    this.textColor,
    this.borderColor,
    this.textStyle,
  }) : type = ButtonType.secondary;

  /// Outline button constructor
  const CommonButton.outline({
    super.key,
    required this.text,
    this.size = ButtonSize.medium,
    this.isDisabled = false,
    this.isLoading = false,
    this.width,
    this.height,
    this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.child,
    this.style,
    this.borderRadius,
    this.padding,
    this.textColor,
    this.borderColor,
    this.textStyle,
  }) : type = ButtonType.outline;

  /// Text button constructor
  const CommonButton.text({
    super.key,
    required this.text,
    this.size = ButtonSize.medium,
    this.isDisabled = false,
    this.isLoading = false,
    this.width,
    this.height,
    this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.child,
    this.style,
    this.borderRadius,
    this.padding,
    this.textColor,
    this.borderColor,
    this.textStyle,
  }) : type = ButtonType.text;

  /// Danger button constructor
  const CommonButton.danger({
    super.key,
    required this.text,
    this.size = ButtonSize.medium,
    this.isDisabled = false,
    this.isLoading = false,
    this.width,
    this.height,
    this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.child,
    this.style,
    this.borderRadius,
    this.padding,
    this.textColor,
    this.borderColor,
    this.textStyle,
  }) : type = ButtonType.danger;

  @override
  Widget build(BuildContext context) {
    final isDisabled = this.isDisabled || isLoading;
    final buttonHeight = _getButtonHeight();
    final buttonPadding = _getButtonPadding();
    final baseTextStyle = _getTextStyle();
    final effectiveTextStyle = textStyle ?? baseTextStyle;
    final colors = _getButtonColors(context);

    Widget buttonChild =
        child ?? _buildButtonContent(context, effectiveTextStyle);

    if (isLoading) {
      buttonChild = _buildLoadingContent(context, effectiveTextStyle);
    }

    return SizedBox(
      width: width,
      height: height ?? buttonHeight,
      child: _buildButton(
        context: context,
        onPressed: isDisabled ? null : onPressed,
        style: style ?? _buildButtonStyle(colors, buttonPadding),
        child: buttonChild,
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required VoidCallback? onPressed,
    required ButtonStyle style,
    required Widget child,
  }) {
    switch (type) {
      case ButtonType.primary:
      case ButtonType.secondary:
      case ButtonType.danger:
        return ElevatedButton(onPressed: onPressed, style: style, child: child);
      case ButtonType.outline:
        return OutlinedButton(onPressed: onPressed, style: style, child: child);
      case ButtonType.text:
        return TextButton(onPressed: onPressed, style: style, child: child);
    }
  }

  Widget _buildButtonContent(BuildContext context, TextStyle textStyle) {
    final children = <Widget>[];

    if (prefixIcon != null) {
      children.add(prefixIcon!);
      children.add(const SizedBox(width: AppSpacing.sm));
    }

    final effectiveTextColor =
        textColor ?? _getButtonColors(context).foreground;
    children.add(
      Text(text, style: textStyle.copyWith(color: effectiveTextColor)),
    );

    if (suffixIcon != null) {
      children.add(const SizedBox(width: AppSpacing.sm));
      children.add(suffixIcon!);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildLoadingContent(BuildContext context, TextStyle textStyle) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: _getLoadingIndicatorSize(),
          height: _getLoadingIndicatorSize(),
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              _getLoadingIndicatorColor(context),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text('Đang xử lý...', style: textStyle.copyWith(color: null)),
      ],
    );
  }

  ButtonStyle _buildButtonStyle(
    ButtonColors colors,
    EdgeInsetsGeometry padding,
  ) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.disabledBackground;
        }
        if (states.contains(WidgetState.pressed)) {
          return colors.pressedBackground;
        }
        if (states.contains(WidgetState.hovered)) {
          return colors.hoverBackground;
        }
        return colors.background;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.disabledForeground;
        }
        return colors.foreground;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        if (type == ButtonType.outline) {
          // Use custom borderColor if provided, otherwise use default from button colors
          final effectiveBorderColor = borderColor ?? colors.border;

          if (states.contains(WidgetState.disabled)) {
            return BorderSide(color: colors.disabledBorder, width: 1.0);
          }
          if (states.contains(WidgetState.pressed)) {
            return BorderSide(
              color: effectiveBorderColor.withOpacity(0.7),
              width: 1.0,
            );
          }
          if (states.contains(WidgetState.hovered)) {
            return BorderSide(
              color: effectiveBorderColor.withOpacity(0.8),
              width: 1.0,
            );
          }
          return BorderSide(color: effectiveBorderColor, width: 1.0);
        }
        return BorderSide.none;
      }),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppColors.borderRadius,
          ),
        ),
      ),
      padding: WidgetStateProperty.all(padding),
      elevation: WidgetStateProperty.resolveWith((states) {
        if (type == ButtonType.text) return 0;
        if (states.contains(WidgetState.disabled)) return 0;
        if (states.contains(WidgetState.pressed)) return 1;
        return 2;
      }),
      shadowColor: WidgetStateProperty.all(AppColors.shadowLight),
    );
  }

  double _getButtonHeight() {
    switch (size) {
      case ButtonSize.small:
        return 36.0;
      case ButtonSize.medium:
        return AppColors.buttonHeight;
      case ButtonSize.large:
        return 56.0;
    }
  }

  EdgeInsetsGeometry _getButtonPadding() {
    if (padding != null) return padding!;

    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        );
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        );
      case ButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        );
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case ButtonSize.small:
        return AppTextStyles.labelMedium;
      case ButtonSize.medium:
        return AppTextStyles.labelLarge;
      case ButtonSize.large:
        return AppTextStyles.titleMedium;
    }
  }

  double _getLoadingIndicatorSize() {
    switch (size) {
      case ButtonSize.small:
        return 12.0;
      case ButtonSize.medium:
        return 16.0;
      case ButtonSize.large:
        return 20.0;
    }
  }

  Color _getLoadingIndicatorColor(BuildContext context) {
    final colors = _getButtonColors(context);
    return colors.foreground;
  }

  ButtonColors _getButtonColors(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return ButtonColors(
          background: AppColors.primary,
          foreground: AppColors.onPrimary,
          hoverBackground: AppColors.primary.withOpacity(0.8),
          pressedBackground: AppColors.primary.withOpacity(0.9),
          disabledBackground: AppColors.white.withOpacity(0.05),
          disabledForeground: AppColors.onBackground.withOpacity(0.6),
          border: AppColors.primary,
          hoverBorder: AppColors.primary.withOpacity(0.8),
          pressedBorder: AppColors.primary.withOpacity(0.9),
          disabledBorder: AppColors.outline,
        );
      case ButtonType.secondary:
        return ButtonColors(
          background: AppColors.secondary,
          foreground: AppColors.onBackground,
          hoverBackground: AppColors.secondaryDark,
          pressedBackground: AppColors.secondaryDark,
          disabledBackground: AppColors.outline,
          disabledForeground: AppColors.onBackground.withOpacity(0.6),
          border: AppColors.secondary,
          hoverBorder: AppColors.secondaryDark,
          pressedBorder: AppColors.secondaryDark,
          disabledBorder: AppColors.outline,
        );
      case ButtonType.outline:
        final effectiveBorder = borderColor ?? AppColors.primary;
        return ButtonColors(
          background: AppColors.surface,
          foreground: AppColors.primary,
          hoverBackground: AppColors.surface.withOpacity(0.8),
          pressedBackground: AppColors.surface.withOpacity(0.9),
          disabledBackground: Colors.transparent,
          disabledForeground: AppColors.onBackground.withOpacity(0.6),
          border: effectiveBorder,
          hoverBorder: effectiveBorder,
          pressedBorder: effectiveBorder,
          disabledBorder: AppColors.outline,
        );
      case ButtonType.text:
        return ButtonColors(
          background: Colors.transparent,
          foreground: AppColors.primary,
          hoverBackground: AppColors.primary.withOpacity(0.1),
          pressedBackground: AppColors.primary.withOpacity(0.2),
          disabledBackground: Colors.transparent,
          disabledForeground: AppColors.onBackground.withOpacity(0.6),
          border: Colors.transparent,
          hoverBorder: Colors.transparent,
          pressedBorder: Colors.transparent,
          disabledBorder: Colors.transparent,
        );
      case ButtonType.danger:
        return ButtonColors(
          background: AppColors.error,
          foreground: AppColors.onBackground,
          hoverBackground: AppColors.errorDark,
          pressedBackground: AppColors.errorDark,
          disabledBackground: AppColors.outline,
          disabledForeground: AppColors.onBackground.withOpacity(0.6),
          border: AppColors.error,
          hoverBorder: AppColors.errorDark,
          pressedBorder: AppColors.errorDark,
          disabledBorder: AppColors.outline,
        );
    }
  }
}

/// Button colors configuration
class ButtonColors {
  final Color background;
  final Color foreground;
  final Color hoverBackground;
  final Color pressedBackground;
  final Color disabledBackground;
  final Color disabledForeground;
  final Color border;
  final Color hoverBorder;
  final Color pressedBorder;
  final Color disabledBorder;

  const ButtonColors({
    required this.background,
    required this.foreground,
    required this.hoverBackground,
    required this.pressedBackground,
    required this.disabledBackground,
    required this.disabledForeground,
    required this.border,
    required this.hoverBorder,
    required this.pressedBorder,
    required this.disabledBorder,
  });
}
