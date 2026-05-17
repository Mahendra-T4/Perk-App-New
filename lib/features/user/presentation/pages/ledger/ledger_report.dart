import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perk_app/core/components/appbar.dart';
import 'package:perk_app/core/constants/font_family.dart';
import 'package:perk_app/core/constants/text_const.dart';
import 'package:perk_app/core/theme/color_theme.dart';

class LedgerReport extends StatefulWidget {
  const LedgerReport({super.key});
  static const String routeName = '/ledger-report';

  @override
  State<LedgerReport> createState() => _LedgerReportState();
}

class _LedgerReportState extends State<LedgerReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Ledger Report'),
      body: ListView.builder(
        padding: const EdgeInsets.only(
          bottom: 120,
          left: 12,
          right: 12,
          top: 12,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return _LedgerCard(index: index);
        },
      ),
    );
  }
}

class _LedgerCard extends StatefulWidget {
  final int index;

  const _LedgerCard({required this.index});

  @override
  State<_LedgerCard> createState() => _LedgerCardState();
}

class _LedgerCardState extends State<_LedgerCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _slideAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    Future.delayed(Duration(milliseconds: widget.index * 50), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isBuy = widget.index % 2 == 0;
    final accentColor = isBuy ? ColorTheme.bullish : ColorTheme.bearish;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ScaleTransition(
        scale: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withOpacity(_isHovered ? 0.25 : 0.1),
                  blurRadius: _isHovered ? 16 : 8,
                  spreadRadius: _isHovered ? 1 : 0,
                  offset: Offset(0, _isHovered ? 6 : 2),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorTheme.secondarySurface,
                    ColorTheme.secondarySurface.withOpacity(0.6),
                  ],
                ),
                border: Border.all(
                  color: _isHovered
                      ? accentColor.withOpacity(0.5)
                      : accentColor.withOpacity(0.15),
                  width: 1.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header row with status and date/time
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Trade type badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      accentColor.withOpacity(0.2),
                                      accentColor.withOpacity(0.05),
                                    ],
                                  ),
                                  border: Border.all(
                                    color: accentColor.withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  isBuy ? 'BUY' : 'SELL',
                                  style: TextStyle(
                                    color: accentColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              // Date and time
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '2024-01-15',
                                    style: TextStyle(
                                      color: ColorTheme.primaryText,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '10:30 AM',
                                    style: TextStyle(
                                      color: ColorTheme.secondaryText,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Symbol and price row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'RELIANCE',
                                    style: TextStyle(
                                      color: ColorTheme.primaryText,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: ColorTheme.primaryColor
                                          .withOpacity(0.15),
                                    ),
                                    child: Text(
                                      'MCX',
                                      style: TextStyle(
                                        color: ColorTheme.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Price badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      ColorTheme.primaryColor.withOpacity(0.15),
                                      ColorTheme.primaryColor.withOpacity(0.05),
                                    ],
                                  ),
                                  border: Border.all(
                                    color: ColorTheme.primaryColor.withOpacity(
                                      0.3,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  '₹2500',
                                  style: TextStyle(
                                    color: ColorTheme.primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          // Details row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildDetailChip('Qty', '100'),
                              _buildDetailChip('Category', 'MCX'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailChip(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            color: ColorTheme.secondaryText,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: ColorTheme.primaryText,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

// Keep helper methods for backward compatibility
extension on Text {
  Widget textStyleH1() => this;
  Widget textStyleH2() => this;
}
