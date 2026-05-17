import 'package:flutter/material.dart';
import 'package:perk_app/core/components/appbar.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';
import 'package:perk_app/features/user/presentation/pages/withdraw/withdraw.dart';
import 'package:perk_app/features/user/presentation/widgets/amount_alert_dialog.dart';

class WalletPanel extends StatefulWidget {
  const WalletPanel({super.key});
  static const String routeName = '/user-wallet-panel';

  @override
  State<WalletPanel> createState() => _WalletPanelState();
}

class _WalletPanelState extends State<WalletPanel> {
  final List<Withdraw> wallets = [
    Withdraw(date: '2024-01-15', amount: 5000),
    Withdraw(date: '2024-02-20', amount: 3000),
    Withdraw(date: '2024-03-10', amount: 7000),
    Withdraw(date: '2024-01-15', amount: 5000),
    Withdraw(date: '2024-02-20', amount: 3000),
    Withdraw(date: '2024-03-10', amount: 7000),
    Withdraw(date: '2024-01-15', amount: 5000),
    Withdraw(date: '2024-02-20', amount: 3000),
    Withdraw(date: '2024-03-10', amount: 7000),
    Withdraw(date: '2024-01-15', amount: 5000),
    Withdraw(date: '2024-02-20', amount: 3000),
    Withdraw(date: '2024-03-10', amount: 7000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Wallet'),
      body: ListView.builder(
        padding: const EdgeInsets.only(
          bottom: 120,
          left: 12,
          right: 12,
          top: 12,
        ),
        itemCount: wallets.length,
        itemBuilder: (context, index) {
          final wallet = wallets[index];
          return _WalletCard(wallet: wallet, index: index);
        },
      ),
    );
  }
}

class _WalletCard extends StatefulWidget {
  final Withdraw wallet;
  final int index;

  const _WalletCard({required this.wallet, required this.index});

  @override
  State<_WalletCard> createState() => _WalletCardState();
}

class _WalletCardState extends State<_WalletCard>
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
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: ColorTheme.bullish.withOpacity(
                    _isHovered ? 0.25 : 0.1,
                  ),
                  blurRadius: _isHovered ? 16 : 8,
                  spreadRadius: _isHovered ? 1 : 0,
                  offset: Offset(0, _isHovered ? 6 : 2),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
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
                      ? ColorTheme.bullish.withOpacity(0.5)
                      : ColorTheme.bullish.withOpacity(0.15),
                  width: 1.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Row(
                        children: [
                          // Wallet icon with background
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  ColorTheme.bullish.withOpacity(0.2),
                                  ColorTheme.bullish.withOpacity(0.05),
                                ],
                              ),
                              border: Border.all(
                                color: ColorTheme.bullish.withOpacity(0.3),
                              ),
                            ),
                            child: Icon(
                              Icons.account_balance_wallet_rounded,
                              color: ColorTheme.bullish,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),
                          // Date and amount info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  'Balance Update',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: ColorTheme.secondaryText,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                CustomText(
                                  widget.wallet.date.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: ColorTheme.primaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Amount badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  ColorTheme.bullish.withOpacity(0.15),
                                  ColorTheme.bullish.withOpacity(0.05),
                                ],
                              ),
                              border: Border.all(
                                color: ColorTheme.bullish.withOpacity(0.3),
                              ),
                            ),
                            child: CustomText(
                              widget.wallet.amount.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: ColorTheme.bullish,
                              ),
                            ),
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
}
