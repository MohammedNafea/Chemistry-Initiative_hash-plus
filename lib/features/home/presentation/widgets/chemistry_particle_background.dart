import 'dart:math';
import 'package:flutter/material.dart';

class ChemistryParticleBackground extends StatefulWidget {
  const ChemistryParticleBackground({super.key});

  @override
  State<ChemistryParticleBackground> createState() => _ChemistryParticleBackgroundState();
}

class _ChemistryParticleBackgroundState extends State<ChemistryParticleBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    for (int i = 0; i < 20; i++) {
      _particles.add(Particle(
        offset: Offset(_random.nextDouble(), _random.nextDouble()),
        size: _random.nextDouble() * 30 + 10,
        speed: _random.nextDouble() * 0.05 + 0.01,
        type: _random.nextInt(3),
      ));
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
    final color = theme.colorScheme.primary.withValues(alpha: 0.05);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: ParticlePainter(
            particles: _particles,
            animationValue: _controller.value,
            color: color,
          ),
        );
      },
    );
  }
}

class Particle {
  Offset offset;
  double size;
  double speed;
  int type; // 0: atom, 1: bond, 2: hexagon

  Particle({required this.offset, required this.size, required this.speed, required this.type});
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double animationValue;
  final Color color;

  ParticlePainter({required this.particles, required this.animationValue, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (var particle in particles) {
      final yPos = ((particle.offset.dy + animationValue * particle.speed) % 1.0) * size.height;
      final xPos = particle.offset.dx * size.width;
      final center = Offset(xPos, yPos);

      switch (particle.type) {
        case 0: // Atom
          canvas.drawCircle(center, particle.size / 2, paint);
          canvas.drawCircle(center, particle.size / 4, paint);
          break;
        case 1: // Bond
          canvas.drawLine(
            center.translate(-particle.size / 2, -particle.size / 2),
            center.translate(particle.size / 2, particle.size / 2),
            paint,
          );
          canvas.drawCircle(center.translate(-particle.size / 2, -particle.size / 2), 3, paint..style = PaintingStyle.fill);
          canvas.drawCircle(center.translate(particle.size / 2, particle.size / 2), 3, paint);
          paint.style = PaintingStyle.stroke;
          break;
        case 2: // Hexagon (Benzene ring feel)
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
