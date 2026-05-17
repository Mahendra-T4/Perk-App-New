// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:perk_app/core/constants/font_family.dart';
// import 'package:perk_app/core/theme/color_theme.dart';
// import 'package:perk_app/features/auth/presentation/page/change-password/change_password.dart';
// import 'package:perk_app/features/home/presentation/page/mcx/mcx.dart';
// import 'package:perk_app/features/home/presentation/page/nfo/nfo.dart';
// import 'package:perk_app/features/notifications/presentation/page/notification_panel.dart';

// import 'package:perk_app/features/portfolio/presentation/page/portfolio.dart';
// import 'package:perk_app/features/trade/presentation/page/trade.dart';
// import 'package:perk_app/features/user/presentation/pages/account_settings.dart';
// import 'package:perk_app/features/user/presentation/pages/complaint/ledge_compaint.dart';
// import 'package:perk_app/features/user/presentation/pages/ledger/ledger_report.dart';
// import 'package:perk_app/features/user/presentation/pages/payment/deposit_payment.dart';
// import 'package:perk_app/features/user/presentation/pages/payment/payment.dart';
// import 'package:perk_app/features/user/presentation/pages/profile/user_profile.dart';
// import 'package:perk_app/features/user/presentation/pages/wallet/user_wallet.dart';
// import 'package:perk_app/features/user/presentation/pages/withdraw/withdraw.dart';
// import 'package:perk_app/features/watchlist/presentation/pages/watchlist.dart';

// class GlobalNavBar extends StatefulWidget {
//   // final int? navigateIndex;
//   final Widget? child;

//   static const String routeName = '/global-nav-bar';

//   const GlobalNavBar({super.key, this.child});

//   @override
//   _GlobalNavBarState createState() => _GlobalNavBarState();
// }

// class _GlobalNavBarState extends State<GlobalNavBar>
//     with SingleTickerProviderStateMixin {
//   late int _selectedIndex;
//   late AnimationController _controller;

//   static final List<String> _listOfWidget = [
//     WatchList.routeName,
//     TradePanel.routeName,
//     PortfolioPanel.routeName,
//     AccountSettingsPanel.routeName,
//   ];

//   final List<String> _allRoutes = [
//     WalletPanel.routeName,
//     WithdrawPanel.routeName,
//     ChangePasswordPanel.routeName,
//     PaymentScreen.routeName,
//     LedgeComplaint.routeName, // Assuming you have a ledger balance screen
//     UserProfile.routeName, // Assuming you have a profile info screen
//     LedgeComplaint.routeName, // Assuming you have a complaint screen
//   ];

