import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/core/style/app_text_styles.dart';
import 'package:flutter_app/core/style/index.dart';

class CommonTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? helperText;
  final bool isRequired;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final Color? fillColor;
  final bool filled;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;

  const CommonTextField({
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.isRequired = false,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.fillColor,
    this.filled = true,
    this.textInputAction,
    this.focusNode,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          RichText(
            text: TextSpan(
              text: label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.onBackground,
              ),
              children: [
                if (isRequired)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          validator: validator,
          enabled: enabled,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          maxLength: maxLength,
          textInputAction: textInputAction,
          focusNode: focusNode,
          inputFormatters: inputFormatters,

          decoration: InputDecoration(
            hintText: hintText,
            helperText: helperText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding:
                contentPadding ??
                const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.md,
                ),
            border:
                border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
            enabledBorder:
                enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
            focusedBorder:
                focusedBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
            errorBorder:
                errorBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
            focusedErrorBorder:
                focusedErrorBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
            filled: filled,
            fillColor: fillColor ?? AppColors.white.withOpacity(0.05),
            errorStyle: AppTextStyles.bodySmall.copyWith(
              color: AppColors.error,
            ),
            helperStyle: AppTextStyles.bodySmall.copyWith(
              color: AppColors.onBackground.withOpacity(0.6),
            ),
            hintStyle: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.gray500,
            ),
          ),
          style: AppTextStyles.bodyLarge.copyWith(
            color: enabled
                ? AppColors.onBackground
                : AppColors.onBackground.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
