import 'dart:math';
import 'package:flutter/material.dart';

class BohrModelPainter extends CustomPainter {
  final int atomicNumber;
  final Color electronColor;
  final Color shellColor;

  BohrModelPainter({
    required this.atomicNumber,
    required this.electronColor,
    required this.shellColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = min(size.width, size.height) / 2;

    // Draw Nucleus
    final nucleusPaint = Paint()
      ..color = electronColor.withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, maxRadius * 0.15, nucleusPaint);

    final shellPaint = Paint()
      ..color = shellColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final electronPaint = Paint()
      ..color = electronColor
      ..style = PaintingStyle.fill;

    // Calculate shell distribution
    int remainingElectrons = atomicNumber;
    int shellIndex = 1;

    while (remainingElectrons > 0) {
      final shellCapacity = 2 * (shellIndex * shellIndex);
      final electronsInShell = min(remainingElectrons, shellCapacity);
      final shellRadius = (maxRadius * 0.2) + (shellIndex * (maxRadius * 0.15));

      if (shellRadius > maxRadius) break;

      // Draw Shell Orbit
      canvas.drawCircle(center, shellRadius, shellPaint);

      // Draw Electrons in this shell
      for (int i = 0; i < electronsInShell; i++) {
        final angle = (2 * pi / electronsInShell) * i;
        final electronOffset = Offset(
          center.dx + shellRadius * cos(angle),
          center.dy + shellRadius * sin(angle),
        );
        canvas.drawCircle(electronOffset, 3, electronPaint);
      }

      remainingElectrons -= electronsInShell;
      shellIndex++;
      if (shellIndex > 4) break; // Limit to 4 shells for visualization
    }
  }

  @override
  bool shouldRepaint(covariant BohrModelPainter oldDelegate) {
    return oldDelegate.atomicNumber != atomicNumber;
  }
}

class BohrModelWidget extends StatefulWidget {
  final int atomicNumber;
  const BohrModelWidget({super.key, required this.atomicNumber});

  @override
  State<BohrModelWidget> createState() => _BohrModelWidgetState();
}

class _BohrModelWidgetState extends State<BohrModelWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: CustomPaint(
            size: const Size(120, 120),
            painter: BohrModelPainter(
              atomicNumber: widget.atomicNumber,
              electronColor: theme.primaryColor,
              shellColor: theme.dividerColor,
            ),
          ),
        );
      },
    );
  }
}
