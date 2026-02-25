import 'package:flutter/material.dart';
import 'package:chemistry_initiative/features/periodic_table/data/models/element_model.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Element3DViewerScreen extends StatelessWidget {
  final ElementModel element;

  const Element3DViewerScreen({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String modelUrl = element.symbol == 'C'
        ? 'assets/models/carbon.glb'
        : 'assets/models/water.glb';

    return Scaffold(
      appBar: AppBar(
        title: Text('${element.name} 3D'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: Container(
        color: theme.colorScheme.surface,
        child:
            element.symbol == 'C' ||
                (element.name.toLowerCase().contains('water') ||
                    element.symbol == 'O')
            ? ModelViewer(
                src: modelUrl,
                alt: 'A 3D model of ${element.name}',
                ar: true,
                autoRotate: true,
                cameraControls: true,
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.primaryContainer.withValues(
                          alpha: 0.3,
                        ),
                      ),
                      child: Icon(
                        Icons.blur_on_rounded,
                        size: 100,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Visualizing ${element.name}...',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'A detailed 3D model for ${element.symbol} is being prepared. View its physical properties in the Periodic Table.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
