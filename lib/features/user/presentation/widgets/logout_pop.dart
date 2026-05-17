// Modern & Beautiful Logout Confirmation Dialog
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui' as ui;

Future<bool?> showLogoutConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.3),
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: ScaleTransition(
            scale: AlwaysStoppedAnimation(1.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.white.withOpacity(0.98)],
                ),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Color(0xFFDC2626).withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated Icon Container
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 600),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFDC2626).withOpacity(0.12),
                                Color(0xFFFF8C42).withOpacity(0.08),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Color(0xFFDC2626).withOpacity(0.15),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.logout_rounded,
                            size: 40,
                            color: Color(0xFFDC2626),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 28),

                  // Title with enhanced typography
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Colors.black87, Colors.black54],
                    ).createShader(bounds),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Subtle separator
                  Container(
                    height: 1,
                    width: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Color(0xFFDC2626).withOpacity(0.4),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Enhanced message
                  Text(
                    'Are you sure you want to logout?\nYou\'ll need to log in again to access your account.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                      height: 1.6,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Modern Action Buttons
                  Row(
                    children: [
                      // Cancel Button - Modern Design
                      Expanded(
                        child: _buildModernButton(
                          label: 'Cancel',
                          onTap: () => context.pop(),
                          isPrimary: false,
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Logout Button - Modern Design
                      Expanded(
                        child: _buildModernButton(
                          label: 'Logout',
                          onTap: () => Navigator.pop(context, true),
                          isPrimary: true,
                        ),
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

// Modern Button Widget
Widget _buildModernButton({
  required String label,
  required VoidCallback onTap,
  required bool isPrimary,
}) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: isPrimary
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFDC2626), Color(0xFFFF8C42)],
                )
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey.withOpacity(0.08),
                    Colors.grey.withOpacity(0.04),
                  ],
                ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isPrimary
                ? Colors.transparent
                : Colors.grey.withOpacity(0.15),
            width: 1.5,
          ),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: Color(0xFFDC2626).withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                    spreadRadius: 0,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: isPrimary ? Colors.white : Colors.black87,
            letterSpacing: 0.5,
          ),
        ),
      ),
    ),
  );
}
