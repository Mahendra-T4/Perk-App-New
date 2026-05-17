import 'package:flutter/material.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';

class SymbolBuySellButton extends StatelessWidget {
  const SymbolBuySellButton({
    super.key,
    this.sellAmount,
    this.buyAmount,
    this.onSellTap,
    this.onBuyTap,
  });
  final dynamic sellAmount;
  final dynamic buyAmount;
  final void Function()? onSellTap;
  final void Function()? onBuyTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Expanded(
          child: InkWell(
            onTap: onSellTap,
            child: Container(
              alignment: Alignment.center,

              // height: MediaQuery.sizeOf(context).height * 0.09,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              decoration: BoxDecoration(
                color: ColorTheme.bearish,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    sellAmount ?? '0.0',
                    style: const TextStyle(
                      color: ColorTheme.primaryText,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8,
                    children: [
                      const Icon(Icons.sell, color: Colors.white, size: 20),
                      const CustomText(
                        'SELL',
                        style: TextStyle(
                          color: ColorTheme.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: onBuyTap,
            child: Container(
              // height: MediaQuery.sizeOf(context).height * 0.09,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              decoration: BoxDecoration(
                color: ColorTheme.bullish,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    buyAmount ?? '0.0',
                    style: const TextStyle(
                      color: ColorTheme.primaryText,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 20,
                      ),
                      const CustomText(
                        'BUY',
                        style: TextStyle(
                          color: ColorTheme.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
