import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perk_app/features/portfolio/presentation/widget/closed_portfolio_carttile.dart';
import 'package:perk_app/features/portfolio/presentation/widget/closed_trade_headertile.dart';

class ClosePortfolio extends StatefulWidget {
  const ClosePortfolio({super.key});
  static const String routeName = '/closed-portfolio';

  @override
  State<ClosePortfolio> createState() => _ClosePortfolioState();
}

class _ClosePortfolioState extends State<ClosePortfolio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ClosedPortfolioHeaderCart(
                item: ClosedPortfolioData(
                  ledgerBalance: 100000.00,

                  profitLoss: 12500.00,

                  totalBrokerage: 12500.00,
                  netProfitLoss: 100000.00,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return ClosedPortfolioCartTile(
                  data: ClosedPortfolioDataItem(
                    stockName: 'CRUDEOIL',
                    brokerageValue: 100.0,
                    sellPrice: 100.0,
                    profitLoss: 10.0,
                    buyPrice: 90.0,
                    quantity: 10,
                  ),
                );
              }, childCount: 10),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 12.h)),
          ],
        ),
      ),
    );
  }
}
