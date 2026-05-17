import 'package:flutter/material.dart';
import 'package:perk_app/core/components/appbar.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';
import 'package:perk_app/features/user/presentation/widgets/amount_alert_dialog.dart';

class Withdraw {
  final String date;
  final dynamic amount;

  Withdraw({required this.date, required this.amount});
}

class WithdrawPanel extends StatefulWidget {
  const WithdrawPanel({super.key});
  static const String routeName = '/withdraw-panel';

  @override
  State<WithdrawPanel> createState() => _WithdrawPanelState();
}

class _WithdrawPanelState extends State<WithdrawPanel> {
  final List<Withdraw> withdraws = [
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
      appBar: customAppBar(context: context, title: 'Withdraw'),
      body: ListView.builder(
        padding: const EdgeInsets.only(
          bottom: 120,
          left: 12,
          right: 12,
          top: 12,
        ),
        itemCount: withdraws.length,
        itemBuilder: (context, index) {
          final withdraw = withdraws[index];
          return _WithdrawCard(withdraw: withdraw, index: index);
        },
      ),
      floatingActionButton: _ModernFAB(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AmountAlertDialog(
              title: 'Withdraw Amount',
              description: 'Enter the amount you want to withdraw',
              hint: 'Amount',
              onSubmit: (amount) {
                // Handle the withdrawal with the entered amount
                print('Withdrawing: $amount');
                // Add your withdrawal logic here
              },
              onCancel: () {
                // Handle cancel action if needed
                print('Withdrawal cancelled');
              },
            ),
          );
        },
      ),
    );
  }
}

class _WithdrawCard extends StatefulWidget {
  final Withdraw withdraw;
  final int index;

  const _WithdrawCard({required this.withdraw, required this.index});

  @override
  State<_WithdrawCard> createState() => _WithdrawCardState();
}

class _WithdrawCardState extends State<_WithdrawCard>
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
    _animationController.forward();
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
                  color: ColorTheme.primaryColor.withOpacity(
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
                      ? ColorTheme.primaryColor.withOpacity(0.5)
                      : ColorTheme.primaryColor.withOpacity(0.15),
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
                          // Status indicator
                          Container(
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  ColorTheme.bullish,
                                  ColorTheme.bullish.withOpacity(0.7),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorTheme.bullish.withOpacity(0.4),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ],
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
                                  'Withdrawal',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: ColorTheme.secondaryText,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                CustomText(
                                  widget.withdraw.date.toString(),
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
                                  ColorTheme.primaryColor.withOpacity(0.15),
                                  ColorTheme.primaryColor.withOpacity(0.05),
                                ],
                              ),
                              border: Border.all(
                                color: ColorTheme.primaryColor.withOpacity(0.3),
                              ),
                            ),
                            child: CustomText(
                              widget.withdraw.amount.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: ColorTheme.primaryColor,
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

class _ModernFAB extends StatefulWidget {
  final VoidCallback onPressed;

  const _ModernFAB({required this.onPressed});

  @override
  State<_ModernFAB> createState() => _ModernFABState();
}

class _ModernFABState extends State<_ModernFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _rotateAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handlePress() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 1.15).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: ColorTheme.primaryColor.withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _handlePress,
          backgroundColor: ColorTheme.primaryColor,
          elevation: 8,
          child: RotationTransition(
            turns: _rotateAnimation,
            child: Icon(
              Icons.add_rounded,
              color: ColorTheme.primaryText,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
