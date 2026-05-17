import 'package:flutter/material.dart';

import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';
import 'package:perk_app/features/trade/presentation/widgets/close_order_button.dart';

class ActivePortfolioData {
  final String stockName;
  final dynamic tradePrice;
  final int tradeMethod;
  final dynamic profitLoss;
  final dynamic cmp;
  final dynamic m2m;
  final int quantity;
  final dynamic holdingMargin;
  final dynamic margin;
  ActivePortfolioData({
    required this.stockName,
    required this.tradePrice,
    required this.tradeMethod,
    required this.profitLoss,
    required this.cmp,
    required this.m2m,
    required this.margin,
    required this.holdingMargin,
    required this.quantity,
  });
}

class ActivePortfolioCartTile extends StatefulWidget {
  const ActivePortfolioCartTile({super.key, required this.data});
  final ActivePortfolioData data;

  @override
  State<ActivePortfolioCartTile> createState() =>
      _ActivePortfolioCartTileState();
}

class _ActivePortfolioCartTileState extends State<ActivePortfolioCartTile> {
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
            children: [
              Expanded(
                child: CustomText(
                  widget.data.stockName,
                  style: TextStyle(
                    color: ColorTheme.primaryText,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              Expanded(
                child: CustomText(
                  (() {
                    if (widget.data.tradeMethod == 1) {
                      return 'Sold ${widget.data.quantity} X ${widget.data.tradePrice}';
                    } else {
                      return 'Bought ${widget.data.quantity} X ${widget.data.tradePrice}';
                    }
                  })(),
                  style: TextStyle(
                    color: widget.data.tradeMethod == 1
                        ? ColorTheme.bearish
                        : ColorTheme.bullish,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                'Profit/Loss: ',
                style: TextStyle(
                  color: ColorTheme.primaryText,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
              CustomText(
                widget.data.profitLoss.toString(),
                style: TextStyle(
                  color: widget.data.profitLoss.toString().contains('-')
                      ? ColorTheme.bearish
                      : ColorTheme.bullish,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                'Margin: ${widget.data.margin}',
                style: TextStyle(
                  color: ColorTheme.primaryText,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
              CustomText(
                'CMP: ${widget.data.cmp}',
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
              CustomText(
                'Holding Margin: ${widget.data.holdingMargin}',
                style: TextStyle(
                  color: ColorTheme.primaryText,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
              CustomText(
                'M 2 M: ${widget.data.m2m}',
                style: TextStyle(
                  color: ColorTheme.primaryText,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [CloseOrderButton()],
          ),
        ],
      ),
    );
  }
}
