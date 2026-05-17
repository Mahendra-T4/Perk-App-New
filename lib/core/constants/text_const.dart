import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perk_app/core/constants/font_family.dart';
import 'package:perk_app/core/theme/color_theme.dart';

extension TextStyleX on Text {
  Text textStyleH1() {
    return Text(
      data ?? '',
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: FontFamily.globalFontFamily,
        fontSize: 13.sp,
        color: ColorTheme.primaryText,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH1P() {
    return Text(
      data ?? '',
      style: TextStyle(
        fontWeight: FontWeight.w800,
        fontFamily: FontFamily.globalFontFamily,
        fontSize: 15,
        color: ColorTheme.surface,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH11() {
    return Text(
      data ?? '',
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontFamily: FontFamily.globalFontFamily,
        fontSize: 18,
        color: ColorTheme.primaryText,
        letterSpacing: 2,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH11Color() {
    return Text(
      data ?? '',
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontFamily: FontFamily.globalFontFamily,
        fontSize: 18,
        color: ColorTheme.surface,
        letterSpacing: 2,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH1Custom(Color? color) {
    return Text(
      data ?? '',
      style: TextStyle(
        fontWeight: FontWeight.w800,
        fontFamily: FontFamily.globalFontFamily,
        fontSize: 15,
        color: color ?? ColorTheme.primaryText,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH1C(Color color) {
    return Text(
      data ?? '',
      style: TextStyle(
        color: color,
        fontSize: 16,
        fontFamily: FontFamily.globalFontFamily,
        // fontFamily: 'JetBrainsMono',
        fontWeight: FontWeight.bold,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH1CPL() {
    return Text(
      data ?? '',
      style: TextStyle(
        fontFamily: FontFamily.globalFontFamily,
        color: data!.contains('-') ? Colors.red : Colors.green,
        fontSize: 16,
        // fontFamily: 'JetBrainsMono',
        fontWeight: FontWeight.bold,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH4() {
    return Text(
      data ?? '',
      style: const TextStyle(
        fontWeight: FontWeight.w800,
        fontFamily: FontFamily.globalFontFamily,
        fontSize: 16.5,
        color: ColorTheme.surface,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH1W() {
    return Text(
      data ?? '',
      style: const TextStyle(
        fontWeight: FontWeight.w800,
        fontFamily: FontFamily.globalFontFamily,
        fontSize: 16,
        color: Colors.white,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH2() {
    return Text(
      data ?? '',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: ColorTheme.secondaryText,
        fontFamily: FontFamily.globalFontFamily,
        fontSize: 12,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH2b() {
    return Text(
      data ?? '',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: ColorTheme.surface,
        fontFamily: FontFamily.globalFontFamily,
        fontSize: 12,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH2C(Color color) {
    return Text(
      data ?? '',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        color: color,
        fontFamily: FontFamily.globalFontFamily,
        fontSize: 12,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH2G() {
    return Text(
      data ?? '',
      style: TextStyle(
        fontWeight: FontWeight.w700,

        fontFamily: FontFamily.globalFontFamily,
        color: ColorTheme.primaryText,
        fontSize: 12,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH2W() {
    return Text(
      data ?? '',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: FontFamily.globalFontFamily,
        color: ColorTheme.primaryText,
        fontSize: 13,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH2R() {
    return Text(
      data ?? '',
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: FontFamily.globalFontFamily,
        color: Colors.redAccent,
        fontSize: 12,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH2S() {
    return Text(
      data ?? '',
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: FontFamily.globalFontFamily,
        color: ColorTheme.surface,
        fontSize: 13,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH3() {
    return Text(
      data ?? '',
      style: TextStyle(
        color: ColorTheme.primaryText,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.globalFontFamily,
        fontSize: 13,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH3R() {
    return Text(
      data ?? '',
      style: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.globalFontFamily,
        fontSize: 11.5,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH5() {
    return Text(
      data ?? '',
      style: TextStyle(
        color: Colors.grey[700],
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.globalFontFamily,
        fontSize: 13,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleH() {
    return Text(
      data ?? '',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: FontFamily.globalFontFamily,
        // fontFamily: 'JetBrainsMono',
        color: ColorTheme.primaryText,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleHB() {
    return Text(
      data ?? '',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 19,
        fontFamily: FontFamily.globalFontFamily,
        color: Colors.black,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }

  Text textStyleHT() {
    return Text(
      data ?? '',
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: FontFamily.globalFontFamily,
        fontSize: 21,
        color: Colors.white,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }
}

// Usage:
// Text('Your text').textStyle()
