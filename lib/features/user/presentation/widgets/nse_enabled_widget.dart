import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';

class NSEEnabled extends StatelessWidget {
  const NSEEnabled({
    super.key,
    this.brokerage,
    this.marginIntraday,
    this.marginHolding,
  });
  final dynamic brokerage;
  final dynamic marginIntraday;
  final dynamic marginHolding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorTheme.secondarySurface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: ColorTheme.primaryColor.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'NSE Trade Enabled',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: ColorTheme.primaryText,
            ),
          ),
          CustomText(
            'Brokerage:',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: ColorTheme.primaryColor,
            ),
          ),
          CustomText(
            brokerage.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: ColorTheme.primaryText,
            ),
          ),
          Divider(color: ColorTheme.primaryColor.withOpacity(0.5), height: 20),

          CustomText(
            'Margin Intraday:',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: ColorTheme.primaryColor,
            ),
          ),
          CustomText(
            marginIntraday.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: ColorTheme.primaryText,
            ),
          ),
          Divider(color: ColorTheme.primaryColor.withOpacity(0.5), height: 20),

          CustomText(
            'Margin Holding:',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: ColorTheme.primaryColor,
            ),
          ),
          CustomText(
            marginHolding.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: ColorTheme.primaryText,
            ),
          ),
        ],
      ),
    );
  }
}
