import 'package:flutter/material.dart';
import 'package:perk_app/core/theme/color_theme.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> tabs;
  final TabController tabController;
  final Function(int) onTabChanged;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.tabController,
    required this.onTabChanged,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  late List<AnimationController> _tabAnimationControllers;

  @override
  void initState() {
    super.initState();
    _tabAnimationControllers = List.generate(
      widget.tabs.length,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      ),
    );

    // Only listen to animation, not tab changes (parent handles that)
    widget.tabController.addListener(_onTabChange);
  }

  void _onTabChange() {
    setState(() {
      if (!widget.tabController.indexIsChanging) {
        _tabAnimationControllers[widget.tabController.index].forward(from: 0.0);
      }
    });
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_onTabChange);
    for (var controller in _tabAnimationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorTheme.secondarySurface,
        boxShadow: [
          BoxShadow(
            color: ColorTheme.primaryColor.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TabBar(
        controller: widget.tabController,
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: ColorTheme.primaryText, width: 3),
          ),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        onTap: (index) {
          widget.onTabChanged(index);
        },
        tabs: List.generate(widget.tabs.length, (index) => _buildTab(index)),
      ),
    );
  }

  Widget _buildTab(int index) {
    bool isSelected = widget.tabController.index == index;

    return ScaleTransition(
      scale: Tween<double>(begin: 0.9, end: 1.0).animate(
        CurvedAnimation(
          parent: _tabAnimationControllers[index],
          curve: Curves.elasticOut,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          widget.tabController.animateTo(index);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: isSelected ? 1.1 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      fontSize: isSelected ? 16 : 14,
                      fontWeight: isSelected
                          ? FontWeight.w800
                          : FontWeight.w600,
                      color: isSelected
                          ? ColorTheme.primaryText
                          : ColorTheme.secondaryText,
                      letterSpacing: 0.5,
                    ),
                    child: Text(widget.tabs[index]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
