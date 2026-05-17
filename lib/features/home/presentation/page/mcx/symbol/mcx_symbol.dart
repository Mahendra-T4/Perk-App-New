import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:perk_app/assets/assets.dart';
import 'package:perk_app/core/components/appbar.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/utils.dart';
import 'package:perk_app/core/utils/widget/symbol_button.dart';
import 'package:perk_app/core/utils/widget/symbol_popup.dart';
import 'package:perk_app/features/home/presentation/page/mcx/symbol/mcx_symbol_builder.dart';

class McxSymbolPanel extends StatefulWidget {
  const McxSymbolPanel({super.key});
  static const String routeName = '/mcx-symbol';

  @override
  State<McxSymbolPanel> createState() => _McxSymbolPanelState();
}

class _McxSymbolPanelState extends McxSymbolBuilder
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    // Sync controller with notifier when notifier changes
    lotsNotifierMrk.addListener(_updateLotsController);
  }

  void _updateLotsController() {
    lotsMktController.text = lotsNotifierMrk.value.toString();
  }

  @override
  void dispose() {
    lotsNotifierMrk.removeListener(_updateLotsController);
    tabController.dispose();
    lotsMktController.dispose();
    lotsOdrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Copper'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: CustomScrollView(
                slivers: [
                  // SizedBox(height: 12.h),
                  selectedTab == 0
                      ? SliverToBoxAdapter(
                          child: inputTile(
                            controller: lotsMktController,
                            valueListenable: lotsNotifierMrk,
                          ),
                        )
                      : SliverToBoxAdapter(
                          child: Column(
                            spacing: 12,
                            children: [
                              inputTile(
                                controller: lotsOdrController,
                                valueListenable: lotsNotifierOrder,
                              ),
                              amountField,
                            ],
                          ),
                        ),
                  SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverToBoxAdapter(
                    child: SymbolBuySellButton(
                      onSellTap: () {
                        showSellBuySuccessDialog(
                          context: context,
                          title: 'Sell Copper',
                          content: 'Are you sure you want to sell Copper?',

                          assets: Assets.loadingAnimation,
                        );
                      },
                      onBuyTap: () {
                        showSellBuyFailedDialog(
                          context: context,
                          title: 'Buy Copper',
                          content: 'Are you sure you want to buy Copper?',

                          assets: Assets.failedAnimation,
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverFillRemaining(child: buildDetailsBox()),
                ],
              ),
            ),
            tabBar,
          ],
        ),
      ),

      // TabBarView
    );
  }
}
