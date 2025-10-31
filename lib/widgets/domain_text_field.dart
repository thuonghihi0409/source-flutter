import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/core/style/index.dart';

class DomainTextField extends StatefulWidget {
  final String? hintText;
  final bool isRequired;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final bool enabled;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

  const DomainTextField({
    super.key,
    this.hintText,
    this.isRequired = false,
    this.controller,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.textInputAction,
    this.focusNode,
  });

  @override
  State<DomainTextField> createState() => _DomainTextFieldState();
}

class _DomainTextFieldState extends State<DomainTextField> {
  late TextEditingController _controller;
  String _displayText = '_____.hexerp.com';
  static const String _suffix = '.hexerp.com';

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _updateDisplayText();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _updateDisplayText();
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_onTextChanged);
    }
    super.dispose();
  }

  void _updateDisplayText() {
    final inputText = _controller.text;
    final displayText = _buildDisplayText(inputText);

    if (_displayText != displayText) {
      setState(() {
        _displayText = displayText;
      });
    }
  }

  String _buildDisplayText(String inputText) {
    const placeholder = '_____';
    const maxPlaceholderLength = placeholder.length;

    if (inputText.isEmpty) {
      return '$placeholder$_suffix';
    }

    // Replace underscores with input text, but keep remaining underscores
    String result = placeholder;
    for (int i = 0; i < inputText.length && i < maxPlaceholderLength; i++) {
      result = result.replaceFirst('_', inputText[i]);
    }

    return '$result$_suffix';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        TextFormField(
          controller: _controller,
          onChanged: (value) {
            widget.onChanged?.call(value);
          },
          validator: widget.validator,
          enabled: widget.enabled,
          textInputAction: widget.textInputAction,
          focusNode: widget.focusNode,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_-]')),
            LengthLimitingTextInputFormatter(5), // Limit to 5 characters max
          ],
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.border, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.black, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.error, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
            filled: true,
            fillColor: widget.enabled
                ? const Color(0xFFFFFFFF)
                : const Color(0xFFF9F9F9),
            errorStyle: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
          style: const TextStyle(
            color: Colors.transparent, // Hide the actual input text
          ),
        ),
        Positioned.fill(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  children: _buildTextSpans(),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: widget.enabled ? AppColors.black : AppColors.gray500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<TextSpan> _buildTextSpans() {
    final inputText = _controller.text;
    const placeholder = '_____';
    const suffix = '.hexerp.com';

    List<TextSpan> spans = [];

    if (inputText.isEmpty) {
      // Show placeholder with gray underscores
      spans.add(
        const TextSpan(
          text: placeholder,
          style: TextStyle(color: AppColors.gray400),
        ),
      );
    } else {
      // Show input text with normal color
      spans.add(
        TextSpan(
          text: inputText,
          style: const TextStyle(color: AppColors.black),
        ),
      );
    }

    // Add suffix with normal color
    spans.add(
      const TextSpan(
        text: suffix,
        style: TextStyle(color: AppColors.black),
      ),
    );

    return spans;
  }
}
