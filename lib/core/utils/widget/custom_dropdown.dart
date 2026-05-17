import 'package:flutter/material.dart';

/// A dropdown form field that mimics the visual style of
/// [CustomTextFormField] used across the application. It wraps
/// [DropdownButtonFormField] in an animated container with rounded
/// corners, shadows and focus handling.
///
/// The widget is generic so it can be used with any value type.
class CustomDropdown<T> extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? Function(T?)? validator;
  final bool enabled;
  final Color? fillColor;
  final InputBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? errorStyle;

  const CustomDropdown({
    Key? key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.fillColor,
    this.border,
    this.contentPadding,
    this.style,
    this.hintStyle,
    this.labelStyle,
    this.errorStyle,
  }) : super(key: key);

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final defaultFillColor = isDark
        ? Colors.grey.shade900.withOpacity(0.8)
        : Colors.white.withOpacity(0.9);
    final defaultBorderColor = isDark
        ? Colors.grey.shade700
        : Colors.grey.shade300;
    final defaultFocusColor = theme.primaryColor;
    final defaultErrorColor = theme.colorScheme.error;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _focusNode.hasFocus
                ? defaultFocusColor.withOpacity(0.2)
                : Colors.black.withOpacity(0.05),
            blurRadius: _focusNode.hasFocus ? 12 : 8,
            offset: const Offset(0, 4),
            spreadRadius: _focusNode.hasFocus ? 2 : 0,
          ),
        ],
        gradient: widget.fillColor != null
            ? null
            : LinearGradient(
                colors: [defaultFillColor, defaultFillColor.withOpacity(0.8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
      ),
      child: Focus(
        focusNode: _focusNode,
        child: DropdownButtonFormField<T>(
          value: widget.value,
          items: widget.items,
          onChanged: widget.enabled ? widget.onChanged : null,
          validator: widget.validator,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: widget.prefixIcon,
                  )
                : null,
            suffixIcon: widget.suffixIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: widget.suffixIcon,
                  )
                : null,
            border:
                widget.border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: defaultBorderColor, width: 1.5),
                ),
            enabledBorder:
                widget.border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: defaultBorderColor, width: 1.5),
                ),
            focusedBorder:
                widget.border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: defaultFocusColor, width: 2),
                ),
            errorBorder:
                widget.border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: defaultErrorColor, width: 1.5),
                ),
            focusedErrorBorder:
                widget.border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: defaultErrorColor, width: 2),
                ),
            filled: widget.fillColor != null || true,
            fillColor: widget.fillColor ?? Colors.transparent,
            contentPadding:
                widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            labelStyle:
                widget.labelStyle ??
                TextStyle(
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
            hintStyle:
                widget.hintStyle ??
                TextStyle(
                  color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                  fontSize: 16,
                ),
            errorStyle:
                widget.errorStyle ??
                TextStyle(
                  color: defaultErrorColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
          ),
          style:
              widget.style ??
              TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
          dropdownColor: theme.cardColor,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
        ),
      ),
    );
  }
}
