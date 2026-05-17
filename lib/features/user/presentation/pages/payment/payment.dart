import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perk_app/assets/assets.dart';
import 'package:perk_app/core/components/appbar.dart';
import 'package:perk_app/core/theme/color_theme.dart';

import 'dart:async';

import 'package:perk_app/core/utils/widget/text.dart';
import 'package:perk_app/features/user/presentation/pages/payment/deposit_payment.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  static const String routeName = '/payment-screen';

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  DateTime fromDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime toDate = DateTime.now();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  // Timer? _validationTimer;
  // StreamSubscription<void>? _logoutSub;

  String? payStatus;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> pickFromDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: fromDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != fromDate) {
      setState(() {
        fromDate = selectedDate!;
      });
    }
  }

  Future<void> pickToDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: toDate,
      firstDate: fromDate,
      lastDate: DateTime(2100),
    );

    if (selectedDate != toDate) {
      setState(() {
        toDate = selectedDate!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorTheme.surface,
      child: SafeArea(
        child: Scaffold(
          appBar: customAppBar(context: context, title: 'Payment'),
          body: FadeTransition(
            opacity: _fadeAnimation,
            child: ListView.builder(
              padding: const EdgeInsets.only(
                bottom: 120,
                left: 12,
                right: 12,
                top: 12,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return _PaymentCard(index: index);
              },
            ),
          ),
          floatingActionButton: _ModernDepositFAB(
            onPressed: () {
              GoRouter.of(context).push(DepositPayment.routeName);
            },
          ),
        ),
      ),
    );
  }
}

class _PaymentCard extends StatefulWidget {
  final int index;

  const _PaymentCard({required this.index});

  @override
  State<_PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<_PaymentCard>
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
    final isCompleted = widget.index % 3 == 0;
    final isPending = widget.index % 3 == 1;
    final accentColor = isCompleted
        ? ColorTheme.bullish
        : isPending
        ? ColorTheme.primaryColor
        : ColorTheme.bearish;

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
                  color: accentColor.withOpacity(_isHovered ? 0.25 : 0.1),
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
                      ? accentColor.withOpacity(0.5)
                      : accentColor.withOpacity(0.15),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header row with status and date/time
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Status badge
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
                                  isCompleted
                                      ? 'COMPLETED'
                                      : isPending
                                      ? 'PENDING'
                                      : 'FAILED',
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
                                    '2023-10-01',
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
                          // Symbol and amount row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Payment',
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
                                      'TXN001',
                                      style: TextStyle(
                                        color: ColorTheme.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Amount badge
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
                                      accentColor.withOpacity(0.15),
                                      accentColor.withOpacity(0.05),
                                    ],
                                  ),
                                  border: Border.all(
                                    color: accentColor.withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  '₹100',
                                  style: TextStyle(
                                    color: accentColor,
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
                              _buildDetailChip(
                                'Type',
                                isCompleted
                                    ? 'Online'
                                    : isPending
                                    ? 'Pending'
                                    : 'Failed',
                              ),
                              _buildDetailChip('Mode', 'Direct'),
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

class _ModernDepositFAB extends StatefulWidget {
  final VoidCallback onPressed;

  const _ModernDepositFAB({required this.onPressed});

  @override
  State<_ModernDepositFAB> createState() => _ModernDepositFABState();
}

class _ModernDepositFABState extends State<_ModernDepositFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.12).animate(
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
      scale: _scaleAnimation,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: ColorTheme.primaryColor.withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            onTap: _handlePress,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorTheme.primaryColor,
                    ColorTheme.primaryColor.withOpacity(0.8),
                  ],
                ),
                border: Border.all(
                  color: ColorTheme.primaryColor.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.depositIcon,
                    width: 24,
                    height: 24,
                    color: ColorTheme.primaryText,
                  ),
                  const SizedBox(width: 10),
                  CustomText(
                    'Deposit',
                    style: TextStyle(
                      color: ColorTheme.primaryText,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

               



// Extension to capitalize the first letter of a string

