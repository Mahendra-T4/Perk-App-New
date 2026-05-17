import 'package:flutter/material.dart';
import 'package:perk_app/core/theme/color_theme.dart';

class HeaderSearchBar extends StatefulWidget {
  final String hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
  final bool isReadOnly;
  final void Function()? onTap;

  const HeaderSearchBar({
    super.key,
    this.hintText = 'Search symbols...',
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.isReadOnly = false,
    this.onTap,
  });

  @override
  State<HeaderSearchBar> createState() => _HeaderSearchBarState();
}

class _HeaderSearchBarState extends State<HeaderSearchBar>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;
  late AnimationController _animationController;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _animationController.forward();
        setState(() => _isFocused = true);
      } else {
        _animationController.reverse();
        setState(() => _isFocused = false);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        // boxShadow: [
        //   BoxShadow(
        //     color: _isFocused
        //         ? ColorTheme.primaryColor.withOpacity(0.2)
        //         : Colors.transparent,
        //     blurRadius: _isFocused ? 20 : 8,
        //     offset: Offset(0, _isFocused ? 8 : 4),
        //     spreadRadius: _isFocused ? 2 : 0,
        //   ),
        // ],
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        readOnly: widget.isReadOnly,
        onTap: widget.onTap,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: ColorTheme.secondaryText.withOpacity(0.6),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: AnimatedScale(
            scale: _isFocused ? 1.1 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: Icon(
              Icons.search,
              color: _isFocused
                  ? ColorTheme.primaryColor
                  : ColorTheme.secondaryText,
              size: 22,
            ),
          ),
          suffixIcon: _isFocused
              ? GestureDetector(
                  onTap: () {
                    widget.controller?.clear();
                    widget.onChanged?.call('');
                  },
                  child: Icon(
                    Icons.close_rounded,
                    color: ColorTheme.primaryColor,
                    size: 20,
                  ),
                )
              : null,
          filled: true,
          fillColor: ColorTheme.surface,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: ColorTheme.primaryColor.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: ColorTheme.primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Colors.red.withOpacity(0.5),
              width: 1.5,
            ),
          ),
        ),
        style: TextStyle(
          color: ColorTheme.primaryText,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: ColorTheme.primaryColor,
        cursorWidth: 2,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
