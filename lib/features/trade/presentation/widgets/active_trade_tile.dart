import 'package:flutter/material.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';
import 'package:perk_app/features/trade/presentation/widgets/close_order_button.dart';

class CartData {
  final String tradeMethodXQuantity;
  final dynamic stockPrice;
  final String stockName;
  final int tradeMethod;

  final dynamic margin;
  final String dateTime;
  final dynamic holdingMarReq;

  CartData({
    required this.tradeMethodXQuantity,
    required this.stockPrice,
    required this.stockName,

    required this.margin,
    required this.dateTime,
    required this.holdingMarReq,
    required this.tradeMethod,
  });
}

class ActiveTradeTile extends StatelessWidget {
  const ActiveTradeTile({super.key, required this.cartData});
  final CartData cartData;

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
              //* trade mathod x quantity
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: cartData.tradeMethod == 1
                        ? ColorTheme.bullish
                        : ColorTheme.bearish,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: CustomText(
                  cartData.tradeMethodXQuantity,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: ColorTheme.primaryText,
                  ),
                ),
              ),

              //* stock price
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: cartData.tradeMethod == 1
                        ? ColorTheme.bullish
                        : ColorTheme.bearish,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: CustomText(
                  cartData.stockPrice.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: ColorTheme.primaryText,
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                flex: 2,
                child: CustomText(
                  cartData.stockName,
                  style: TextStyle(
                    color: ColorTheme.primaryText,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              CloseOrderButton(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //* 'Sold by Trader'
              CustomText(
                (() {
                  if (cartData.tradeMethod == 1) {
                    return 'Sold by Trader';
                  } else {
                    return 'Bought by Trader';
                  }
                })(),
                style: TextStyle(
                  color: ColorTheme.primaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
              CustomText(
                'Margin: ${cartData.margin}',
                style: TextStyle(
                  color: ColorTheme.primaryText,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              CustomText(
                'Holding Mar Req.: ${cartData.holdingMarReq}',
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
