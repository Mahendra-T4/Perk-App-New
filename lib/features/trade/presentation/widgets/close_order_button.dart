import 'package:flutter/material.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';

class CloseOrderButton extends StatelessWidget {
  const CloseOrderButton({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // height: 30,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
        decoration: BoxDecoration(
          color: ColorTheme.bearish,
          borderRadius: BorderRadius.circular(8),
        ),
        child: CustomText(
          'CLOSE TRADE',
          style: TextStyle(color: ColorTheme.primaryText, fontSize: 12),
        ),
      ),
    );
  }
}
