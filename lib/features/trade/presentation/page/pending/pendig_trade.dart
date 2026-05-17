import 'package:flutter/material.dart';
import 'package:perk_app/features/trade/presentation/widgets/active_trade_tile.dart';
import 'package:perk_app/features/trade/presentation/widgets/pending_trade_tile.dart';

class PendingTradePanel extends StatelessWidget {
  const PendingTradePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
        itemBuilder: (context, index) {
          return PendingTradeTile(
            cartData: CartData(
              tradeMethodXQuantity: 'Sell X 100',
              stockPrice: '4,000',
              stockName: 'CRUDEOIL',
              margin: '',
              dateTime: '2024-12-31 14:30',
              holdingMarReq: '',
              tradeMethod: 2,
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
