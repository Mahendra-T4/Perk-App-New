import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perk_app/assets/assets.dart';
import 'package:perk_app/core/components/appbar.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';
import 'package:perk_app/features/user/presentation/widgets/account_setting_options.dart';
import 'package:perk_app/features/user/presentation/widgets/portfolio_profile_cart.dart';

class AccountSettingsPanel extends StatefulWidget {
  const AccountSettingsPanel({super.key});
  static const String routeName = '/account-settings';

  @override
  State<AccountSettingsPanel> createState() => _AccountSettingsPanelState();
}

class _AccountSettingsPanelState extends State<AccountSettingsPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Account Settings'),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorTheme.secondarySurface,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: ColorTheme.primaryColor.withOpacity(0.5),
                  ),
                ),
                child: ListTile(
                  leading: Image.asset(
                    Assets.userAccountIcon,
                    width: 54,
                    height: 54,
                  ),
                  title: CustomText(
                    'Demo User',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: ColorTheme.primaryText,
                  ),
                  subtitle: CustomText(
                    'demouser@gmail.com',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorTheme.secondaryText,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  PortfolioProfileCart(
                    item: ProfilePortfolioItem(
                      balance: 100000.00,
                      profitLoss: 100000.00,
                      active: 10,
                      closed: 10,
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 12)),
            AccountSettingOptions(),
            SliverToBoxAdapter(child: SizedBox(height: 12.h)),
          ],
        ),
      ),
    );
  }
}
