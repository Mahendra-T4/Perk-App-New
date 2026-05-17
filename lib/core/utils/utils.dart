import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';

class Utils {
  static String formatNumber(dynamic v) {
    if (v == null) return '0.00';
    if (v is double) return v.toStringAsFixed(2);
    if (v is int) return v.toString();
    return double.tryParse(v.toString())?.toStringAsFixed(2) ?? v.toString();
  }

  static void showAlertBox({
    required BuildContext context,
    required String assets,
    required String title,
    required String content,

    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Center(
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: ModalRoute.of(context)!.animation!,
                curve: Curves.easeOutBack,
              ),
              child: Container(
                width: 340,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorTheme.secondarySurface,
                      ColorTheme.secondarySurface.withOpacity(0.95),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 30,
                      spreadRadius: 8,
                      offset: const Offset(0, 15),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 36,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOut,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.scale(
                            scale: 0.7 + (value * 0.3),
                            child: Transform.rotate(
                              angle: value * 0.3,
                              child: child,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ColorTheme.primaryColor.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Lottie.asset(
                          assets,
                          width: 140,
                          height: 140,
                          repeat: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    CustomText(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomText(
                      content,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500],
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildPremiumButton(
                          label: 'Cancel',
                          onPressed: () => Navigator.pop(context),
                          isPrimary: false,
                        ),
                        const SizedBox(width: 12),
                        _buildPremiumButton(
                          label: 'Confirm',
                          onPressed: () {
                            onConfirm?.call();
                            Navigator.pop(context);
                          },
                          isPrimary: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildPremiumButton({
    required String label,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(14),
          splashColor: isPrimary
              ? Colors.white.withOpacity(0.2)
              : ColorTheme.primaryColor.withOpacity(0.1),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: isPrimary
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        ColorTheme.primaryColor.withOpacity(0.95),
                        ColorTheme.primaryColor,
                      ],
                    )
                  : LinearGradient(
                      colors: [
                        Colors.grey[300]!.withOpacity(0.5),
                        Colors.grey[300]!.withOpacity(0.3),
                      ],
                    ),
              border: isPrimary
                  ? Border.all(color: Colors.white.withOpacity(0.2), width: 1)
                  : null,
              boxShadow: isPrimary
                  ? [
                      BoxShadow(
                        color: ColorTheme.primaryColor.withOpacity(0.35),
                        blurRadius: 12,
                        spreadRadius: 1,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
            ),
            child: CustomText(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isPrimary ? Colors.white : Colors.grey[700],
                letterSpacing: 0.4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
