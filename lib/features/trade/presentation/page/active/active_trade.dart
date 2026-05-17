import 'package:flutter/material.dart';
import 'package:perk_app/features/trade/presentation/widgets/active_trade_tile.dart';
import 'package:perk_app/features/trade/presentation/widgets/close_all_trade_button.dart';

class ActiveTradePanel extends StatelessWidget {
  const ActiveTradePanel({super.key});
  static const String routeName = '/active-trade';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 12, right: 12),
        child: Column(
          children: [
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: CloseAllTradeButton(
                    category: 'MCX',
                    onTap: () {
                      // Handle close all buy orders
                    },
                  ),
                ),
                Expanded(
                  child: CloseAllTradeButton(
                    category: 'MCX',
                    onTap: () {
                      // Handle close all buy orders
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ActiveTradeTile(
                    cartData: CartData(
                      tradeMethodXQuantity: 'BUY x 100',
                      stockPrice: '450.25',
                      stockName: 'COPPER',
                      margin: '₹ 5000',
                      dateTime: '2024-12-31 14:30',
                      holdingMarReq: '₹ 2000',
                      tradeMethod: 1,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
