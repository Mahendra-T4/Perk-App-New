import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' show sin, cos;
import 'package:perk_app/assets/assets.dart';
import 'package:perk_app/core/theme/color_theme.dart';
import 'package:perk_app/core/utils/widget/text.dart';
import 'package:perk_app/features/auth/presentation/page/login/sign_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _floatController;
  late AnimationController _rotateController;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _titleSlide;
  late Animation<double> _shimmer;
  late Animation<double> _progressAnimation;
  late Animation<double> _floatAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // Floating animation
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // Rotating animation
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    // Logo scale and opacity animation
    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack),
      ),
    );

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    // Title slide animation
    _titleSlide = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _mainController,
            curve: const Interval(0.2, 0.5, curve: Curves.easeOutCubic),
          ),
        );

    // Shimmer animation
    _shimmer = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.3, 1.0, curve: Curves.linear),
      ),
    );

    // Progress animation
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Float animation
    _floatAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Rotate animation
    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _rotateController, curve: Curves.linear));

    _mainController.forward();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 4), () {
        if (mounted) {
          GoRouter.of(context).goNamed(SignInPage.routeName);
        }
      });
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _floatController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _mainController,
          _floatController,
          _rotateController,
        ]),
        builder: (context, child) {
          // Float offset
          final floatOffset = Tween<double>(begin: -20, end: 20).evaluate(
            CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
          );

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF05070F),
                  const Color(0xFF5465ff).withOpacity(0.8),
                  const Color(0xFF1A2338),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 0.5, 1],
              ),
            ),
            child: Stack(
              children: [
                // Animated background particles
                _buildAnimatedParticles(),

                // Main Content
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Logo Container
                    FadeTransition(
                      opacity: _logoOpacity,
                      child: Transform.translate(
                        offset: Offset(0, floatOffset),
                        child: ScaleTransition(
                          scale: _logoScale,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Rotating outer ring
                              Transform.rotate(
                                angle: _rotateAnimation.value * 2 * 3.14159,
                                child: Container(
                                  width: 260,
                                  height: 260,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(
                                        0xFF56CCF2,
                                      ).withOpacity(0.15 * _logoOpacity.value),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),

                              // Animated glow background
                              Container(
                                width: 220,
                                height: 220,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      const Color(
                                        0xFF56CCF2,
                                      ).withOpacity(0.4 * _logoOpacity.value),
                                      const Color(
                                        0xFF2F80ED,
                                      ).withOpacity(0.1 * _logoOpacity.value),
                                    ],
                                  ),
                                ),
                              ),

                              // Animated border circle
                              Container(
                                width: 220,
                                height: 220,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF56CCF2).withOpacity(
                                      0.3 *
                                          (0.5 +
                                              0.5 *
                                                  Curves.easeInOut.transform(
                                                    _logoOpacity.value,
                                                  )),
                                    ),
                                    width: 2,
                                  ),
                                ),
                              ),

                              // Logo Container
                              Container(
                                clipBehavior: Clip.antiAlias,
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFF56CCF2,
                                      ).withOpacity(0.6),
                                      blurRadius: 40,
                                      spreadRadius: 8,
                                    ),
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 20,
                                      offset: const Offset(0, 15),
                                    ),
                                  ],
                                  gradient: const LinearGradient(
                                    colors: [
                                      ColorTheme.surface,
                                      ColorTheme.secondarySurface,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    Assets.appLogoPNG,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Animated Title with Shimmer
                    SlideTransition(
                      position: _titleSlide,
                      child: Column(
                        children: [
                          // Main Title
                          ShimmerText(
                            text: 'Perk',
                            shimmerProgress: _shimmer.value,
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 3,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Tagline animation
                          FadeTransition(
                            opacity: Tween<double>(begin: 0, end: 1).animate(
                              CurvedAnimation(
                                parent: _mainController,
                                curve: const Interval(
                                  0.25,
                                  0.5,
                                  curve: Curves.easeIn,
                                ),
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF56CCF2).withOpacity(0.1),
                                    const Color(0xFF2F80ED).withOpacity(0.05),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(
                                    0xFF56CCF2,
                                  ).withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'Trading Made Simple',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(0.8),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Subtitle
                          FadeTransition(
                            opacity: Tween<double>(begin: 0, end: 1).animate(
                              CurvedAnimation(
                                parent: _mainController,
                                curve: const Interval(
                                  0.35,
                                  0.65,
                                  curve: Curves.easeIn,
                                ),
                              ),
                            ),
                            child: CustomText(
                              'Your Smart Trading Assistant',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.75),
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const Spacer(),

                    // Modern Progress Indicator
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          // Animated Progress Bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.1),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: LinearProgressIndicator(
                                value: _progressAnimation.value,
                                minHeight: 8,
                                backgroundColor: Colors.white.withOpacity(0.08),
                                valueColor: AlwaysStoppedAnimation(
                                  Color.lerp(
                                    const Color(0xFF56CCF2),
                                    const Color(0xFF2F80ED),
                                    _progressAnimation.value,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Loading percentage
                          FadeTransition(
                            opacity: Tween<double>(begin: 0, end: 1).animate(
                              CurvedAnimation(
                                parent: _mainController,
                                curve: const Interval(
                                  0.55,
                                  0.85,
                                  curve: Curves.easeIn,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${(_progressAnimation.value * 100).toStringAsFixed(0)}%',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF56CCF2),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Initializing...',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(0.7),
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Animated background particles
  Widget _buildAnimatedParticles() {
    return Positioned.fill(
      child: CustomPaint(
        painter: _ParticlesPainter(progress: _mainController.value),
      ),
    );
  }
}

// Custom Shimmer Text Widget
class ShimmerText extends StatelessWidget {
  final String text;
  final double shimmerProgress;
  final TextStyle style;

  const ShimmerText({
    required this.text,
    required this.shimmerProgress,
    required this.style,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [
            Colors.white.withOpacity(0.3),
            Colors.white,
            Colors.white.withOpacity(0.3),
          ],
          stops: [
            0,
            shimmerProgress.clamp(0, 1),
            (shimmerProgress + 0.3).clamp(0, 1),
          ],
          begin: const Alignment(-2, 0),
          end: const Alignment(2, 0),
        ).createShader(bounds);
      },
      child: Text(text, style: style),
    );
  }
}

// Particles painter
class _ParticlesPainter extends CustomPainter {
  final double progress;

  _ParticlesPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF56CCF2).withOpacity(0.1)
      ..strokeWidth = 1;

    // Draw subtle animated particles
    for (int i = 0; i < 5; i++) {
      final x = (size.width * 0.2) * (i + 1);
      final y = size.height * 0.3 + (sin(progress * 2 + i) * 20);

      canvas.drawCircle(Offset(x, y), 2, paint);
    }

    // Draw particles on right side
    for (int i = 0; i < 5; i++) {
      final x = size.width - (size.width * 0.2) * (i + 1);
      final y = size.height * 0.7 + (cos(progress * 2 + i) * 20);

      canvas.drawCircle(Offset(x, y), 2, paint);
    }
  }

  @override
  bool shouldRepaint(_ParticlesPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
