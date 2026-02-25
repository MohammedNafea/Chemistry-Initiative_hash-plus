import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:chemistry_initiative/features/auth/presentation/widgets/auth_guard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _loopController;

  late Animation<double> _textOpacity;
  late Animation<double> _textSlide;
  late Animation<double> _blurIn;

  final List<CinematicParticle> _particles = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    }

    // One-shot entrance/exit controller
    _mainController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Continuous loop controller for organic movement
    _loopController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();

    // Initialize "Cinematic" Particles (Depth of Field)
    final particleCount = kIsWeb ? 10 : 35; // Significant reduction for web memory
    for (int i = 0; i < particleCount; i++) {
      _particles.add(CinematicParticle(_random));
    }

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );

    _textSlide = Tween<double>(begin: 40.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    // Initial blur fade-in for "Focus" effect
    _blurIn = Tween<double>(begin: 10.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    _startSequence();
  }

  void _startSequence() async {
    await _mainController.forward();

    // Smooth transition out
    if (mounted) {
      await Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const AuthGuard(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 1000),
        ),
      );
      if (!kIsWeb) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      }
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _loopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A120B), // Very deep brown/black
      body: AnimatedBuilder(
        animation: Listenable.merge([_mainController, _loopController]),
        builder: (context, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // 1. Dynamic Moving Background Gradient (Simulates shifting light)
              Positioned.fill(
                child: CustomPaint(
                  painter: BackgroundLightPainter(_loopController.value),
                ),
              ),

              // 2. Background/Blurred Particles (Far away)
              CustomPaint(
                painter: CinematicParticlePainter(
                  particles: _particles.where((p) => p.z < 0.5).toList(),
                  animationValue: _loopController.value,
                  blurAmount: 3.0, // Blurry background
                ),
              ),

              // 3. Main Centerpiece (Molecule)
              Center(
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(seconds: 2),
                  tween: Tween(begin: 0.9, end: 1.0),
                  curve: Curves.easeOutBack,
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale:
                          scale +
                          (math.sin(_loopController.value * math.pi * 2) *
                              0.02), // Breathe
                      child: CustomPaint(
                        size: const Size(220, 220),
                        painter: UltraPremiumMoleculePainter(
                          rotation: _loopController.value * math.pi * 2,
                          lightAngle: _loopController.value * math.pi * 2,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 4. Foreground Particles (Close, slightly out of focus or sharp)
              CustomPaint(
                painter: CinematicParticlePainter(
                  particles: _particles.where((p) => p.z >= 0.5).toList(),
                  animationValue: _loopController.value,
                  blurAmount: 0.0,
                ),
              ),

              // 5. Cinematic Vignette (Dark edges)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      radius: 1.5,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.8),
                      ],
                      stops: const [0.5, 0.8, 1.0],
                    ),
                  ),
                ),
              ),

              // 6. Text with "Cinematic Reveal"
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.25,
                left: 0,
                right: 0,
                child: Opacity(
                  opacity: _textOpacity.value,
                  child: Transform.translate(
                    offset: Offset(0, _textSlide.value),
                    child: Column(
                      children: [
                        // Main Title
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              Color(0xFFC6A664), // Dark Gold
                              Color(0xFFFFE5B4), // Pale Gold highlight
                              Color(0xFFC6A664), // Dark Gold
                            ],
                            begin: Alignment(-1.0, -1.0),
                            end: Alignment(1.0, 1.0),
                            stops: [0.0, 0.5, 1.0],
                          ).createShader(bounds),
                          child: const Text(
                            'عجائب الكيمياء',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.0,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Subtitle/Separator Line
                        Container(
                          width: 40,
                          height: 1,
                          color: const Color(0xFFC6A664).withOpacity(0.6),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 7. Overall Entrance Blur (Focus Pull)
              if (_blurIn.value > 0.1)
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: _blurIn.value,
                    sigmaY: _blurIn.value,
                  ),
                  child: Container(color: Colors.transparent),
                ),
            ],
          );
        },
      ),
    );
  }
}

// --- Cinematic Painters ---

class BackgroundLightPainter extends CustomPainter {
  final double animation;
  BackgroundLightPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    // Moving light beam

    // Dynamic gradient center based on animation
    final dx = math.sin(animation * math.pi * 2) * 50;
    final dy = math.cos(animation * math.pi * 2) * 50;

    final paint = Paint()
      ..shader = RadialGradient(
        center: Alignment(0.0 + (dx / size.width), -0.2 + (dy / size.height)),
        radius: 1.4,
        colors: [
          const Color(0xFF5D4037).withOpacity(0.8), // Warm light
          const Color(0xFF2D1B15), // Deep chocolate
          const Color(0xFF0F0806), // Near black
        ],
        stops: const [0.0, 0.4, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant BackgroundLightPainter old) => true;
}

class CinematicParticle {
  late double x, y, z; // z for depth (0-1)
  late double speed;
  late double noiseOffset;

  CinematicParticle(math.Random random) {
    reset(random, true);
  }

