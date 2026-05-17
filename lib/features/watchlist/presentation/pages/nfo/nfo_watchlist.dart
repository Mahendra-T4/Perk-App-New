import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perk_app/core/utils/widget/searchfield.dart';
import 'package:perk_app/core/utils/widget/symbol_cart.dart';
import 'package:perk_app/features/home/presentation/page/nfo/nfo.dart';
import 'package:perk_app/features/home/presentation/page/nfo/symbol/nfo_symbol.dart';

class NFOWatchList extends StatefulWidget {
  const NFOWatchList({super.key});

  @override
  State<NFOWatchList> createState() => _NFOWatchListState();
}

class _NFOWatchListState extends State<NFOWatchList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: HeaderSearchBar(
              isReadOnly: true,
              onTap: () => GoRouter.of(context).pushNamed(NFOPanel.routeName),
            ),
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
                  sellPrice: '6176.25',
                  buyPrice: '6179.75',
                  change: '-50.65',
                  lastPrice: '6179.75',
                  high: '6420.25',
                  low: '448.00',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
