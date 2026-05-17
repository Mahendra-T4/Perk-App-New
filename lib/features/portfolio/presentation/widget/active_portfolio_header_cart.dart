import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';

class ActivePortfolioDataItem {
  final String ledgerBalance;
  final String availableMargin;
  final String profitLoss;
  final String m2m;

  ActivePortfolioDataItem({
    required this.ledgerBalance,
    required this.availableMargin,
    required this.profitLoss,
    required this.m2m,
  });
}

class ActivePortfolioHeaderCart extends StatefulWidget {
  const ActivePortfolioHeaderCart({super.key, required this.item});
  final ActivePortfolioDataItem item;

  @override
  State<ActivePortfolioHeaderCart> createState() =>
      _ActivePortfolioHeaderCartState();
}

class _ActivePortfolioHeaderCartState extends State<ActivePortfolioHeaderCart> {
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
                  widget.item.ledgerBalance.toString(),
                  'Ledger Balance',
                  Icons.account_balance_wallet_rounded,
                  [
                    Color(0xFF2563EB).withOpacity(0.8),
                    Color(0xFF0EA5E9).withOpacity(0.5),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildModernStatCard(
                  widget.item.profitLoss.toString(),
                  'Profit/Loss',
                  Icons.show_chart_rounded,
                  [
                    Color(0xFF16A34A).withOpacity(0.8),
                    Color(0xFF84CC16).withOpacity(0.5),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildModernStatCard(
                  widget.item.availableMargin.toString(),
                  'Available Margin',
                  Icons.dashboard_rounded,
                  [
                    Color(0xFFA855F7).withOpacity(0.8),
                    Color(0xFFEC4899).withOpacity(0.5),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildModernStatCard(
                  widget.item.m2m.toString(),
                  'M 2 M',
                  Icons.sync_rounded,
                  [
                    Color(0xFFDC2626).withOpacity(0.8),
                    Color(0xFFFF8C42).withOpacity(0.5),
                  ],
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
  ) {
    return Container(
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
    );
  }
}
