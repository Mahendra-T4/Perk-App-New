import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';
import 'package:perk_app/features/trade/presentation/page/trade.dart';

class ProfilePortfolioItem {
  final dynamic balance;
  final dynamic profitLoss;
  final int active;
  final int closed;

  ProfilePortfolioItem({
    required this.balance,
    required this.profitLoss,
    required this.active,
    required this.closed,
  });
}

class PortfolioProfileCart extends StatelessWidget {
  const PortfolioProfileCart({super.key, required this.item});
  final ProfilePortfolioItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorTheme.primaryColor.withOpacity(0.15),
            ColorTheme.primaryColor.withOpacity(0.05),
          ],
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildModernStatCard(
                  item.balance.toString(),
                  'Balance',
                  Icons.account_balance_wallet_rounded,
                  [
                    ColorTheme.primaryColor.withOpacity(0.8),
                    ColorTheme.primaryColor.withOpacity(0.5),
                  ],
                  () {},
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildModernStatCard(
                  item.profitLoss.toString(),
                  'Profit/Loss',
                  Icons.trending_up_rounded,
                  [
                    ColorTheme.bullish.withOpacity(0.8),
                    ColorTheme.bullish.withOpacity(0.5),
                  ],
                  () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildModernStatCard(
                  item.active.toString(),
                  'Active',
                  Icons.flash_on_rounded,
                  [
                    Color(0xFFFF9500).withOpacity(0.8),
                    Color(0xFFFF9500).withOpacity(0.5),
                  ],
                  () {
                    GoRouter.of(
                      context,
                    ).pushNamed(TradePanel.routeName, extra: 0);
                  },
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildModernStatCard(
                  item.closed.toString(),
                  'Closed',
                  Icons.check_circle_rounded,
                  [
                    ColorTheme.bearish.withOpacity(0.8),
                    ColorTheme.bearish.withOpacity(0.5),
                  ],
                  () {
                    GoRouter.of(
                      context,
                    ).pushNamed(TradePanel.routeName, extra: 2);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernStatCard(
    String value,
    String label,
    IconData icon,
    List<Color> colors,
    void Function()? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: colors[0].withOpacity(0.25),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 2,
            ),
          ],
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.25)),
              ),
              child: Icon(icon, color: Colors.white, size: 18),
            ),
            const SizedBox(height: 15),
            CustomText(
              value,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            CustomText(
              label,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.85),
            ),
            const SizedBox(height: 14),
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
