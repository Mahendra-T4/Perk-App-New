import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perk_app/core/theme/color_theme.dart';

class ToastService {
  static customToast(Color? backgroundColor, {required String msg}) =>
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: ColorTheme.primaryText,
        fontSize: 15.0,
      );
}
