import 'package:flutter/material.dart';
import 'package:perk_app/core/components/appbar.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';
import 'package:perk_app/features/user/presentation/widgets/nse_enabled_widget.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});
  static const String routeName = '/user-profile';

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Profile'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          spacing: 16,
          children: [
            NSEEnabled(
              brokerage: 50000,
              marginIntraday: 50000,
              marginHolding: 100,
            ),
          ],
        ),
      ),
    );
  }
}
