import 'package:flutter/material.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';

class ClosedTradeCartData {
  final String stockName;
  final dynamic profitLoss;

  final int qty;
  final String dateTime;
  final dynamic sellPrice;
  final dynamic buyPrice;

  ClosedTradeCartData({
    required this.stockName,
    required this.profitLoss,
    required this.qty,
    required this.dateTime,
    required this.sellPrice,
    required this.buyPrice,
  });
}

class ClosedTradeTile extends StatelessWidget {
  const ClosedTradeTile({super.key, required this.cartData});
  final ClosedTradeCartData cartData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: ColorTheme.secondarySurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 8,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: CustomText(
                  cartData.stockName.toString(),
                  style: TextStyle(
                    color: ColorTheme.primaryText,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),

              Expanded(
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: cartData.profitLoss.toString().contains('-')
                              ? ColorTheme.bullish
                              : ColorTheme.bearish,
                        ),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: CustomText(
                        cartData.profitLoss.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: ColorTheme.primaryText,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorTheme.bullish),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: CustomText(
                        cartData.qty.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: ColorTheme.primaryText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  spacing: 8,
                  children: [
                    CustomText(
                      'Sold By Trader',
                      style: TextStyle(
                        color: ColorTheme.secondaryText,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorTheme.bearish),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: CustomText(
                        cartData.sellPrice.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: ColorTheme.primaryText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      'Bought By Trader',
                      style: TextStyle(
                        color: ColorTheme.secondaryText,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorTheme.bullish),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: CustomText(
                        cartData.buyPrice.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: ColorTheme.primaryText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //* 'Sold by Trader'
              CustomText(
                cartData.dateTime,
                style: TextStyle(
                  color: ColorTheme.primaryText,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
