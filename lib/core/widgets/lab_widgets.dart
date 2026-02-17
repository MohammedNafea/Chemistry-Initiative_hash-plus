import 'dart:math';
import 'package:flutter/material.dart';

class InteractiveBeaker extends StatefulWidget {
  final double fillLevel; // 0.0 to 1.0
  final Color liquidColor;
  final bool isBubbling;
  final double width;
  final double height;

  const InteractiveBeaker({
    super.key,
    required this.fillLevel,
    this.liquidColor = Colors.blue,
    this.isBubbling = false,
    this.width = 180,
    this.height = 240,
  });

  @override
  State<InteractiveBeaker> createState() => _InteractiveBeakerState();
}

class _InteractiveBeakerState extends State<InteractiveBeaker> with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _bubbleController;
  final List<Bubble> _bubbles = [];

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
    _bubbleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat();

    for (int i = 0; i < 8; i++) {
      _bubbles.add(_createRandomBubble());
    }
  }

  Bubble _createRandomBubble() {
    final rand = Random();
    return Bubble(
      x: rand.nextDouble(),
      y: 1.0,
      size: rand.nextDouble() * 5 + 3,
      speed: rand.nextDouble() * 0.015 + 0.005,
      opacity: rand.nextDouble() * 0.5 + 0.2,
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    _bubbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_waveController, _bubbleController]),
      builder: (context, child) {
        if (widget.isBubbling) {
          for (var b in _bubbles) {
            b.y -= b.speed;
            if (b.y < (1.0 - widget.fillLevel)) {
              final newB = _createRandomBubble();
              b.x = newB.x;
              b.y = 1.0;
              b.opacity = newB.opacity;
            }
          }
        }

        return CustomPaint(
          size: Size(widget.width, widget.height),
          painter: _BeakerMasterPainter(
            fillLevel: widget.fillLevel,
            color: widget.liquidColor,
            bubbles: _bubbles,
            waveValue: _waveController.value,
            isBubbling: widget.isBubbling,
            theme: Theme.of(context),
          ),
        );
      },
    );
  }
}

class _BeakerMasterPainter extends CustomPainter {
  final double fillLevel;
  final Color color;
  final List<Bubble> bubbles;
  final double waveValue;
  final bool isBubbling;
  final ThemeData theme;

  _BeakerMasterPainter({
    required this.fillLevel,
    required this.color,
    required this.bubbles,
    required this.waveValue,
    required this.isBubbling,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final isDark = theme.brightness == Brightness.dark;
    final r = size.width * 0.1;
    
    // 1. Draw Glass Background (Subtle transparency)
    final glassBgPaint = Paint()
      ..color = isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.02)
      ..style = PaintingStyle.fill;
    
    final RRect beakerRect = RRect.fromLTRBR(0, 0, size.width, size.height, Radius.circular(r));
    canvas.drawRRect(beakerRect, glassBgPaint);

    // 2. Draw Liquid
    if (fillLevel > 0.02) {
      final liquidPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withValues(alpha: 0.7),
            color.withValues(alpha: 0.9),
          ],
        ).createShader(Rect.fromLTRB(0, size.height * (1 - fillLevel), size.width, size.height));

      final path = Path();
      final currentY = size.height * (1 - fillLevel);
      
      path.moveTo(0, currentY);
      
      // Dynamic Waves
      for (double i = 0; i <= size.width; i++) {
        final waveHeight = 4.0;
        final dx = i / size.width * 2 * pi;
        path.lineTo(i, currentY + sin(dx + waveValue * 2 * pi) * waveHeight);
      }
      
      path.lineTo(size.width, size.height - r);
      path.quadraticBezierTo(size.width, size.height, size.width - r, size.height);
      path.lineTo(r, size.height);
      path.quadraticBezierTo(0, size.height, 0, size.height - r);
      path.close();
      
      canvas.drawPath(path, liquidPaint);

      // 3. Draw Bubbles
      if (isBubbling) {
        final bPaint = Paint()..style = PaintingStyle.fill;
        for (var b in bubbles) {
          bPaint.color = Colors.white.withValues(alpha: b.opacity * (fillLevel > 0.5 ? 0.6 : 0.3));
          canvas.drawCircle(Offset(b.x * size.width, b.y * size.height), b.size, bPaint);
        }
      }
    }

    // 4. Draw Glass Outlines & Reflections
    final framePaint = Paint()
      ..color = isDark ? Colors.white.withValues(alpha: 0.3) : Colors.black.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    
    canvas.drawRRect(beakerRect, framePaint);

    // Reflection light
    final reflectPaint = Paint()
      ..color = Colors.white.withValues(alpha: isDark ? 0.2 : 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    
    final reflectPath = Path();
    reflectPath.moveTo(size.width * 0.15, size.height * 0.1);
    reflectPath.lineTo(size.width * 0.15, size.height * 0.35);
    canvas.drawPath(reflectPath, reflectPaint);
    
    // Measurement markings
    final markPaint = Paint()
      ..color = isDark ? Colors.white.withValues(alpha: 0.15) : Colors.black.withValues(alpha: 0.1)
      ..strokeWidth = 1;
    
    for (int i = 1; i < 5; i++) {
      final y = size.height * (i / 5);
      canvas.drawLine(Offset(size.width * 0.7, y), Offset(size.width, y), markPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class SynthesisPulse extends StatelessWidget {
  final Widget child;
  final bool active;

  const SynthesisPulse({super.key, required this.child, this.active = false});

  @override
  Widget build(BuildContext context) {
    if (!active) return child;

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      builder: (context, value, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            if (value < 0.8)
              Container(
                width: 200 * value,
                height: 200 * value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 1 - value),
                    width: 4,
                  ),
                ),
              ),
            child!,
          ],
        );
      },
      child: child,
    );
  }
}

class Bubble {
  double x;
  double y;
  double size;
  double speed;
  double opacity;

  Bubble({required this.x, required this.y, required this.size, required this.speed, required this.opacity});
}

/// Backward compatibility wrapper for BeakerProgressIndicator
class BeakerProgressIndicator extends StatelessWidget {
  final double value;
  final double height;
  final double width;
  final Color? liquidColor;

  const BeakerProgressIndicator({
    super.key,
    required this.value,
    this.height = 100,
    this.width = 60,
    this.liquidColor,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveBeaker(
      fillLevel: value,
      liquidColor: liquidColor ?? Theme.of(context).colorScheme.primary,
      height: height,
      width: width,
      isBubbling: value > 0.05,
    );
  }
}
