import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';

class ChemicalScannerScreen extends StatefulWidget {
  const ChemicalScannerScreen({super.key});

  @override
  State<ChemicalScannerScreen> createState() => _ChemicalScannerScreenState();
}

class _ChemicalScannerScreenState extends State<ChemicalScannerScreen> {
  CameraController? _controller;
  bool _isInitializing = true;
  bool _isProcessing = false;
  String? _detectedCompound;
  List<String> _elements = [];
  final TextRecognizer _textRecognizer = TextRecognizer();

  final Map<String, List<String>> _compoundMap = {
    'NaCl': ['Sodium (Na)', 'Chlorine (Cl)'],
    'Sodium Chloride': ['Sodium (Na)', 'Chlorine (Cl)'],
    'H2O': ['Hydrogen (H)', 'Oxygen (O)'],
    'Water': ['Hydrogen (H)', 'Oxygen (O)'],
    'Acetic Acid': ['Carbon (C)', 'Hydrogen (H)', 'Oxygen (O)'],
    'Vinegar': ['Carbon (C)', 'Hydrogen (H)', 'Oxygen (O)'],
    'Ethanol': ['Carbon (C)', 'Hydrogen (H)', 'Oxygen (O)'],
    'NaHCO3': ['Sodium (Na)', 'Hydrogen (H)', 'Carbon (C)', 'Oxygen (O)'],
    'Baking Soda': ['Sodium (Na)', 'Hydrogen (H)', 'Carbon (C)', 'Oxygen (O)'],
    'Ammonia': ['Nitrogen (N)', 'Hydrogen (H)'],
    'Bleach': ['Sodium (Na)', 'Chlorine (Cl)', 'Oxygen (O)'],
    'Acetone': ['Carbon (C)', 'Hydrogen (H)', 'Oxygen (O)'],
  };

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    try {
      await _controller!.initialize();
      if (mounted) {
        setState(() => _isInitializing = false);
        _startImageStream();
      }
    } catch (e) {
      debugPrint('Camera error: $e');
    }
  }

  void _startImageStream() {
    // In a real app, we'd process frames here.
    // For this prototype, we'll use a manual "Scan" button to trigger OCR.
  }

  Future<void> _scanLabel() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        _isProcessing) {
      return;
    }

    setState(() {
      _isProcessing = true;
      _detectedCompound = null;
      _elements = [];
    });

    try {
      final image = await _controller!.takePicture();
      final inputImage = InputImage.fromFilePath(image.path);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      String? foundCompound;
      for (final block in recognizedText.blocks) {
        final text = block.text.toLowerCase();
        for (final key in _compoundMap.keys) {
          if (text.contains(key.toLowerCase())) {
            foundCompound = key;
            break;
          }
        }
        if (foundCompound != null) break;
      }

      if (mounted) {
        setState(() {
          _detectedCompound = foundCompound;
          _elements = foundCompound != null ? _compoundMap[foundCompound]! : [];
          _isProcessing = false;
        });
      }
    } catch (e) {
      debugPrint('Scan error: $e');
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(localizations.chemicalScanner)),
      body: Stack(
        children: [
          if (_isInitializing)
            const Center(child: CircularProgressIndicator())
          else
            Positioned.fill(child: CameraPreview(_controller!)),

          // Instruction Overlay
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                localizations.scanInstructions,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.sizeOf(context).width < 600 ? 14 : 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Scan Button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton.large(
                onPressed: _isProcessing ? null : _scanLabel,
                backgroundColor: theme.colorScheme.primary,
                child: _isProcessing
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Icon(
                        Icons.qr_code_scanner,
                        size: 36,
                        color: Colors.white,
                      ),
              ),
            ),
          ),

          // Result Overlay
          if (_detectedCompound != null)
            Positioned(
              bottom: 140,
              left: 20,
              right: 20,
              child: Card(
                color: theme.colorScheme.surface.withValues(alpha: 0.92),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _detectedCompound!,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        localizations.identifiedElements,
                        style: theme.textTheme.labelMedium,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: _elements
                            .map((e) => Chip(label: Text(e)))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
