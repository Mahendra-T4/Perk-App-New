import 'package:flutter/material.dart';
import 'package:perk_app/core/components/appbar.dart';
import 'package:perk_app/features/trade/presentation/page/active/active_trade.dart';
import 'package:perk_app/features/trade/presentation/page/closed/closed_trade.dart';
import 'package:perk_app/features/trade/presentation/page/pending/pendig_trade.dart';
import 'package:perk_app/features/watchlist/presentation/widgets/custom_tab_bar.dart';

class TradePanel extends StatefulWidget {
  const TradePanel({super.key, this.targetIndex});
  final int? targetIndex;
  static const String routeName = '/TradePanel';

  @override
  State<TradePanel> createState() => _TradePanelState();
}

class _TradePanelState extends State<TradePanel> with TickerProviderStateMixin {
  late TabController _tabController;
  int? _currentTabIndex;

  @override
  void initState() {
    super.initState();

    _currentTabIndex = widget.targetIndex ?? 0;

    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: _currentTabIndex!,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Trade'),
      body: Column(
        children: [
          CustomTabBar(
            tabs: const ['Active', 'Pending', 'Closed'],
            onTabChanged: (index) {
              _tabController.animateTo(index);
            },
            tabController: _tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ActiveTradePanel(),
                PendingTradePanel(),
                ClosedTradePanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
