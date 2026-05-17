import 'package:flutter/material.dart';
import 'package:perk_app/core/constants/font_family.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;

  final List<Shadow>? shadows;
  final bool selectable;

  const CustomText(
    this.text, {
    Key? key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.letterSpacing,
    this.wordSpacing,
    this.height,

    this.shadows,
    this.selectable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = (style ?? const TextStyle()).copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      fontFamily: FontFamily.globalFontFamily,
      shadows: shadows,
    );

    if (selectable) {
      return SelectableText(
        text,
        style: effectiveStyle,
        textAlign: textAlign,
        maxLines: maxLines,
      );
    }
    return Text(
      text,
      style: effectiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