  void reset(math.Random random, [bool init = false]) {
    x = random.nextDouble();
    y = init ? random.nextDouble() : 1.1;
    z = random.nextDouble(); // Depth: 0=Far, 1=Near
    speed = random.nextDouble() * 0.05 + 0.02;
    noiseOffset = random.nextDouble() * 100;
  }
}

class CinematicParticlePainter extends CustomPainter {
  final List<CinematicParticle> particles;
  final double animationValue;
  final double blurAmount;

  CinematicParticlePainter({
    required this.particles,
    required this.animationValue,
    required this.blurAmount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      // Move up with some horizontal noise
      double currentY = p.y - (animationValue * p.speed * 10);
      currentY = currentY % 1.2; // Loop
      if (currentY < -0.1) currentY = 1.1;

      double sway =
          math.sin(animationValue * math.pi * 2 + p.noiseOffset) * 0.05 * p.z;

      final pos = Offset((p.x + sway) * size.width, currentY * size.height);

      // Depth effects
      final radius = (p.z * 3.0) + 1.0; // Nearer = Larger
      final opacity = 0.3 + (p.z * 0.4); // Nearer = Brighter

      final paint = Paint()
        ..color = const Color(0xFFFFD700).withOpacity(opacity)
        ..style = PaintingStyle.fill;

      if (blurAmount > 0 && !kIsWeb) {
        paint.maskFilter = MaskFilter.blur(BlurStyle.normal, blurAmount);
      }

      canvas.drawCircle(pos, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}

class UltraPremiumMoleculePainter extends CustomPainter {
  final double rotation;
  final double lightAngle;

  UltraPremiumMoleculePainter({
    required this.rotation,
    required this.lightAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // 1. Back Glow
    final glowPaint = Paint()
      ..color = const Color(0xFFC6A664).withOpacity(0.15);
    
    if (!kIsWeb) {
      glowPaint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);
    }
    
    canvas.drawCircle(center, size.width * 0.5, glowPaint);

    // 2. Bond Connections (Golden Lines)
    final linePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF8B4513), Color(0xFFFFD700), Color(0xFF8B4513)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    // Organic rotation: Main rotates one way, atoms shift slightly
    final radius = size.width * 0.28;
    // Calculate 3 vertices of a triangle
    final atoms = [0, 1, 2].map((i) {
      double angle = (i * 2 * math.pi / 3) + (rotation * 0.2); // Slow rotation
      // Add slight "breathing" to radius
      double r = radius + (math.sin(lightAngle * 2 + i) * 5);
      return Offset(
        center.dx + math.cos(angle) * r,
        center.dy + math.sin(angle) * r,
      );
    }).toList();

    // Draw triangle connections
    canvas.drawLine(atoms[0], atoms[1], linePaint);
    canvas.drawLine(atoms[1], atoms[2], linePaint);
    canvas.drawLine(atoms[2], atoms[0], linePaint);

    // Connection to center
    for (var atom in atoms) {
      canvas.drawLine(center, atom, linePaint);
    }

    // 3. Draw Atoms (High fidelity spheres)
    // Draw Center
    _drawPremiumSphere(canvas, center, size.width * 0.14, true);

    // Draw Outer Atoms
    for (var atom in atoms) {
      _drawPremiumSphere(canvas, atom, size.width * 0.09, false);
    }
  }

  void _drawPremiumSphere(
    Canvas canvas,
    Offset center,
    double radius,
    bool isMain,
  ) {
    // Gradient simulating light from top-left (ish)
    final paint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.4, -0.4),
        radius: 1.3,
        colors: isMain
            ? [
                const Color(0xFFFFE5B4),
                const Color(0xFFFFD700),
                const Color(0xFF8B4513),
                const Color(0xFF2D1B15),
              ]
            : [
                const Color(0xFFFFF8E7),
                const Color(0xFFD2B48C),
                const Color(0xFF5D4037),
                const Color(0xFF1A120B),
              ],
        stops: const [0.0, 0.2, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    final shadowPaint = Paint()..color = Colors.black.withOpacity(0.4);
    if (!kIsWeb) {
      shadowPaint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    }

    // Drop shadow
    canvas.drawCircle(
      center + const Offset(0, 5),
      radius,
      shadowPaint,
    );

    canvas.drawCircle(center, radius, paint);

    // Rim Light (Edge reflect)
    final rimPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.white.withOpacity(0.3);
      
    if (!kIsWeb) {
      rimPaint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 1),
      math.pi,
      math.pi / 2,
      false,
      rimPaint,
    );

    // Specular Highlight (Hotspot)
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.8);

    if (!kIsWeb) {
      highlightPaint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    }

    canvas.drawOval(
      Rect.fromCenter(
        center: center + Offset(-radius * 0.35, -radius * 0.35),
        width: radius * 0.4,
        height: radius * 0.25,
      ),
      highlightPaint,
    );
  }

  @override
  bool shouldRepaint(covariant UltraPremiumMoleculePainter old) => true;
}
