import 'package:flutter/material.dart';
import 'package:perk_app/core/constants/text_const.dart';
import 'package:perk_app/core/theme/color_theme.dart';

class CloseAllTradeButton extends StatelessWidget {
  const CloseAllTradeButton({super.key, this.onTap, required this.category});
  final void Function()? onTap;
  final String category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        alignment: Alignment.center,
        // margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: ColorTheme.bearish,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'Close All $category Orders',
          style: TextStyle(color: ColorTheme.primaryText),
        ).textStyleH2W(),
      ),
    );
  }
}
