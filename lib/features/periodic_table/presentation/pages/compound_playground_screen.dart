import 'package:flutter/material.dart';
import 'package:chemistry_initiative/features/periodic_table/data/models/element_model.dart';
import 'package:chemistry_initiative/features/periodic_table/data/repositories/periodic_table_repository.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';
import 'dart:math';

class CompoundPlaygroundScreen extends StatefulWidget {
  const CompoundPlaygroundScreen({super.key});

  @override
  State<CompoundPlaygroundScreen> createState() => _CompoundPlaygroundScreenState();
}

class _CompoundPlaygroundScreenState extends State<CompoundPlaygroundScreen> {
  final List<ElementModel> _selectedElements = [];
  String? _resultCompound;
  String? _resultFormula;
  String? _resultFact;

  // Simple reaction master list using localization keys
  final Map<String, Map<String, String>> _reactions = {
    'H,H,O': {
      'nameKey': 'molWater',
      'formula': 'H₂O',
      'factKey': 'factWater'
    },
    'Na,Cl': {
      'nameKey': 'molSalt',
      'formula': 'NaCl',
      'factKey': 'factSalt'
    },
    'C,O,O': {
      'nameKey': 'molCo2',
      'formula': 'CO₂',
      'factKey': 'factCo2'
    },
    'H,Cl': {
      'nameKey': 'molHcl',
      'formula': 'HCl',
      'factKey': 'factHcl'
    },
    'C,H,H,H,H': {
      'nameKey': 'molMethane',
      'formula': 'CH₄',
      'factKey': 'factMethane'
    },
    'N,H,H,H': {
      'nameKey': 'molAmmonia',
      'formula': 'NH₃',
      'factKey': 'factAmmonia'
    },
    'H,H,O,O,O,O,S': {
      'nameKey': 'molH2so4',
      'formula': 'H₂SO₄',
      'factKey': 'factH2so4'
    },
  };

  void _addElement(ElementModel element) {
    if (_selectedElements.length < 10) {
      setState(() {
        _selectedElements.add(element);
        _checkReaction();
      });
    }
  }

  void _clear() {
    setState(() {
      _selectedElements.clear();
      _resultCompound = null;
      _resultFormula = null;
      _resultFact = null;
    });
  }

  void _checkReaction() {
    if (_selectedElements.isEmpty) return;

    final localizations = AppLocalizations.of(context)!;
    List<String> symbols = _selectedElements.map((e) => e.symbol).toList()..sort();
    String key = symbols.join(',');

    if (_reactions.containsKey(key)) {
      final reaction = _reactions[key]!;
      setState(() {
        _resultCompound = _getLocalizedName(reaction['nameKey']!, localizations);
        _resultFormula = reaction['formula'];
        _resultFact = _getLocalizedFact(reaction['factKey']!, localizations);
      });
    } else {
      setState(() {
        _resultCompound = null;
        _resultFormula = null;
        _resultFact = null;
      });
    }
  }

  String _getLocalizedName(String key, AppLocalizations local) {
    switch (key) {
      case 'molWater': return local.molWater;
      case 'molSalt': return local.molSalt;
      case 'molCo2': return local.molCo2;
      case 'molHcl': return local.molHcl;
      case 'molMethane': return local.molMethane;
      case 'molAmmonia': return local.molAmmonia;
      case 'molH2so4': return local.molH2so4;
      default: return 'Compound';
    }
  }

  String _getLocalizedFact(String key, AppLocalizations local) {
    switch (key) {
      case 'factWater': return local.factWater;
      case 'factSalt': return local.factSalt;
      case 'factCo2': return local.factCo2;
      case 'factHcl': return local.factHcl;
      case 'factMethane': return local.factMethane;
      case 'factAmmonia': return local.factAmmonia;
      case 'factH2so4': return local.factH2so4;
      default: return 'A chemical compound.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final allElements = PeriodicTableRepository.getElements(localizations);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.compoundPlayground),
        actions: [
          IconButton(onPressed: _clear, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Column(
        children: [
          // Mixing Zone (Glassmorphism)
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.2)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.primary.withValues(alpha: 0.05),
                    theme.colorScheme.secondary.withValues(alpha: 0.05),
                  ],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (_selectedElements.isEmpty)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.flask, size: 64, color: theme.colorScheme.primary.withValues(alpha: 0.3)),
                            const SizedBox(height: 16),
                            Text(
                              localizations.selectElementsMix,
                              style: TextStyle(color: theme.colorScheme.primary.withValues(alpha: 0.5)),
                            ),
                          ],
                        ),
                      
                      // Compound Result
                      if (_resultCompound != null)
                        TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 500),
                          tween: Tween<double>(begin: 0, end: 1),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.scale(
                                scale: 0.8 + (0.2 * value),
                                child: child,
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _resultFormula!,
                                style: theme.textTheme.displayLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _resultCompound!,
                                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32),
                                child: Text(
                                  _resultFact!,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Selected elements floating
                      ...List.generate(_selectedElements.length, (index) {
                        final element = _selectedElements[index];
                        final angle = (2 * pi / _selectedElements.length) * index;
                        final radius = _resultCompound != null ? 120.0 : 80.0;
                        
                        return AnimatedPositioned(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOutBack,
                          left: MediaQuery.of(context).size.width / 2 - 40 + cos(angle) * (radius * (_resultCompound != null ? 1.5 : 1)),
                          top: (MediaQuery.of(context).size.height * 0.25) - 40 + sin(angle) * (radius * (_resultCompound != null ? 1.5 : 1)),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: theme.colorScheme.surface,
                              border: Border.all(color: theme.colorScheme.primary),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.primary.withValues(alpha: 0.2),
                                  blurRadius: 8,
                                )
                              ],
                            ),
                            child: Center(
                              child: Text(
                                element.symbol,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Element Selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(localizations.elementsRepository, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: allElements.length,
              itemBuilder: (context, index) {
                final element = allElements[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: InkWell(
                    onTap: () => _addElement(element),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            element.symbol,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            element.name,
                            style: const TextStyle(fontSize: 10),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
