import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui' show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/services.dart';
import 'package:perk_app/core/theme/color_theme.dart';

class CustomTextFormField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool enabled;
  final InputBorder? border;
  final Color? fillColor;
  final String? initialValue;
  final String? errorText;
  final String? helperText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final List<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final TextDirection? textDirection;
  final TextEditingController? controller;
  final bool readOnly;
  final bool expands;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextStyle? helperStyle;
  final Color? cursorColor;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final bool? showCursor;
  final Brightness? keyboardAppearance;
  final bool enableSuggestions;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableIMEPersonalizedLearning;
  final MouseCursor? mouseCursor;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final Clip? clipBehavior;
  final String? restorationId;
  final bool stylusHandwritingEnabled;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final Widget? counter;
  final TextStyle? counterStyle;
  final InputCounterWidgetBuilder? buildCounter;
  final bool? canRequestFocus;
  final double? cursorWidth;
  final bool? cursorOpacityAnimates;
  final BoxHeightStyle selectionHeightStyle;
  final BoxWidthStyle selectionWidthStyle;
  final DragStartBehavior dragStartBehavior;
  final TapRegionCallback? onTapOutside;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.enabled = true,
    this.border,
    this.fillColor,
    this.initialValue,
    this.errorText,
    this.helperText,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
    this.textDirection,
    this.controller,
    this.readOnly = false,
    this.expands = false,
    this.contentPadding,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.helperStyle,
    this.cursorColor,
    this.cursorHeight,
    this.cursorRadius,
    this.showCursor,
    this.keyboardAppearance,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableIMEPersonalizedLearning = true,
    this.mouseCursor,
    this.scrollController,
    this.scrollPhysics,
    this.clipBehavior,
    this.restorationId,
    this.stylusHandwritingEnabled = true,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.counter,
    this.counterStyle,
    this.buildCounter,
    this.canRequestFocus,
    this.cursorWidth,
    this.cursorOpacityAnimates,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.dragStartBehavior = DragStartBehavior.start,
    this.onTapOutside,
    this.magnifierConfiguration,
    this.inputFormatters,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(CustomTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller == null) {
        _controller.dispose();
      }
      _controller =
          widget.controller ?? TextEditingController(text: widget.initialValue);
    }
    if (widget.focusNode != oldWidget.focusNode) {
      if (oldWidget.focusNode == null) {
        _focusNode.dispose();
      }
      _focusNode = widget.focusNode ?? FocusNode();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Modern default colors
    final defaultFillColor = isDark
        ? ColorTheme.secondarySurface
        : ColorTheme.secondarySurface.withValues(alpha: 0.9);
    final defaultBorderColor = isDark
        ? Colors.grey.shade700
        : Colors.grey.shade300;
    final defaultFocusColor = ColorTheme.primaryColor;
    final defaultErrorColor = ColorTheme.bearish;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _focusNode.hasFocus
                ? defaultFocusColor.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: _focusNode.hasFocus ? 12 : 8,
            offset: const Offset(0, 4),
            spreadRadius: _focusNode.hasFocus ? 2 : 0,
          ),
        ],
        gradient: widget.fillColor != null
            ? null
            : LinearGradient(
                colors: [
                  defaultFillColor,
                  defaultFillColor.withValues(alpha: 0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
      ),
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        inputFormatters: widget.inputFormatters,
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
          errorText: widget.errorText,
          helperText: widget.helperText,
          contentPadding:
              widget.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          labelStyle:
              widget.labelStyle ??
              TextStyle(
                color: ColorTheme.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
          hintStyle:
              widget.hintStyle ??
              TextStyle(color: ColorTheme.secondaryText, fontSize: 16),
          errorStyle:
              widget.errorStyle ??
              TextStyle(
                color: defaultErrorColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
          helperStyle:
              widget.helperStyle ??
              TextStyle(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                fontSize: 12,
              ),
          counter: widget.counter,
          counterStyle:
              widget.counterStyle ??
              TextStyle(
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                fontSize: 12,
              ),
          counterText: widget.buildCounter != null ? null : '',
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          alignLabelWithHint: true,
        ),
        validator: widget.validator,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        enabled: widget.enabled,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        onTap: widget.onTap,
        textInputAction: widget.textInputAction,
        autofillHints: widget.autofillHints,
        textCapitalization: widget.textCapitalization,
        textDirection: widget.textDirection,
        readOnly: widget.readOnly,
        expands: widget.expands,
        style:
            widget.style ??
            TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
        cursorColor: widget.cursorColor ?? defaultFocusColor,
        cursorHeight: widget.cursorHeight,
        cursorRadius: widget.cursorRadius ?? const Radius.circular(2),
        showCursor: widget.showCursor,
        keyboardAppearance: widget.keyboardAppearance,
        enableSuggestions: widget.enableSuggestions,
        autocorrect: widget.autocorrect,
        smartDashesType: widget.smartDashesType,
        smartQuotesType: widget.smartQuotesType,
        enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
        mouseCursor: widget.mouseCursor,
        scrollController: widget.scrollController,
        scrollPhysics: widget.scrollPhysics,
        clipBehavior: widget.clipBehavior ?? Clip.hardEdge,
        restorationId: widget.restorationId,
        stylusHandwritingEnabled: widget.stylusHandwritingEnabled,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        selectionControls: widget.selectionControls,
        buildCounter: widget.buildCounter,
        canRequestFocus: widget.canRequestFocus ?? true,
        cursorWidth: widget.cursorWidth ?? 2.0,
        cursorOpacityAnimates: widget.cursorOpacityAnimates ?? true,
        selectionHeightStyle: widget.selectionHeightStyle,
        selectionWidthStyle: widget.selectionWidthStyle,
        dragStartBehavior: widget.dragStartBehavior,
        onTapOutside: widget.onTapOutside,
        magnifierConfiguration: widget.magnifierConfiguration,
      ),
    );
  }
}
