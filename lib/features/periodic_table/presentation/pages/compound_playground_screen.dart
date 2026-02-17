import 'package:flutter/material.dart';
import 'package:chemistry_initiative/features/periodic_table/data/models/element_model.dart';
import 'package:chemistry_initiative/features/periodic_table/data/repositories/periodic_table_repository.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';
import 'dart:ui';
import 'dart:math';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/features/auth/data/current_user_provider.dart';
import 'package:chemistry_initiative/core/database/app_database.dart';
import 'package:chemistry_initiative/core/widgets/lab_widgets.dart';

class CompoundPlaygroundScreen extends ConsumerStatefulWidget {
  const CompoundPlaygroundScreen({super.key});

  @override
  ConsumerState<CompoundPlaygroundScreen> createState() => _CompoundPlaygroundScreenState();
}

class _CompoundPlaygroundScreenState extends ConsumerState<CompoundPlaygroundScreen> {
  final List<ElementModel> _selectedElements = [];
  String? _resultCompound;
  String? _resultFormula;
  String? _resultFact;

  // Simple reaction master list using localization keys
  final Map<String, Map<String, String>> _reactions = {
    'H,H,O': {
      'nameKey': 'molWater',
      'formula': 'H₂O',
      'factKey': 'factWater',
      'equation': '2H + O → H₂O'
    },
    'Na,Cl': {
      'nameKey': 'molSalt',
      'formula': 'NaCl',
      'factKey': 'factSalt',
      'equation': 'Na + Cl → NaCl'
    },
    'C,O,O': {
      'nameKey': 'molCo2',
      'formula': 'CO₂',
      'factKey': 'factCo2',
      'equation': 'C + 2O → CO₂'
    },
    'H,Cl': {
      'nameKey': 'molHcl',
      'formula': 'HCl',
      'factKey': 'factHcl',
      'equation': 'H + Cl → HCl'
    },
    'C,H,H,H,H': {
      'nameKey': 'molMethane',
      'formula': 'CH₄',
      'factKey': 'factMethane',
      'equation': 'C + 4H → CH₄'
    },
    'N,H,H,H': {
      'nameKey': 'molAmmonia',
      'formula': 'NH₃',
      'factKey': 'factAmmonia',
      'equation': 'N + 3H → NH₃'
    },
    'H,H,O,O,O,O,S': {
      'nameKey': 'molH2so4',
      'formula': 'H₂SO₄',
      'factKey': 'factH2so4',
      'equation': '2H + S + 4O → H₂SO₄'
    },
    'Na,O,H': {
      'nameKey': 'molNaoh',
      'formula': 'NaOH',
      'factKey': 'factNaoh',
      'equation': 'Na + O + H → NaOH'
    },
    'H,H': {
      'nameKey': 'molH2',
      'formula': 'H₂',
      'factKey': 'factH2',
      'equation': 'H + H → H₂'
    },
    'O,O': {
      'nameKey': 'molO2',
      'formula': 'O₂',
      'factKey': 'factO2',
      'equation': 'O + O → O₂'
    },
    'N,N': {
      'nameKey': 'molN2',
      'formula': 'N₂',
      'factKey': 'factN2',
      'equation': 'N + N → N₂'
    },
    'Cl,Cl': {
      'nameKey': 'molCl2',
      'formula': 'Cl₂',
      'factKey': 'factCl2',
      'equation': 'Cl + Cl → Cl₂'
    },
    'O,O,Ti': {
      'nameKey': 'molTio2',
      'formula': 'TiO₂',
      'factKey': 'factTio2',
      'equation': 'Ti + 2O → TiO₂'
    },
    'O,O,Pt': {
      'nameKey': 'molPto2',
      'formula': 'PtO₂',
      'factKey': 'factPto2',
      'equation': 'Pt + 2O → PtO₂'
    },
    'Cr,O,O,O': {
      'nameKey': 'molCro3',
      'formula': 'CrO₃',
      'factKey': 'factCro3',
      'equation': 'Cr + 3O → CrO₃'
    },
    'Mg,O': {
      'nameKey': 'molMagnesiumOxide',
      'formula': 'MgO',
      'factKey': 'factMagnesiumOxide',
      'equation': 'Mg + O → MgO'
    },
    'Fe,Fe,O,O,O': {
      'nameKey': 'molFe2o3',
      'formula': 'Fe₂O₃',
      'factKey': 'factFe2o3',
      'equation': '2Fe + 3O → Fe₂O₃'
    },
    'Cu,Cl,Cl': {
      'nameKey': 'molCuCl2',
      'formula': 'CuCl₂',
      'factKey': 'factCuCl2',
      'equation': 'Cu + 2Cl → CuCl₂'
    },
    'Ag,Ag,S': {
      'nameKey': 'molAg2s',
      'formula': 'Ag₂S',
      'factKey': 'factAg2s',
      'equation': '2Ag + S → Ag₂S'
    },
    'H,H,O,O': {
      'nameKey': 'molH2o2',
      'formula': 'H₂O₂',
      'factKey': 'factH2o2',
      'equation': '2H + 2O → H₂O₂'
    },
    'C,C,H,H,H,H,H,H,O': {
      'nameKey': 'molEthanol',
      'formula': 'C₂H₅OH',
      'factKey': 'factEthanol',
      'equation': '2C + 6H + O → C₂H₅OH'
    },
    'C,C,C,C,C,C,H,H,H,H,H,H,H,H,H,H,H,H,O,O,O,O,O,O': {
      'nameKey': 'molGlucose',
      'formula': 'C₆H₁₂O₆',
      'factKey': 'factGlucose',
      'equation': '6C + 12H + 6O → C₆H₁₂O₆'
    },
    'O,O,Si': {
      'nameKey': 'molSio2',
      'formula': 'SiO₂',
      'factKey': 'factSio2',
      'equation': 'Si + 2O → SiO₂'
    },
    'C,Ca,O,O,O': {
      'nameKey': 'molCaco3',
      'formula': 'CaCO₃',
      'factKey': 'factCaco3',
      'equation': 'Ca + C + 3O → CaCO₃'
    },
    'Al,Al,O,O,O': {
      'nameKey': 'molAl2o3',
      'formula': 'Al₂O₃',
      'factKey': 'factAl2o3',
      'equation': '2Al + 3O → Al₂O₃'
    },
    'Au,Cl,Cl,Cl': {
      'nameKey': 'molAucl3',
      'formula': 'AuCl₃',
      'factKey': 'factAucl3',
      'equation': 'Au + 3Cl → AuCl₃'
    },
  };

