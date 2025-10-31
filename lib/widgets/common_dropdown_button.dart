import 'package:flutter/material.dart';
import 'package:flutter_app/core/style/app_text_styles.dart';
import 'package:flutter_app/core/style/index.dart';

class CommonDropdownButton<T> extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool isRequired;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? Function(T?)? validator;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final Color? fillColor;
  final bool filled;
  final bool isExpanded;
  final double? menuMaxHeight;
  final DropdownButtonBuilder? selectedItemBuilder;

  const CommonDropdownButton({
    super.key,
    this.label,
    this.hintText,
    this.isRequired = false,
    this.value,
    required this.items,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.fillColor,
    this.filled = true,
    this.isExpanded = true,
    this.menuMaxHeight,
    this.selectedItemBuilder,
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
              style: AppTextStyles.bodyLarge.copyWith(
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
          const SizedBox(height: 8),
        ],
        Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
            textTheme: Theme.of(context).textTheme.copyWith(
              bodyLarge: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.onBackground,
              ),
            ),
          ),
          child: DropdownButtonFormField<T>(
            initialValue: value,
            items: () {
              // Deduplicate by value to avoid duplicate options causing assertion failures
              final seen = <Object?>{};
              final dedup = <DropdownMenuItem<T>>[];
              for (final item in items) {
                final key = item.value as Object?;
                if (seen.add(key)) {
                  dedup.add(
                    DropdownMenuItem<T>(
                      value: item.value,
                      child: Text(
                        item.child
                            .toString()
                            .replaceAll('Text("', '')
                            .replaceAll('")', ''),
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.onBackground,
                        ),
                      ),
                    ),
                  );
                }
              }
              return dedup;
            }(),
            onChanged: enabled ? onChanged : null,
            validator: validator,
            icon:
                suffixIcon ??
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.onBackground,
                ),
            dropdownColor: AppColors.backgroundDark,

            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon,
              contentPadding:
                  contentPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.md,
                  ),
              border:
                  border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
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
              focusedErrorBorder: OutlineInputBorder(
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
            isExpanded: isExpanded,
            menuMaxHeight: menuMaxHeight,
            selectedItemBuilder: selectedItemBuilder,
          ),
        ),
      ],
    );
  }
}

// Helper class for creating dropdown items
class DropdownItem<T> {
  final T value;
  final String text;
  final Widget? icon;
  final bool enabled;

  const DropdownItem({
    required this.value,
    required this.text,
    this.icon,
    this.enabled = true,
  });

  DropdownMenuItem<T> toDropdownMenuItem() {
    return DropdownMenuItem<T>(
      value: value,
      enabled: enabled,
      child: Row(
        children: [
          if (icon != null) ...[icon!, const SizedBox(width: 8)],
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

// Predefined dropdown for common use cases
class CommonDropdownButtonFormField<T> extends FormField<T> {
  CommonDropdownButtonFormField({
    super.key,
    super.initialValue,
    String? label,
    String? hintText,
    bool isRequired = false,
    required List<DropdownMenuItem<T>> items,
    ValueChanged<T?>? onChanged,
    super.validator,
    bool enabled = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
    EdgeInsetsGeometry? contentPadding,
    InputBorder? border,
    InputBorder? enabledBorder,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    Color? fillColor,
    bool filled = false,
    bool isExpanded = true,
    double? menuMaxHeight,
    DropdownButtonBuilder? selectedItemBuilder,
  }) : super(
         builder: (FormFieldState<T> state) {
           return CommonDropdownButton<T>(
             label: label,
             hintText: hintText,
             isRequired: isRequired,
             value: state.value,
             items: items,
             onChanged: (value) {
               state.didChange(value);
               onChanged?.call(value);
             },
             validator: validator,
             enabled: enabled,
             prefixIcon: prefixIcon,
             suffixIcon: suffixIcon,
             contentPadding: contentPadding,
             border: border,
             enabledBorder: enabledBorder,
             focusedBorder: focusedBorder,
             errorBorder: errorBorder,
             fillColor: fillColor,
             filled: filled,
             isExpanded: isExpanded,
             menuMaxHeight: menuMaxHeight,
             selectedItemBuilder: selectedItemBuilder,
           );
         },
       );
}

// Specialized dropdown for string values
class CommonStringDropdownButton extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool isRequired;
  final String? value;
  final List<String> options;
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final Color? fillColor;
  final bool filled;
  final bool isExpanded;
  final double? menuMaxHeight;

  const CommonStringDropdownButton({
    super.key,
    this.label,
    this.hintText,
    this.isRequired = false,
    this.value,
    required this.options,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.fillColor,
    this.filled = true,
    this.isExpanded = true,
    this.menuMaxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return CommonDropdownButton<String>(
      label: label,
      hintText: hintText,
      isRequired: isRequired,
      value: value,
      items: options.toSet().map((option) {
        return DropdownMenuItem<String>(value: option, child: Text(option));
      }).toList(),
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: contentPadding,
      border: border,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      fillColor: fillColor,
      filled: filled,
      isExpanded: isExpanded,
      menuMaxHeight: menuMaxHeight,
    );
  }
}
