import 'package:flutter/material.dart';

import 'package:perk_app/core/components/appbar.dart';
import 'package:perk_app/features/watchlist/presentation/pages/mcx/mcx_watchlist.dart';
import 'package:perk_app/features/watchlist/presentation/pages/nfo/nfo_watchlist.dart';
import 'package:perk_app/features/watchlist/presentation/widgets/custom_tab_bar.dart';

class WatchList extends StatefulWidget {
  const WatchList({super.key});
  static const String routeName = '/watchlist';

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'WatchList'),
      body: Column(
        children: [
          CustomTabBar(
            tabs: const ['MCX', 'NFO'],
            tabController: _tabController,
            onTabChanged: (index) {
              // Tab change is automatically handled by TabController
              // This callback can be used for analytics or additional logic
            },
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // MCX Tab Content
                McxWatchList(),
                // NFO Tab Content
                NFOWatchList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
