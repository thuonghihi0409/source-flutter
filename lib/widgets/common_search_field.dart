import 'package:flutter/material.dart';
import 'package:flutter_app/core/style/index.dart';
import 'package:flutter_app/l10n/app_localizations.dart';

class CommonSearchField extends StatelessWidget {
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final double? height;
  final bool enabled;

  const CommonSearchField({
    super.key,
    this.hintText,
    this.onChanged,
    this.controller,
    this.contentPadding,
    this.height = 45,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        controller: controller,
        enabled: enabled,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText ?? AppLocalizations.of(context)!.searchHint,
          hintStyle: const TextStyle(color: AppColors.gray400, fontSize: 14),
          border: InputBorder.none,
          filled: true,
          fillColor: AppColors.gray300,
          contentPadding:
              contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.black,
            size: 20,
          ),
        ),
      ),
    );
  }
}
