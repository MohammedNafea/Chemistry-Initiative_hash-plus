import 'package:flutter/material.dart';
import 'package:chemistry_initiative/features/periodic_table/data/models/element_model.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Element3DViewerScreen extends StatelessWidget {
  final ElementModel element;

  const Element3DViewerScreen({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Fallback logic for elements. Since we only downloaded water/carbon:
    // We treat 'C' as carbon, and everything else uses the generic water model as placeholder.
    String modelUrl = 'assets/models/water.glb';
    if (element.symbol == 'C') {
      modelUrl = 'assets/models/carbon.glb';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${element.name} 3D'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: Container(
        color: theme.colorScheme.surface,
        child: ModelViewer(
          src: modelUrl,
          alt: 'A 3D model of ${element.name}',
          ar: true,
          autoRotate: true,
          cameraControls: true,
        ),
      ),
    );
  }
}
