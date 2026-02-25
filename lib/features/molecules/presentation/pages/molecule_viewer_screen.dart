import 'package:flutter/material.dart';
import 'package:chemistry_initiative/features/molecules/data/repositories/molecule_repository.dart';
import 'package:chemistry_initiative/features/molecules/data/models/molecule.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class MoleculeViewerScreen extends StatefulWidget {
  const MoleculeViewerScreen({super.key});

  @override
  State<MoleculeViewerScreen> createState() => _MoleculeViewerScreenState();
}

class _MoleculeViewerScreenState extends State<MoleculeViewerScreen> {
  late Molecule _selectedMolecule;
  final List<Molecule> _molecules = MoleculeRepository.getMolecules();
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _selectedMolecule = _molecules.first;
  }

  String _get3DModelPath(String id) {
    // Determine the 3d model to load based on the molecule ID.
    // For now we map water and carbon to our downloaded sample files.
    // In a real app, each molecule would have its own .glb file in assets.
    if (id == 'water') {
      return 'assets/models/water.glb';
    }
    return 'assets/models/carbon.glb'; // Fallback to duck/carbon for others.
  }

  Future<void> _speak(String text) async {
    final locale = Localizations.localeOf(context).toString();
    await flutterTts.setLanguage(locale);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  String _getLocalizedText(AppLocalizations localizations, String key) {
    switch (key) {
      case 'molWater':
        return localizations.molWater;
      case 'molCo2':
        return localizations.molCo2;
      case 'molMethane':
        return localizations.molMethane;
      case 'molSalt':
        return localizations.molSalt;
      case 'molAmmonia':
        return localizations.molAmmonia;
      case 'molHcl':
        return localizations.molHcl;
      case 'molH2so4':
        return localizations.molH2so4;
      case 'molNaoh':
        return localizations.molNaoh;
      case 'molTio2':
        return localizations.molTio2;
      case 'molPto2':
        return localizations.molPto2;
      case 'molCro3':
        return localizations.molCro3;
      case 'molH2':
        return localizations.molH2;
      case 'molO2':
        return localizations.molO2;
      case 'molN2':
        return localizations.molN2;
      case 'molCl2':
        return localizations.molCl2;
      case 'molH2o2':
        return localizations.molH2o2;
      case 'molFe2o3':
        return localizations.molFe2o3;
      case 'molEthanol':
        return localizations.molEthanol;
      case 'molGlucose':
        return localizations.molGlucose;
      case 'molSio2':
        return localizations.molSio2;
      case 'molCaco3':
        return localizations.molCaco3;
      case 'molAl2o3':
        return localizations.molAl2o3;
      case 'molAucl3':
        return localizations.molAucl3;
      case 'factWater':
        return localizations.factWater;
      case 'factCo2':
        return localizations.factCo2;
      case 'factMethane':
        return localizations.factMethane;
      case 'factSalt':
        return localizations.factSalt;
      case 'factAmmonia':
        return localizations.factAmmonia;
      case 'factHcl':
        return localizations.factHcl;
      case 'factH2so4':
        return localizations.factH2so4;
      case 'factNaoh':
        return localizations.factNaoh;
      case 'factTio2':
        return localizations.factTio2;
      case 'factPto2':
        return localizations.factPto2;
      case 'factCro3':
        return localizations.factCro3;
      case 'factH2':
        return localizations.factH2;
      case 'factO2':
        return localizations.factO2;
      case 'factN2':
        return localizations.factN2;
      case 'factCl2':
        return localizations.factCl2;
      case 'factH2o2':
        return localizations.factH2o2;
      case 'factFe2o3':
        return localizations.factFe2o3;
      case 'factEthanol':
        return localizations.factEthanol;
      case 'factGlucose':
        return localizations.factGlucose;
      case 'factSio2':
        return localizations.factSio2;
      case 'factCaco3':
        return localizations.factCaco3;
      case 'factAl2o3':
        return localizations.factAl2o3;
      case 'factAucl3':
        return localizations.factAucl3;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.moleculeViewer),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Row(
        children: [
          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // 3D Viewer Area
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF1E1E1E)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Hero(
                            tag: _selectedMolecule.id,
                            child:
                                (_selectedMolecule.id == 'water' ||
                                    _selectedMolecule.id == 'carbon')
                                ? ModelViewer(
                                    key: ValueKey(_selectedMolecule.id),
                                    src: _get3DModelPath(_selectedMolecule.id),
                                    alt:
                                        'A 3D model of ${_selectedMolecule.name}',
                                    ar: true,
                                    autoRotate: true,
                                    cameraControls: true,
                                  )
                                : Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 150,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: theme
                                                .colorScheme
                                                .primaryContainer
                                                .withValues(alpha: 0.3),
                                          ),
                                          child: Icon(
                                            Icons.architecture_rounded,
                                            size: 80,
                                            color: theme.colorScheme.primary,
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        Text(
                                          'Visualizing Structure...',
                                          style: theme.textTheme.titleLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    theme.colorScheme.primary,
                                              ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '3D Model for ${_selectedMolecule.formula} coming soon.',
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _selectedMolecule.formula,
                          style: theme.textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Details
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  _getLocalizedText(
                                    localizations,
                                    _selectedMolecule.name,
                                  ),
                                  style: theme.textTheme.headlineMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.volume_up,
                                  color: theme.colorScheme.primary,
                                ),
                                onPressed: () => _speak(
                                  _getLocalizedText(
                                    localizations,
                                    _selectedMolecule.name,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.secondary.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _selectedMolecule.category,
                              style: TextStyle(
                                color: theme.colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _getLocalizedText(
                              localizations,
                              _selectedMolecule.description,
                            ),
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Vertical Selector Sidebar
          Container(
            width: 100,
            decoration: BoxDecoration(
              color: theme.cardColor,
              border: Border(
                left: BorderSide(
                  color: theme.dividerColor.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 24),
              itemCount: _molecules.length,
              itemBuilder: (context, index) {
                final mol = _molecules[index];
                final isSelected = mol.id == _selectedMolecule.id;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedMolecule = mol;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 70,
                    margin: const EdgeInsets.only(
                      bottom: 12,
                      left: 12,
                      right: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? Colors.transparent
                            : Colors.grey.withValues(alpha: 0.3),
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: theme.colorScheme.primary.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Center(
                      child: Text(
                        mol.formula,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : theme.textTheme.bodyMedium?.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
