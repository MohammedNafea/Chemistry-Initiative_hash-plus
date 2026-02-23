import 'dart:math';
import 'package:flutter/material.dart';

class ChemistryParticleBackground extends StatefulWidget {
  const ChemistryParticleBackground({super.key});

  @override
  State<ChemistryParticleBackground> createState() =>
      _ChemistryParticleBackgroundState();
}

class _ChemistryParticleBackgroundState
    extends State<ChemistryParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    for (int i = 0; i < 30; i++) {
      _particles.add(
        Particle(
          offset: Offset(_random.nextDouble(), _random.nextDouble()),
          size: _random.nextDouble() * 20 + 5,
          velocity: Offset(
            (_random.nextDouble() - 0.5) * 0.001,
            (_random.nextDouble() - 0.5) * 0.001,
          ),
          type: _random.nextInt(3),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Update positions
        for (var p in _particles) {
          p.offset = Offset(
            (p.offset.dx + p.velocity.dx) % 1.0,
            (p.offset.dy + p.velocity.dy) % 1.0,
          );
        }

        return CustomPaint(
          size: Size.infinite,
          painter: ParticlePainter(
            particles: _particles,
            primaryColor: theme.colorScheme.primary.withValues(
              alpha: isDark ? 0.15 : 0.1,
            ),
            accentColor: theme.colorScheme.secondary.withValues(
              alpha: isDark ? 0.1 : 0.05,
            ),
          ),
        );
      },
    );
  }
}

class Particle {
  Offset offset;
  double size;
  Offset velocity;
  int type; // 0: atom, 1: complex, 2: hexagon

  Particle({
    required this.offset,
    required this.size,
    required this.velocity,
    required this.type,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Color primaryColor;
  final Color accentColor;

  ParticlePainter({
    required this.particles,
    required this.primaryColor,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const maxDistance = 150.0;

    // Draw Bonds first
    for (int i = 0; i < particles.length; i++) {
      final p1 = particles[i];
      final pos1 = Offset(
        p1.offset.dx * size.width,
        p1.offset.dy * size.height,
      );

      for (int j = i + 1; j < particles.length; j++) {
        final p2 = particles[j];
        final pos2 = Offset(
          p2.offset.dx * size.width,
          p2.offset.dy * size.height,
        );

        final distance = (pos1 - pos2).distance;
        if (distance < maxDistance) {
          final opacity = (1.0 - (distance / maxDistance)) * 0.3;
          paint.color = primaryColor.withValues(alpha: opacity);
          canvas.drawLine(pos1, pos2, paint);
        }
      }
    }

    // Draw Nodes
    for (var particle in particles) {
      final center = Offset(
        particle.offset.dx * size.width,
        particle.offset.dy * size.height,
      );
      paint.color = primaryColor;

      switch (particle.type) {
        case 0: // Atomic Node
          canvas.drawCircle(center, particle.size / 2, paint);
          canvas.drawCircle(center, 2, paint..style = PaintingStyle.fill);
          paint.style = PaintingStyle.stroke;
          break;
        case 1: // Electron Shell feel
          canvas.drawCircle(center, particle.size / 2, paint);
          canvas.drawCircle(
            center,
            particle.size / 4,
            paint..color = accentColor,
          );
          paint.style = PaintingStyle.stroke;
          break;
        case 2: // Benzene fragment
          final path = Path();
          for (int i = 0; i < 6; i++) {
            final angle = (pi / 3) * i;
            final point = Offset(
              center.dx + particle.size / 2 * cos(angle),
              center.dy + particle.size / 2 * sin(angle),
            );
            if (i == 0) path.moveTo(point.dx, point.dy);
            path.lineTo(point.dx, point.dy);
          }
          path.close();
          canvas.drawPath(path, paint);
          break;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
