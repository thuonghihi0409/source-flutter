import 'package:flutter/material.dart';
import 'package:flutter_app/core/style/app_text_styles.dart';
import 'package:flutter_app/core/style/index.dart';
import 'package:flutter_app/generated/assets.gen.dart';

class CommonDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? label;
  final String? hintText;
  final bool isRequired;
  final ValueChanged<DateTime?>? onChanged;
  final String? Function(DateTime?)? validator;
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

  const CommonDatePicker({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.label,
    this.hintText,
    this.isRequired = false,
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
  });

  @override
  State<CommonDatePicker> createState() => _CommonDatePickerState();
}

class _CommonDatePickerState extends State<CommonDatePicker> {
  late TextEditingController _controller;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _controller = TextEditingController(
      text: _selectedDate != null ? _formatDate(_selectedDate!) : '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _selectDate() async {
    if (!widget.enabled) return;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Theme.of(context).colorScheme.onPrimary,
              surface: Theme.of(context).colorScheme.surface,
              onSurface: Theme.of(context).colorScheme.onSurface,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _controller.text = _formatDate(picked);
      });
      widget.onChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          RichText(
            text: TextSpan(
              text: widget.label,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.onBackground,
              ),
              children: [
                if (widget.isRequired)
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
        TextFormField(
          controller: _controller,
          readOnly: true,
          enabled: widget.enabled,
          onTap: _selectDate,
          validator: widget.validator != null
              ? (value) {
                  // Convert string to DateTime for validation
                  if (value == null || value.isEmpty) return null;
                  try {
                    final parts = value.split('/');
                    if (parts.length == 3) {
                      final day = int.parse(parts[0]);
                      final month = int.parse(parts[1]);
                      final year = int.parse(parts[2]);
                      final date = DateTime(year, month, day);
                      return widget.validator!(date);
                    }
                  } catch (e) {
                    return 'Ngày không hợp lệ';
                  }
                  return null;
                }
              : null,
          decoration: InputDecoration(
            hintText: widget.hintText ?? 'Chọn ngày',
            prefixIcon: widget.prefixIcon,
            suffixIcon:
                widget.suffixIcon ??
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Assets.images.svg.calendar.svg(
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
            contentPadding:
                widget.contentPadding ??
                const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.md,
                ),
            border:
                widget.border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
            enabledBorder:
                widget.enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
            focusedBorder:
                widget.focusedBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
            errorBorder:
                widget.errorBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: widget.filled,
            fillColor: widget.fillColor ?? AppColors.white.withOpacity(0.05),
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
            color: widget.enabled
                ? AppColors.onBackground
                : AppColors.onBackground.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}

// Widget helper để sử dụng trong Form
class CommonDatePickerFormField extends FormField<DateTime> {
  CommonDatePickerFormField({
    super.key,
    super.initialValue,
    DateTime? firstDate,
    DateTime? lastDate,
    String? label,
    String? hintText,
    bool isRequired = false,
    ValueChanged<DateTime?>? onChanged,
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
    bool filled = true,
  }) : super(
         builder: (FormFieldState<DateTime> state) {
           return CommonDatePicker(
             initialDate: state.value,
             firstDate: firstDate,
             lastDate: lastDate,
             label: label,
             hintText: hintText,
             isRequired: isRequired,
             onChanged: (value) {
               state.didChange(value);
               onChanged?.call(value);
             },
             validator: validator != null ? (value) => validator(value) : null,
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
           );
         },
       );
}
