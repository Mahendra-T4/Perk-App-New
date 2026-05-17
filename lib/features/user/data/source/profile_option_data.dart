import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perk_app/features/auth/presentation/page/change-password/change_password.dart';
import 'package:perk_app/features/user/presentation/pages/complaint/ledge_compaint.dart';
import 'package:perk_app/features/user/presentation/pages/ledger/ledger_report.dart';
import 'package:perk_app/features/user/presentation/pages/payment/payment.dart';
import 'package:perk_app/features/user/presentation/pages/profile/user_profile.dart';
import 'package:perk_app/features/user/presentation/pages/wallet/user_wallet.dart';
import 'package:perk_app/features/user/presentation/pages/withdraw/withdraw.dart';
import 'package:perk_app/features/user/presentation/widgets/logout_pop.dart';

class ProfileOptionData {
  final IconData icon;
  final String title;
  final String? routeName;
  final Function(BuildContext)? onTap;

  ProfileOptionData({
    required this.icon,
    required this.title,
    this.routeName,
    this.onTap,
  });
}

final List<ProfileOptionData> profileContents = [
  ProfileOptionData(
    icon: Icons.person_rounded,
    title: 'Profile',
    routeName: UserProfile.routeName,
  ),
  ProfileOptionData(
    icon: Icons.money_off_rounded,
    title: 'Withdraw',
    routeName: WithdrawPanel.routeName,
  ),
  ProfileOptionData(
    icon: Icons.account_balance_wallet_rounded,
    title: 'Wallet',
    routeName: WalletPanel.routeName,
  ),
  ProfileOptionData(
    icon: Icons.receipt_long_rounded,
    title: 'Ledger Report',
    routeName: LedgerReport.routeName,
  ),
  ProfileOptionData(
    icon: Icons.payment_rounded,
    title: 'Payment',
    routeName: PaymentScreen.routeName,
  ),

  ProfileOptionData(
    icon: Icons.report_problem_rounded,
    title: 'Ledge Complaint',
    routeName: LedgeComplaint.routeName,
  ),

  ProfileOptionData(
    icon: Icons.lock_reset_rounded,
    title: 'Change Password',
    routeName: ChangePasswordPanel.routeName,
  ),

  ProfileOptionData(
    icon: Icons.logout_rounded,
    title: 'Logout',
    onTap: (context) {
      showLogoutConfirmationDialog(context);
    },
  ),
];
