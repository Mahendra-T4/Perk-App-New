import 'package:flutter/material.dart';

import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';
import 'package:perk_app/features/trade/presentation/widgets/close_order_button.dart';

class ClosedPortfolioDataItem {
  final String stockName;
  final dynamic brokerageValue;
  final dynamic sellPrice;
  final dynamic profitLoss;
  final dynamic buyPrice;

  final int quantity;

  ClosedPortfolioDataItem({
    required this.stockName,

    required this.profitLoss,

    required this.quantity,
    required this.brokerageValue,
    required this.sellPrice,
    required this.buyPrice,
  });
}

class ClosedPortfolioCartTile extends StatefulWidget {
  const ClosedPortfolioCartTile({super.key, required this.data});
  final ClosedPortfolioDataItem data;

  @override
  State<ClosedPortfolioCartTile> createState() =>
      _ClosedPortfolioCartTileState();
}

class _ClosedPortfolioCartTileState extends State<ClosedPortfolioCartTile> {
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
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 8,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: widget.data.profitLoss.toString().contains('-')
                              ? ColorTheme.bearish
                              : ColorTheme.bullish,
                        ),
                      ),
                      child: Row(
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
                              color:
                                  widget.data.profitLoss.toString().contains(
                                    '-',
                                  )
                                  ? ColorTheme.bearish
                                  : ColorTheme.bullish,
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: ColorTheme.bullish),
                      ),
                      child: CustomText(
                        'Qty: ${widget.data.quantity}',
                        style: TextStyle(
                          color: ColorTheme.bullish,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomText(
                  'Avg. Sell: ${widget.data.sellPrice}',
                  style: TextStyle(
                    color: ColorTheme.primaryText,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ),
              Expanded(
                child: CustomText(
                  'Avg. Buy: ${widget.data.buyPrice}',
                  style: TextStyle(
                    color: ColorTheme.primaryText,

                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                'Net Profile/Loss: ${widget.data.profitLoss}',
                style: TextStyle(
                  color: ColorTheme.primaryText,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
              CustomText(
                'Brokerage: ${widget.data.brokerageValue}',
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
