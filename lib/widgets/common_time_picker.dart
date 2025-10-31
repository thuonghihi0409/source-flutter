import 'package:flutter/material.dart';
import 'package:flutter_app/core/style/index.dart';
import 'package:flutter_app/generated/assets.gen.dart';

class CommonTimePicker extends StatefulWidget {
  final TimeOfDay? initialTime;
  final String? label;
  final String? hintText;
  final bool isRequired;
  final ValueChanged<TimeOfDay?>? onChanged;
  final String? Function(TimeOfDay?)? validator;
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

  const CommonTimePicker({
    super.key,
    this.initialTime,
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
    this.filled = false,
  });

  @override
  State<CommonTimePicker> createState() => _CommonTimePickerState();
}

class _CommonTimePickerState extends State<CommonTimePicker> {
  late TextEditingController _controller;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _selectedTime = widget.initialTime;
    _updateController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateController() {
    if (_selectedTime != null) {
      _controller.text =
          '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}';
    } else {
      _controller.text = '';
    }
  }

  Future<void> _selectTime() async {
    if (!widget.enabled) return;

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _updateController();
      });
      widget.onChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Row(
            children: [
              Text(
                widget.label!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              if (widget.isRequired)
                Text(
                  ' *',
                  style: TextStyle(
                    color: theme.colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        InkWell(
          onTap: widget.enabled ? _selectTime : null,
          child: Container(
            padding:
                widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.enabled
                    ? (widget.enabledBorder?.borderSide.color ??
                          AppColors.black)
                    : AppColors.black.withOpacity(0.3),
                width: widget.enabled ? 1.0 : 1.0,
              ),
              borderRadius: BorderRadius.circular(10),
              color:
                  widget.fillColor ??
                  (widget.filled
                      ? theme.colorScheme.surface
                      : Colors.transparent),
            ),
            child: Row(
              children: [
                (widget.prefixIcon != null)
                    ? widget.prefixIcon!
                    : Assets.images.svg.clock.svg(
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          AppColors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                const SizedBox(width: AppSpacing.baseUnit),

                Expanded(
                  child: Text(
                    _controller.text.isEmpty
                        ? (widget.hintText ?? 'Chọn giờ')
                        : _controller.text,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: _controller.text.isEmpty
                          ? AppColors.gray500
                          : AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
