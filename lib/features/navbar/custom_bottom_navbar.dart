import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perk_app/core/constants/font_family.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/features/auth/presentation/page/change-password/change_password.dart';
import 'package:perk_app/features/home/presentation/page/mcx/mcx.dart';
import 'package:perk_app/features/home/presentation/page/nfo/nfo.dart';
import 'package:perk_app/features/notifications/presentation/page/notification_panel.dart';

import 'package:perk_app/features/portfolio/presentation/page/portfolio.dart';
import 'package:perk_app/features/trade/presentation/page/trade.dart';
import 'package:perk_app/features/user/presentation/pages/account_settings.dart';
import 'package:perk_app/features/user/presentation/pages/complaint/ledge_compaint.dart';
import 'package:perk_app/features/user/presentation/pages/ledger/ledger_report.dart';
import 'package:perk_app/features/user/presentation/pages/payment/deposit_payment.dart';
import 'package:perk_app/features/user/presentation/pages/payment/payment.dart';
import 'package:perk_app/features/user/presentation/pages/profile/user_profile.dart';
import 'package:perk_app/features/user/presentation/pages/wallet/user_wallet.dart';
import 'package:perk_app/features/user/presentation/pages/withdraw/withdraw.dart';
import 'package:perk_app/features/watchlist/presentation/pages/watchlist.dart';

class GlobalNavBar extends StatefulWidget {
  // final int? navigateIndex;
  final Widget? child;

  static const String routeName = '/global-nav-bar';

  const GlobalNavBar({super.key, this.child});

  @override
  _GlobalNavBarState createState() => _GlobalNavBarState();
}

class _GlobalNavBarState extends State<GlobalNavBar>
    with SingleTickerProviderStateMixin {
  late int _selectedIndex;
  late AnimationController _controller;
  late Animation<double> _animation;

  static final List<String> _listOfWidget = [
    WatchList.routeName,
    TradePanel.routeName,
    PortfolioPanel.routeName,
    AccountSettingsPanel.routeName,
  ];

  final List<String> _allRoutes = [
    WalletPanel.routeName,
    WithdrawPanel.routeName,
    ChangePasswordPanel.routeName,
    PaymentScreen.routeName,
    LedgeComplaint.routeName, // Assuming you have a ledger balance screen
    UserProfile.routeName, // Assuming you have a profile info screen
    LedgeComplaint.routeName, // Assuming you have a complaint screen
  ];

  // Routes where navbar should be neutral (no selection)
  static const String notificationRouteName = NotificationPanel.routeName;
  final List<String> _neutralRoutes = [
    notificationRouteName,
    MCXPanel.routeName,
    NFOPanel.routeName,
    WithdrawPanel.routeName,
    WalletPanel.routeName,
    // SuproxuRulesPage.routeName,
    UserProfile.routeName,
    LedgeComplaint.routeName,
    PaymentScreen.routeName,
    LedgerReport.routeName,
    DepositPayment.routeName,
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0; // Default to first tab (Home)
    // _selectedIndex =
    //     widget.navigateIndex ?? 2; // Default to Home if not provided
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      context.goNamed(_listOfWidget[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final currentPath = GoRouterState.of(context).uri.path;

    // Check if current path is a neutral route (like notification page)
    if (_neutralRoutes.contains(currentPath)) {
      _selectedIndex = -1; // Neutral - no item selected
    } else {
      _selectedIndex = _listOfWidget.indexOf(currentPath);
      if (_selectedIndex == -1) {
        _selectedIndex = _allRoutes.contains(currentPath)
            ? 3
            : 0; // Default to first tab if on a non-nav route
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        child: widget.child,
      ),
      bottomNavigationBar: ClipRRect(
        // borderRadius: BorderRadius.circular(24),
        child: Container(
          height: 60 + bottomPadding,
          color: ColorTheme.secondarySurface,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavBarItem(
                icon: Icons.list,
                label: 'WatchList',
                selected: _selectedIndex == 0,
                onTap: () => _onItemTapped(0),
              ),
              _NavBarItem(
                icon: Icons.show_chart_rounded,
                label: 'Trade',
                selected: _selectedIndex == 1,
                onTap: () => _onItemTapped(1),
              ),
              _NavBarItem(
                icon: Icons.pie_chart,
                label: 'Portfolio',
                selected: _selectedIndex == 2,
                onTap: () => _onItemTapped(2),
              ),
              _NavBarItem(
                icon: Icons.person_rounded,
                label: 'Account',
                selected: _selectedIndex == 3,
                onTap: () => _onItemTapped(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? Colors.white : Colors.grey.shade600;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: 4,
              width: 32,
              margin: EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: selected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Icon(icon, color: color, size: 28),
            SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontFamily: FontFamily.globalFontFamily,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
