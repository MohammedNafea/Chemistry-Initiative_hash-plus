import 'package:flutter/material.dart';
import 'package:chemistry_initiative/features/molecules/data/repositories/molecule_repository.dart';
import 'package:chemistry_initiative/features/molecules/data/models/molecule.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';

class MoleculeViewerScreen extends StatefulWidget {
  const MoleculeViewerScreen({super.key});

  @override
  State<MoleculeViewerScreen> createState() => _MoleculeViewerScreenState();
}

class _MoleculeViewerScreenState extends State<MoleculeViewerScreen> {
  late Molecule _selectedMolecule;
  final List<Molecule> _molecules = MoleculeRepository.getMolecules();

  @override
  void initState() {
    super.initState();
    _selectedMolecule = _molecules.first;
  }

  String _getLocalizedText(AppLocalizations localizations, String key) {
    switch (key) {
      case 'molWater': return localizations.molWater;
      case 'molCo2': return localizations.molCo2;
      case 'molMethane': return localizations.molMethane;
      case 'molSalt': return localizations.molSalt;
      case 'factWater': return localizations.factWater;
      case 'factCo2': return localizations.factCo2;
      case 'factMethane': return localizations.factMethane;
      case 'factSalt': return localizations.factSalt;
      default: return key;
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
      body: Column(
        children: [
          // 3D Viewer Area (Simulated with rotating image)
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[200],
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
                  Hero(
                    tag: _selectedMolecule.id,
                    child: Transform.scale(
                      scale: 1.2,
                      child: const Icon(Icons.science, size: 120, color: Colors.blueAccent), // Placeholder for 3D model/Image
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
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getLocalizedText(localizations, _selectedMolecule.name),
                    style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary.withValues(alpha: 0.1),
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
                    _getLocalizedText(localizations, _selectedMolecule.description),
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),

          // Selector
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                    width: 70,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? theme.colorScheme.primary : theme.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? Colors.transparent : Colors.grey.withValues(alpha: 0.3),
                      ),
                      boxShadow: isSelected ? [
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ] : [],
                    ),
                    child: Center(
                      child: Text(
                        mol.formula,
                        style: TextStyle(
                          color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
