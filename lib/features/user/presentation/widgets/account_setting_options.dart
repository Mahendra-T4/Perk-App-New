import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/features/user/data/source/profile_option_data.dart';

class AccountSettingOptions extends StatelessWidget {
  const AccountSettingOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: profileContents.length,
      itemBuilder: (context, index) {
        final option = profileContents[index];
        return _SettingOptionCard(option: option, context: context);
      },
    );
  }
}

class _SettingOptionCard extends StatefulWidget {
  final ProfileOptionData option;
  final BuildContext context;

  const _SettingOptionCard({required this.option, required this.context});

  @override
  State<_SettingOptionCard> createState() => _SettingOptionCardState();
}

class _SettingOptionCardState extends State<_SettingOptionCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHoverChange(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHoverChange(true),
      onExit: (_) => _onHoverChange(false),
      child: GestureDetector(
        onTap: () {
          if (widget.option.routeName != null &&
              widget.option.routeName!.isNotEmpty) {
            GoRouter.of(
              widget.context,
            ).pushNamed(widget.option.routeName.toString());
          } else if (widget.option.onTap != null) {
            widget.option.onTap!(widget.context);
          }
        },
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                if (_isHovered)
                  BoxShadow(
                    color: ColorTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  )
                else
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorTheme.secondarySurface,
                    ColorTheme.secondarySurface.withOpacity(0.7),
                  ],
                ),
                border: Border.all(
                  color: _isHovered
                      ? ColorTheme.primaryColor.withOpacity(0.6)
                      : ColorTheme.primaryColor.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        // Icon with background
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                ColorTheme.primaryColor.withOpacity(0.2),
                                ColorTheme.primaryColor.withOpacity(0.05),
                              ],
                            ),
                            border: Border.all(
                              color: ColorTheme.primaryColor.withOpacity(0.3),
                            ),
                          ),
                          child: Icon(
                            widget.option.icon,
                            color: ColorTheme.primaryColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Title
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.option.title,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: ColorTheme.primaryText,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        // Chevron icon
                        Icon(
                          Icons.chevron_right_rounded,
                          color: ColorTheme.primaryColor.withOpacity(
                            _isHovered ? 1.0 : 0.6,
                          ),
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
