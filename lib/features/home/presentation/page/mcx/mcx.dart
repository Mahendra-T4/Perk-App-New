import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perk_app/core/utils/widget/searchfield.dart';
import 'package:perk_app/core/utils/widget/symbol_cart.dart';
import 'package:perk_app/features/home/presentation/page/mcx/symbol/mcx_symbol.dart';

class MCXPanel extends StatefulWidget {
  const MCXPanel({super.key});
  static const String routeName = '/mcx-panel';

  @override
  State<MCXPanel> createState() => _MCXPanelState();
}

class _MCXPanelState extends State<MCXPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: HeaderSearchBar(),
            ),
            // SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 12),
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SymbolCartTile(
                    onTap: () => GoRouter.of(
                      context,
                    ).pushNamed(McxSymbolPanel.routeName),
                    symbolName: 'COPPER',
                    expiryDate: '2026-12-31',
                    sellPrice: '450.25',
                    buyPrice: '455.75',
                    change: '19.65',
                    lastPrice: '452.50',
                    high: '458.25',
                    low: '448.00',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