//   // Routes where navbar should be neutral (no selection)
//   static const String notificationRouteName = NotificationPanel.routeName;
//   final List<String> _neutralRoutes = [
//     notificationRouteName,
//     MCXPanel.routeName,
//     NFOPanel.routeName,
//     WithdrawPanel.routeName,
//     WalletPanel.routeName,
//     // SuproxuRulesPage.routeName,
//     UserProfile.routeName,
//     LedgeComplaint.routeName,
//     PaymentScreen.routeName,
//     LedgerReport.routeName,
//     DepositPayment.routeName,
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _selectedIndex = 0;
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _onItemTapped(int index) {
//     if (_selectedIndex != index) {
//       setState(() {
//         _selectedIndex = index;
//       });
//       context.goNamed(_listOfWidget[index]);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
//     final currentPath = GoRouterState.of(context).uri.path;

//     // Check if current path is a neutral route (like notification page)
//     if (_neutralRoutes.contains(currentPath)) {
//       _selectedIndex = -1; // Neutral - no item selected
//     } else {
//       _selectedIndex = _listOfWidget.indexOf(currentPath);
//       if (_selectedIndex == -1) {
//         _selectedIndex = _allRoutes.contains(currentPath)
//             ? 3
//             : 0; // Default to first tab if on a non-nav route
//       }
//     }

//     return Scaffold(
//       backgroundColor: const Color(0xFF121212),
//       body: Stack(
//         children: [
//           AnimatedSwitcher(
//             duration: const Duration(milliseconds: 350),
//             child: widget.child,
//           ),
//           Positioned(
//             bottom: 12 + bottomPadding,
//             left: 12,
//             right: 12,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               height: 50 + bottomPadding,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: ColorTheme.secondarySurface,
//                 borderRadius: BorderRadius.circular(24),
//                 // border: Border(
//                 //   top: BorderSide(
//                 //     color: Colors.white.withOpacity(0.1),
//                 //     width: 1.2,
//                 //   ),
//                 // ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _PremiumNavBarItem(
//                     icon: Icons.list_rounded,
//                     label: 'WatchList',
//                     selected: _selectedIndex == 0,
//                     onTap: () => _onItemTapped(0),
//                     color: ColorTheme.primaryColor,
//                   ),
//                   _PremiumNavBarItem(
//                     icon: Icons.trending_up_rounded,
//                     label: 'Trade',
//                     selected: _selectedIndex == 1,
//                     onTap: () => _onItemTapped(1),
//                     color: ColorTheme.primaryColor,
//                   ),
//                   _PremiumNavBarItem(
//                     icon: Icons.donut_large_rounded,
//                     label: 'Portfolio',
//                     selected: _selectedIndex == 2,
//                     onTap: () => _onItemTapped(2),
//                     color: ColorTheme.primaryColor,
//                   ),
//                   _PremiumNavBarItem(
//                     icon: Icons.account_circle_rounded,
//                     label: 'Account',
//                     selected: _selectedIndex == 3,
//                     onTap: () => _onItemTapped(3),
//                     color: ColorTheme.primaryColor,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       // bottomNavigationBar: Container(
//       //   height: 70 + bottomPadding,
//       //   decoration: BoxDecoration(
//       //     color: ColorTheme.secondarySurface,
//       //     border: Border(
//       //       top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1.2),
//       //     ),
//       //   ),
//       //   child: Padding(
//       //     padding: EdgeInsets.only(
//       //       bottom: bottomPadding,
//       //       left: 12,
//       //       right: 12,
//       //       // top: 8,
//       //     ),
//       //     child: Row(
//       //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       //       children: [
//       //         _PremiumNavBarItem(
//       //           icon: Icons.list_rounded,
//       //           label: 'WatchList',
//       //           selected: _selectedIndex == 0,
//       //           onTap: () => _onItemTapped(0),
//       //           color: ColorTheme.primaryColor,
//       //         ),
//       //         _PremiumNavBarItem(
//       //           icon: Icons.trending_up_rounded,
//       //           label: 'Trade',
//       //           selected: _selectedIndex == 1,
//       //           onTap: () => _onItemTapped(1),
//       //           color: ColorTheme.primaryColor,
//       //         ),
//       //         _PremiumNavBarItem(
//       //           icon: Icons.donut_large_rounded,
//       //           label: 'Portfolio',
//       //           selected: _selectedIndex == 2,
//       //           onTap: () => _onItemTapped(2),
//       //           color: ColorTheme.primaryColor,
//       //         ),
//       //         _PremiumNavBarItem(
//       //           icon: Icons.account_circle_rounded,
//       //           label: 'Account',
//       //           selected: _selectedIndex == 3,
//       //           onTap: () => _onItemTapped(3),
//       //           color: ColorTheme.primaryColor,
//       //         ),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }

// class _PremiumNavBarItem extends StatefulWidget {
//   final IconData icon;
//   final String label;
//   final bool selected;
//   final VoidCallback onTap;
//   final Color color;

//   const _PremiumNavBarItem({
//     required this.icon,
//     required this.label,
//     required this.selected,
//     required this.onTap,
//     required this.color,
//   });

//   @override
//   State<_PremiumNavBarItem> createState() => _PremiumNavBarItemState();
// }

// class _PremiumNavBarItemState extends State<_PremiumNavBarItem>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 350),
//       vsync: this,
//     );
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//     if (widget.selected) {
//       _animationController.forward();
//     }
//   }

//   @override
//   void didUpdateWidget(_PremiumNavBarItem oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.selected && !oldWidget.selected) {
//       _animationController.forward();
//     } else if (!widget.selected && oldWidget.selected) {
//       _animationController.reverse();
//     }
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           padding: EdgeInsets.symmetric(
//             horizontal: widget.selected ? 12 : 8,
//             vertical: 8,
//           ),
//           decoration: BoxDecoration(
//             gradient: widget.selected
//                 ? LinearGradient(
//                     colors: [
//                       widget.color.withOpacity(0.2),
//                       widget.color.withOpacity(0.08),
//                     ],
//                   )
//                 : null,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(
//               color: widget.selected
//                   ? widget.color.withOpacity(0.4)
//                   : Colors.transparent,
//               width: 1.5,
//             ),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 padding: const EdgeInsets.all(6),
//                 decoration: BoxDecoration(
//                   color: widget.selected
//                       ? widget.color.withOpacity(0.15)
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Icon(
//                   widget.icon,
//                   color: widget.selected ? widget.color : Colors.grey.shade600,
//                   size: 23,
//                 ),
//               ),
//               if (widget.selected) ...[
//                 const SizedBox(width: 6),
//                 AnimatedDefaultTextStyle(
//                   duration: const Duration(milliseconds: 300),
//                   style: TextStyle(
//                     color: widget.color,
//                     fontFamily: FontFamily.globalFontFamily,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 12,
//                   ),
//                   child: Text(widget.label),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
