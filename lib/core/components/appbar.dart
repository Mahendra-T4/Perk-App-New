import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:go_router/go_router.dart';
import 'package:perk_app/assets/assets.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';
import 'package:perk_app/features/notifications/presentation/page/notification_panel.dart';
import 'package:perk_app/features/portfolio/presentation/page/portfolio.dart';
import 'package:perk_app/features/trade/presentation/page/trade.dart';

enum ProfileMenuOption {
  portfolio('Portfolio', Icons.wallet),
  orders('Orders', Icons.shopping_cart),
  clearMcxWishlist('Clear MCX Wishlist', Icons.delete_outline),
  clearNfoWishlist('Clear NFO Wishlist', Icons.delete_outline),
  trades('Trades', Icons.trending_up),
  rules('Rules', Icons.security),
  logout('Logout', Icons.logout);

  final String label;
  final IconData icon;

  const ProfileMenuOption(this.label, this.icon);
}

PreferredSizeWidget? customAppBar({
  required BuildContext context,
  required String title,
  bool showNotificationIcon = true,
}) {
  return AppBar(
    leading: _buildProfileMenuButton(context),
    title: CustomText(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: ColorTheme.primaryText,
      ),
    ),
    actions: [
      if (showNotificationIcon)
        IconButton(
          icon: Image.asset(Assets.notificationIcon, width: 30, height: 30),
          onPressed: () {
            // Handle notification icon tap
            GoRouter.of(context).pushNamed(NotificationPanel.routeName);
          },
        ),
    ],
  );
}

Widget _buildProfileMenuButton(BuildContext context) {
  return Center(
    child: InkWell(
      onTap: () {
        _showProfileMenu(context);
      },
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(Assets.appLogoPNG, width: 65, height: 65),
    ),
  );
}

void _showProfileMenu(BuildContext context) {
  final RenderBox renderBox = context.findRenderObject() as RenderBox;
  final Offset offset = renderBox.localToGlobal(Offset.zero);

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Close profile menu',
    barrierColor: Colors.black.withOpacity(0.3),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) {
      return _ProfileMenuPopup(offset: offset, context: context);
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        ),
        alignment: const Alignment(-0.9, -0.9),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
}

class _ProfileMenuPopup extends StatelessWidget {
  final Offset offset;
  final BuildContext context;

  const _ProfileMenuPopup({required this.offset, required this.context});

  void _handleMenuSelection(ProfileMenuOption option) {
    Navigator.of(context).pop();

    switch (option) {
      case ProfileMenuOption.portfolio:
        GoRouter.of(context).go(PortfolioPanel.routeName);
        break;
      case ProfileMenuOption.orders:
        // GoRouter.of(context).go(OrdersPanel.routeName); // Add your orders route
        break;
      case ProfileMenuOption.clearMcxWishlist:
        // Clear MCX wishlist
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('MCX Wishlist Cleared')));
        break;
      case ProfileMenuOption.clearNfoWishlist:
        // Clear NFO wishlist
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('NFO Wishlist Cleared')));
        break;
      case ProfileMenuOption.trades:
        GoRouter.of(context).go(TradePanel.routeName);
        break;
      case ProfileMenuOption.rules:
        // GoRouter.of(context).go(RulesPanel.routeName); // Add your rules route
        break;
      case ProfileMenuOption.logout:
        // Handle logout
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: offset.dx,
          top: offset.dy + 56,
          child: BuildMenuPopup(
            options: ProfileMenuOption.values,
            onOptionSelected: _handleMenuSelection,
          ),
        ),
      ],
    );
  }
}

class BuildMenuPopup extends StatefulWidget {
  final List<ProfileMenuOption> options;
  final Function(ProfileMenuOption) onOptionSelected;

  const BuildMenuPopup({required this.options, required this.onOptionSelected});

  @override
  State<BuildMenuPopup> createState() => _BuildMenuPopupState();
}

class _BuildMenuPopupState extends State<BuildMenuPopup> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E).withOpacity(0.92),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 40,
              offset: const Offset(0, 15),
              spreadRadius: 5,
            ),
            BoxShadow(
              color: Colors.blue.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 0),
            ),
          ],
          border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 14),
              itemCount: widget.options.length,
              separatorBuilder: (context, index) {
                if (widget.options[index] == ProfileMenuOption.logout) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: 1.2,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.white.withOpacity(0.08),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
              itemBuilder: (context, index) {
                final option = widget.options[index];
                final isLogout = option == ProfileMenuOption.logout;
                final isHovered = hoveredIndex == index;

                return MouseRegion(
                  onEnter: (_) => setState(() => hoveredIndex = index),
                  onExit: (_) => setState(() => hoveredIndex = null),
                  cursor: SystemMouseCursors.click,
                  child: InkWell(
                    onTap: () => widget.onOptionSelected(option),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: isHovered
                            ? (isLogout
                                  ? Colors.red.withOpacity(0.15)
                                  : Colors.blue.withOpacity(0.12))
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                        border: isHovered
                            ? Border.all(
                                color: isLogout
                                    ? Colors.red.withOpacity(0.3)
                                    : Colors.blue.withOpacity(0.3),
                                width: 1,
                              )
                            : null,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: isLogout
                                  ? Colors.red.withOpacity(0.15)
                                  : (isHovered
                                        ? Colors.blue.withOpacity(0.2)
                                        : Colors.grey.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(12),
                              border: isHovered
                                  ? Border.all(
                                      color: isLogout
                                          ? Colors.red.withOpacity(0.4)
                                          : Colors.blue.withOpacity(0.4),
                                      width: 1.2,
                                    )
                                  : null,
                            ),
                            child: Center(
                              child: AnimatedScale(
                                scale: isHovered ? 1.2 : 1.0,
                                duration: const Duration(milliseconds: 250),
                                child: Icon(
                                  option.icon,
                                  size: 22,
                                  color: isLogout
                                      ? Colors.red.shade400
                                      : (isHovered
                                            ? Colors.blue.shade300
                                            : Colors.grey.shade400),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 200),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: isHovered
                                        ? FontWeight.w700
                                        : FontWeight.w600,
                                    color: isLogout
                                        ? Colors.red.shade300
                                        : (isHovered
                                              ? Colors.blue.shade200
                                              : Colors.grey.shade100),
                                    letterSpacing: 0.4,
                                  ),
                                  child: Text(option.label),
                                ),
                              ],
                            ),
                          ),
                          if (isHovered)
                            AnimatedOpacity(
                              opacity: 1.0,
                              duration: const Duration(milliseconds: 200),
                              child: AnimatedSlide(
                                duration: const Duration(milliseconds: 250),
                                offset: isHovered
                                    ? const Offset(0.2, 0)
                                    : Offset.zero,
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 15,
                                  color: isLogout
                                      ? Colors.red.withOpacity(0.7)
                                      : Colors.blue.withOpacity(0.7),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
