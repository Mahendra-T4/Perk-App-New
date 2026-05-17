import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';
import 'package:perk_app/assets/assets.dart';
import 'package:perk_app/core/constants/font_family.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/custom_button.dart';
import 'package:perk_app/core/utils/widget/custom_tf.dart';
import 'package:perk_app/features/watchlist/presentation/pages/watchlist.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  static const String routeName = '/sign-in';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  late AnimationController _particleController;

  @override
  void initState() {
    super.initState();
    _particleController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  void _signIn() async {
    GoRouter.of(context).goNamed(WatchList.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Modern Animated Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [const Color(0xFF0a0e27), const Color(0xFF1a1f3a)],
              ),
            ),
            child: AnimatedBuilder(
              animation: _particleController,
              builder: (context, child) {
                return CustomPaint(
                  painter: ModernMeshPainter(_particleController.value),
                  isComplex: true,
                  willChange: true,
                );
              },
            ),
          ),
          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  // Modern Logo Container
                  Container(
                    width: 150,
                    height: 150,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Image.asset(Assets.appLogoJPEG, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 24),
                  // Main form container
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcoming texts
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: ColorTheme.primaryText,
                            letterSpacing: 0.5,
                          ),
                        ),
                        // const SizedBox(height: 10),
                        Text(
                          'Sign in to your trading account',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: ColorTheme.secondaryText,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Email field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email Address',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: ColorTheme.primaryText,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.text,
                              hintText: 'Enter User ID',
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: ColorTheme.primaryColor,
                                size: 20,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              style: const TextStyle(
                                color: ColorTheme.primaryText,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Password field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: ColorTheme.primaryText,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: ColorTheme.primaryColor,
                                size: 20,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: ColorTheme.primaryColor,
                                  size: 20,
                                ),
                                onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                              ),
                              hintText: 'Enter your password',
                              style: TextStyle(
                                color: ColorTheme.primaryText,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 36),
                        // Sign In button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: CustomButton(
                            label: 'Sign In',
                            onPressed: _isLoading ? null : _signIn,
                            isLoading: _isLoading,
                            gradient: LinearGradient(
                              colors: [
                                ColorTheme.primaryColor,
                                Color(0xFF56CCF2),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 34),

                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: ColorTheme.secondarySurface,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.grey[800]!,
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 4,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF56CCF2),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Disclaimer',
                                    style: TextStyle(
                                      color: ColorTheme.primaryText,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: FontFamily.globalFontFamily,
                                      fontSize: 13,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'No real money involved. This is a virtual trading application with full trading features.',
                                style: TextStyle(
                                  color: ColorTheme.secondaryText,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.globalFontFamily,
                                  fontSize: 12,
                                  height: 1.6,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'This application is used for exchanging views on market for trading purposes only.',
                                style: TextStyle(
                                  color: ColorTheme.secondaryText,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.globalFontFamily,
                                  fontSize: 12,
                                  height: 1.6,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'The Perk is not liable for any real money transaction. We do not deal in real money.',
                                style: TextStyle(
                                  color: ColorTheme.secondaryText,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.globalFontFamily,
                                  fontSize: 12,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ModernMeshPainter extends CustomPainter {
  final double animationValue;

  ModernMeshPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    // Guard against invalid size
    if (!size.isFinite || size.width <= 0 || size.height <= 0) {
      return;
    }

    final paint = Paint()
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Draw a simple animated background
    const gridSize = 80.0;
    final cols = (size.width / gridSize).ceil() + 2;
    final rows = (size.height / gridSize).ceil() + 2;

    List<Offset> points = [];

    // Generate grid points with bounds checking
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        final x = (i * gridSize - gridSize / 2).toDouble();
        final y = (j * gridSize - gridSize / 2).toDouble();

        // Add wave animation to points
        final waveX =
            sin(
              (animationValue * 2 * pi) +
                  (x.clamp(0, size.width) / size.width) * pi,
            ) *
            15;
        final waveY =
            cos(
              (animationValue * 2 * pi) +
                  (y.clamp(0, size.height) / size.height) * pi,
            ) *
            15;

        final newX = x + waveX;
        final newY = y + waveY;

        // Only add points that are finite
        if (newX.isFinite && newY.isFinite) {
          points.add(Offset(newX, newY));
        }
      }
    }

    if (points.isEmpty) return;

    // Draw connecting lines
    for (int i = 0; i < cols - 1; i++) {
      for (int j = 0; j < rows - 1; j++) {
        final idx1 = i * rows + j;
        final idx2 = (i + 1) * rows + j;
        final idx3 = i * rows + (j + 1);

        if (idx1 < points.length && idx2 < points.length) {
          final p1 = points[idx1];
          final p2 = points[idx2];

          if (p1.dx.isFinite &&
              p1.dy.isFinite &&
              p2.dx.isFinite &&
              p2.dy.isFinite) {
            final distance = (p1 - p2).distance;
            final opacity = (1 - (distance / 100)) * 0.4;

            paint.color = const Color(
              0xFF56CCF2,
            ).withOpacity(opacity.clamp(0, 0.4));
            canvas.drawLine(p1, p2, paint);
          }
        }

        if (idx1 < points.length && idx3 < points.length) {
          final p1 = points[idx1];
          final p3 = points[idx3];

          if (p1.dx.isFinite &&
              p1.dy.isFinite &&
              p3.dx.isFinite &&
              p3.dy.isFinite) {
            final distance = (p1 - p3).distance;
            final opacity = (1 - (distance / 100)) * 0.4;

            paint.color = const Color(
              0xFF2D82F5,
            ).withOpacity(opacity.clamp(0, 0.4));
            canvas.drawLine(p1, p3, paint);
          }
        }
      }
    }

    // Draw nodes
    final nodePaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      final pulse = sin((animationValue * 2 * pi) + (i * 0.5)) * 0.5 + 0.5;
      final radius = (2 + (pulse * 1.5)).clamp(0.5, 5.0);
      final point = points[i];

      if (point.dx.isFinite && point.dy.isFinite && radius.isFinite) {
        if (i % 2 == 0) {
          nodePaint.color = const Color(
            0xFF56CCF2,
          ).withOpacity(0.6 + (pulse * 0.4));
        } else {
          nodePaint.color = const Color(
            0xFF2D82F5,
          ).withOpacity(0.4 + (pulse * 0.3));
        }

        try {
          canvas.drawCircle(point, radius, nodePaint);
        } catch (e) {
          // Silently skip if drawing fails
        }
      }
    }

    // Draw particles with safe positioning
    final particlePaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < 20; i++) {
      final randomSeed = i * 0.5;
      final sinVal = sin(randomSeed + animationValue);
      final cosVal = cos(randomSeed + animationValue * 1.3);

      final x = ((sinVal + 1) / 2) * size.width;
      final y = ((cosVal + 1) / 2) * size.height;

      if (x.isFinite && y.isFinite) {
        particlePaint.color = const Color(0xFF56CCF2).withOpacity(
          (sin((animationValue * 2 * pi) + randomSeed) * 0.3 + 0.2).clamp(0, 1),
        );

        try {
          canvas.drawCircle(Offset(x, y), 1.5, particlePaint);
        } catch (e) {
          // Silently skip if drawing fails
        }
      }
    }
  }

  @override
  bool shouldRepaint(ModernMeshPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
