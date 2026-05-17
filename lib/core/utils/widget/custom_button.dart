import 'package:flutter/material.dart';
import 'package:perk_app/core/constants/font_family.dart';
import 'package:perk_app/core/theme/color_theme.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double borderRadius;
  final double height;
  final double? width;
  final Gradient? gradient;
  final Color? textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Widget? icon;
  final bool isLoading;

  const CustomButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.borderRadius = 16.0,
    this.height = 48.0,
    this.width,
    this.gradient,
    this.textColor,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w600,
    this.icon,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Gradient defaultGradient =
    //     gradient ??
    //     LinearGradient(
    //       colors: [
    //         ColorTheme.primaryColor,
    //         ColorTheme.primaryColor.withOpacity(0.8),
    //       ],
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //     );

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: onPressed == null ? 0.6 : 1.0,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onPressed,
          child: Ink(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: ColorTheme.primaryColor,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[icon!, const SizedBox(width: 8)],
                  Text(
                    label,
                    style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      letterSpacing: 0.5,
                      fontFamily: FontFamily.globalFontFamily,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
