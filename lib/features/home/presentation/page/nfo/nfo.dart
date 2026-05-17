import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perk_app/core/utils/widget/searchfield.dart';
import 'package:perk_app/core/utils/widget/symbol_cart.dart';
import 'package:perk_app/features/home/presentation/page/nfo/symbol/nfo_symbol.dart';

class NFOPanel extends StatefulWidget {
  const NFOPanel({super.key});
  static const String routeName = '/nfo-panel';

  @override
  State<NFOPanel> createState() => _NFOPanelState();
}

class _NFOPanelState extends State<NFOPanel> {
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
                    onTap: () {
                      GoRouter.of(context).push(NFOSymbolPanel.routeName);
                    },
                    symbolName: 'ABB INDIA LIMITED',
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
