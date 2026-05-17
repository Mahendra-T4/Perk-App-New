import 'package:flutter/material.dart';
import 'package:perk_app/core/components/appbar.dart';
import 'package:perk_app/core/utils/widget/symbol_button.dart';
import 'package:perk_app/features/home/presentation/page/mcx/symbol/mcx_symbol_builder.dart';
import 'package:perk_app/features/home/presentation/page/nfo/symbol/nfo_symbol_builder.dart';

class NFOSymbolPanel extends StatefulWidget {
  const NFOSymbolPanel({super.key});
  static const String routeName = '/nfo-symbol';

  @override
  State<NFOSymbolPanel> createState() => _NFOSymbolPanelState();
}

class _NFOSymbolPanelState extends NFOSymbolBuilder
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
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
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
                  SliverToBoxAdapter(child: SymbolBuySellButton()),
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
