import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perk_app/features/portfolio/presentation/widget/active_portfolio_carttile.dart';
import 'package:perk_app/features/portfolio/presentation/widget/active_portfolio_header_cart.dart';

class ActivePortfolio extends StatefulWidget {
  const ActivePortfolio({super.key});
  static const String routeName = '/active-portfolio';

  @override
  State<ActivePortfolio> createState() => _ActivePortfolioState();
}

class _ActivePortfolioState extends State<ActivePortfolio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 12.w, right: 12.h, top: 12.h),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ActivePortfolioHeaderCart(
                item: ActivePortfolioDataItem(
                  ledgerBalance: '75,000.00',
                  availableMargin: '50,000.00',
                  profitLoss: '10,000.00',
                  m2m: '10,000.00',
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return ActivePortfolioCartTile(
                  data: ActivePortfolioData(
                    stockName: 'CRUDEOIL',
                    tradePrice: 100.0,
                    tradeMethod: 1,
                    profitLoss: 10.0,
                    cmp: 110.0,
                    m2m: 10.0,
                    margin: 500.0,
                    holdingMargin: 1000.0,
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
