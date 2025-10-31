import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/core/style/app_colors.dart';
import 'package:flutter_app/core/style/app_text_styles.dart';

class CompactTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final double height;
  final Color? fillColor;
  final bool useUnderline;
  final Color? underlineColor;
  final ValueChanged<bool>? onValidationStateChanged;

  const CompactTextField({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.height = 50,
    this.fillColor,
    this.useUnderline = false, // Mặc định là false
    this.underlineColor, // Mặc định null
    this.onValidationStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    final border = useUnderline
        ? UnderlineInputBorder(
            borderSide: BorderSide(
              color: underlineColor ?? AppColors.gray700,
              width: 1,
            ),
          )
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          );

    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          onChanged?.call(value);
          if (onValidationStateChanged != null && validator != null) {
            final isValid = validator!(value) == null;
            onValidationStateChanged!(isValid);
          }
        },
        onFieldSubmitted: onSubmitted,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        enabled: enabled,
        obscureText: obscureText,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: useUnderline
              ? const EdgeInsets.symmetric(vertical: 8) // Sát hơn
              : const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          filled: true,
          fillColor: fillColor ?? AppColors.white.withOpacity(0.05),
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.gray500,
          ),
        ),
        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onBackground),
      ),
    );
  }
}
