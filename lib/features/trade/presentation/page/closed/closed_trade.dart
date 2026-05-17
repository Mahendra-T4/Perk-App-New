import 'package:flutter/material.dart';
import 'package:perk_app/features/trade/presentation/widgets/active_trade_tile.dart';
import 'package:perk_app/features/trade/presentation/widgets/closed_trade_tile.dart';

class ClosedTradePanel extends StatelessWidget {
  const ClosedTradePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
        itemBuilder: (context, index) {
          return ClosedTradeTile(
            cartData: ClosedTradeCartData(
              stockName: 'CRUDEOIL',

              dateTime: '2024-12-31 14:30',

              profitLoss: '3,000,00',
              qty: 100,
              sellPrice: '4,000',
              buyPrice: '1,000',
            ),
          );
        },
      ),
    );
  }
}