  double _temperature = 25.0; // Celsius
  double _pressure = 1.0; // atm
  Color _liquidColor = Colors.blue.withValues(alpha: 0.1);
  bool _isSynthesisActive = false;

  void _addElement(ElementModel element) {
    if (_selectedElements.length < 10) {
      HapticFeedback.lightImpact();
      setState(() {
        _selectedElements.add(element);
        _checkReaction();
      });
    }
  }

  void _removeElement(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      _selectedElements.removeAt(index);
      _checkReaction();
    });
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
      
      // Catalyst check
      bool conditionsMet = true;
      if (reaction['nameKey'] == 'molAmmonia' && _temperature < 400) conditionsMet = false;
      if (reaction['nameKey'] == 'molH2so4' && _temperature < 450) conditionsMet = false;

      if (conditionsMet) {
        HapticFeedback.mediumImpact();
        setState(() {
          _resultCompound = _getLocalizedName(reaction['nameKey']!, localizations);
          _resultFormula = reaction['formula'];
          _resultFact = _getLocalizedFact(reaction['factKey']!, localizations);
          _liquidColor = _getReactionColor(reaction['nameKey']!);
          _isSynthesisActive = true;
        });
        // Reset pulse after animation
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted) setState(() => _isSynthesisActive = false);
        });
      } else {
        setState(() {
          _resultCompound = null;
          _resultFormula = null;
          _resultFact = localizations.increaseHeatCatalyst;
          _liquidColor = _getAverageElementColor().withValues(alpha: 0.3);
        });
      }
    } else {
      setState(() {
        _resultCompound = null;
        _resultFormula = null;
        _resultFact = null;
        _liquidColor = _getAverageElementColor();
        _isSynthesisActive = false; // Reset if broken
      });
    }
  }

  Color _getAverageElementColor() {
    if (_selectedElements.isEmpty) return Colors.blue.withValues(alpha: 0.1);
    
    // Dynamic color mixing (very simple version)
    int r = 0, g = 0, b = 0;
    for (var el in _selectedElements) {
      final color = _getElementColor(el.symbol);
      r += color.r.toInt();
      g += color.g.toInt();
      b += color.b.toInt();
    }
    final len = _selectedElements.length;
    return Color.from(alpha: 0.6, red: r / len / 255.0, green: g / len / 255.0, blue: b / len / 255.0);
  }

  Color _getElementColor(String symbol) {
    switch (symbol) {
      case 'H': return Colors.white;
      case 'O': return Colors.red;
      case 'N': return Colors.blue;
      case 'Cl': return Colors.green;
      case 'Na': return Colors.orange;
      case 'C': return Colors.grey;
      case 'S': return Colors.yellow;
      case 'Ti': return Colors.blueGrey.shade300;
      case 'Cr': return Colors.blueGrey.shade100;
      case 'Pt': return Colors.grey.shade300;
      case 'Mg': return Colors.white70;
      case 'Fe': return Colors.brown;
      case 'Cu': return Colors.brown.shade300;
      case 'Ag': return Colors.grey.shade200;
      case 'Al': return Colors.grey.shade400;
      case 'Si': return Colors.blueGrey.shade700;
      case 'Ca': return Colors.grey.shade100;
      case 'Au': return Colors.amber;
      default: return Colors.blue;
    }
  }

  Color _getReactionColor(String nameKey) {
    switch (nameKey) {
      case 'molWater': return Colors.blue.shade300;
      case 'molSalt': return Colors.white;
      case 'molCo2': return Colors.grey.shade400;
      case 'molHcl': return Colors.greenAccent;
      case 'molMethane': return Colors.deepOrangeAccent;
      case 'molAmmonia': return Colors.purpleAccent;
      case 'molH2so4': return Colors.yellowAccent;
      case 'molNaoh': return Colors.white70;
      case 'molH2o2': return Colors.blue.withValues(alpha: 0.2);
      case 'molFe2o3': return Colors.deepOrange.shade900;
      case 'molEthanol': return Colors.blue.withValues(alpha: 0.3);
      case 'molGlucose': return Colors.white;
      case 'molSio2': return Colors.amber.shade100;
      case 'molCaco3': return Colors.grey.shade100;
      case 'molAl2o3': return Colors.blue.shade900;
      case 'molAucl3': return Colors.red.shade900;
      default: return Colors.blue;
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
      case 'molNaoh': return local.molNaoh;
      case 'molH2': return local.molH2;
      case 'molO2': return local.molO2;
      case 'molN2': return local.molN2;
      case 'molCl2': return local.molCl2;
      case 'molTio2': return local.molTio2;
      case 'molPto2': return local.molPto2;
      case 'molCro3': return local.molCro3;
      case 'molH2o2': return local.molH2o2;
      case 'molFe2o3': return local.molFe2o3;
      case 'molEthanol': return local.molEthanol;
      case 'molGlucose': return local.molGlucose;
      case 'molSio2': return local.molSio2;
      case 'molCaco3': return local.molCaco3;
      case 'molAl2o3': return local.molAl2o3;
      case 'molAucl3': return local.molAucl3;
      default: return key;
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
      case 'factNaoh': return local.factNaoh;
      case 'factTio2': return local.factTio2;
      case 'factPto2': return local.factPto2;
      case 'factCro3': return local.factCro3;
      case 'factH2': return local.factH2;
      case 'factO2': return local.factO2;
      case 'factN2': return local.factN2;
      case 'factCl2': return local.factCl2;
      case 'factH2o2': return local.factH2o2;
      case 'factFe2o3': return local.factFe2o3;
      case 'factEthanol': return local.factEthanol;
      case 'factGlucose': return local.factGlucose;
      case 'factSio2': return local.factSio2;
      case 'factCaco3': return local.factCaco3;
      case 'factAl2o3': return local.factAl2o3;
      case 'factAucl3': return local.factAucl3;
      default: return key;
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
          IconButton(onPressed: _showLabManual, icon: const Icon(Icons.menu_book)),
          IconButton(onPressed: _clear, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Column(
        children: [
          // Mixing Zone (Glassmorphism)
          Expanded(
            flex: 2,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
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
                      if (_resultCompound == null)
                        SynthesisPulse(
                          active: _selectedElements.isNotEmpty,
                          child: InteractiveBeaker(
                            fillLevel: _selectedElements.length / 10,
                            liquidColor: _liquidColor,
                            isBubbling: _selectedElements.isNotEmpty,
                          ),
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
                          child: SynthesisPulse(
                            active: _isSynthesisActive,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: theme.colorScheme.surface.withValues(alpha: 0.1),
                                border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.2)),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InteractiveBeaker(
                                    fillLevel: 0.8,
                                    liquidColor: _liquidColor,
                                    isBubbling: true,
                                    height: 160,
                                    width: 120,
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.primary.withValues(alpha: 0.15),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          _resultFormula!,
                                          style: theme.textTheme.headlineLarge?.copyWith(
                                            color: theme.colorScheme.primary,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      if (_getActiveEquation() != null)
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Tooltip(
                                            message: _getActiveEquation()!,
                                            child: Icon(Icons.info_outline, size: 16, color: theme.colorScheme.secondary),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _resultCompound!.toUpperCase(),
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  if (_getActiveEquation() != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        _getActiveEquation()!,
                                        style: theme.textTheme.labelMedium?.copyWith(
                                          color: theme.colorScheme.secondary,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                    ),
                                  const SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      _resultFact!,
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  _buildJournalButton(theme, localizations),
                                ],
                              ),
                            ),
                          ),
                        ),

                      // Selected elements floating
                      ...List.generate(_selectedElements.length, (index) {
                        final element = _selectedElements[index];
                        final angle = (2 * pi / _selectedElements.length) * index;
                        final radius = _resultCompound != null 
                            ? (constraints.maxWidth > 600 ? 150.0 : 120.0) 
                            : (constraints.maxWidth > 600 ? 100.0 : 80.0);
                        
                        return AnimatedPositioned(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.elasticOut,
                          left: (constraints.maxWidth / 2) - 27 + cos(angle) * radius,
                          top: (constraints.maxHeight / 2) - 27 + sin(angle) * radius,
                          child: GestureDetector(
                            onTap: () => _removeElement(index),
                            child: Container(
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    _getElementColor(element.symbol).withValues(alpha: 0.4),
                                    theme.colorScheme.surface,
                                  ],
                                ),
                                border: Border.all(
                                  color: _getElementColor(element.symbol).withValues(alpha: 0.6),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: _getElementColor(element.symbol).withValues(alpha: 0.2),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  element.symbol,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: theme.textTheme.bodyLarge?.color,
                                  ),
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
                );
              },
            ),
          ),

        // Catalyst Panel
        _buildCatalystPanel(theme, localizations),

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
                  padding: const EdgeInsets.only(right: 16, bottom: 8),
                  child: InkWell(
                    onTap: () => _addElement(element),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 85,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: _getElementColor(element.symbol).withValues(alpha: 0.3), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: _getElementColor(element.symbol).withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 4,
                            right: 8,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 8,
                                color: theme.hintColor.withValues(alpha: 0.5),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  element.symbol,
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w900,
                                    color: _getElementColor(element.symbol),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  element.name,
                                  style: theme.textTheme.labelSmall?.copyWith(fontSize: 9),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
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

  String? _getActiveEquation() {
    List<String> symbols = _selectedElements.map((e) => e.symbol).toList()..sort();
    String key = symbols.join(',');
    return _reactions[key]?['equation'];
  }
  Widget _buildJournalButton(ThemeData theme, AppLocalizations localizations) {
    final user = ref.watch(currentUserNotifierProvider);
    final currentCompoundId = _reactions.entries.firstWhere((e) {
      List<String> symbols = _selectedElements.map((el) => el.symbol).toList()..sort();
      return e.key == symbols.join(',');
    }).value['nameKey'];

    final isDiscovered = user?.researchJournal.containsKey(currentCompoundId) ?? false;

    return ElevatedButton.icon(
      onPressed: isDiscovered ? null : () => _saveToJournal(currentCompoundId!),
      icon: Icon(isDiscovered ? Icons.check_circle : Icons.bookmark_add_outlined),
      label: Text(isDiscovered ? localizations.saved : localizations.researchJournal),
      style: ElevatedButton.styleFrom(
        backgroundColor: isDiscovered ? Colors.green.withValues(alpha: 0.2) : theme.colorScheme.primary,
        foregroundColor: isDiscovered ? Colors.green : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  Future<void> _saveToJournal(String compoundId) async {
    final user = ref.read(currentUserNotifierProvider);
    if (user == null) return;

    final updatedJournal = Map<String, String>.from(user.researchJournal);
    updatedJournal[compoundId] = DateTime.now().toIso8601String();

    final updatedUser = user.copyWith(researchJournal: updatedJournal);
    HapticFeedback.selectionClick();
    await AppDatabase.instance.updateUser(updatedUser);
    ref.read(currentUserNotifierProvider.notifier).refresh();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.addedToBookmarks),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    }
  }

  Widget _buildCatalystPanel(ThemeData theme, AppLocalizations local) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.thermostat, size: 16, color: Colors.orange),
              const SizedBox(width: 8),
              Text('${_temperature.toInt()}°C', style: theme.textTheme.bodySmall),
              Expanded(
                child: Slider(
                  value: _temperature,
                  min: 0,
                  max: 1000,
                  activeColor: Colors.orange,
                  onChanged: (val) {
                    setState(() => _temperature = val);
                    _checkReaction();
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.compress, size: 16, color: Colors.blue),
              const SizedBox(width: 8),
              Text('${_pressure.toStringAsFixed(1)} atm', style: theme.textTheme.bodySmall),
              Expanded(
                child: Slider(
                  value: _pressure,
                  min: 1,
                  max: 200,
                  activeColor: Colors.blue,
                  onChanged: (val) {
                    setState(() => _pressure = val);
                    _checkReaction();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLabManual() {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.menu_book, color: Colors.blueAccent),
                    const SizedBox(width: 8),
                    Text(
                      localizations.labManual,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _reactions.length,
                  itemBuilder: (context, index) {
                    final reactionKey = _reactions.keys.elementAt(index);
                    final reactionData = _reactions[reactionKey]!;
                    final name = _getLocalizedName(reactionData['nameKey']!, localizations);
                    
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  name,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: _getReactionColor(reactionData['nameKey']!),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primaryContainer,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    reactionData['formula']!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onPrimaryContainer,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${localizations.recipes}:',
                              style: theme.textTheme.labelSmall?.copyWith(color: Colors.grey),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isDark ? Colors.black26 : Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.science, size: 16, color: theme.colorScheme.secondary),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      reactionData['equation']!,
                                      style: const TextStyle(
                                        fontFamily: 'monospace',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
