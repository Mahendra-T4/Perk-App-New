import 'package:flutter/material.dart';
import 'package:perk_app/assets/assets.dart';
import 'package:perk_app/core/components/appbar.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';
import 'package:perk_app/features/portfolio/presentation/page/active/active_portfolio.dart';
import 'package:perk_app/features/portfolio/presentation/page/closed/close_portfolio.dart';
import 'package:perk_app/features/watchlist/presentation/widgets/custom_tab_bar.dart';

class PortfolioPanel extends StatefulWidget {
  const PortfolioPanel({super.key});
  static const String routeName = '/PortfolioPanel';

  @override
  State<PortfolioPanel> createState() => _PortfolioPanelState();
}

class _PortfolioPanelState extends State<PortfolioPanel>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

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
      appBar: customAppBar(context: context, title: 'Portfolio'),
      body: Column(
        children: [
          CustomTabBar(
            tabController: _tabController,
            tabs: const ['Active', 'Closed'],
            onTabChanged: (index) {
              // setState(() {
              //   _currentTabIndex = index;
              //   _tabController.animateTo(index);
              // });
            },
            // initialIndex: _currentTabIndex,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // MCX Tab Content
                ActivePortfolio(),
                // NFO Tab Content
                ClosePortfolio(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
