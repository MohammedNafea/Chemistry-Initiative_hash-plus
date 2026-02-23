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
import 'package:chemistry_initiative/features/handbook/presentation/pages/chemists_notebook_screen.dart';

class CompoundPlaygroundScreen extends ConsumerStatefulWidget {
  const CompoundPlaygroundScreen({super.key});

  @override
  ConsumerState<CompoundPlaygroundScreen> createState() =>
      _CompoundPlaygroundScreenState();
}

class _CompoundPlaygroundScreenState
    extends ConsumerState<CompoundPlaygroundScreen> {
  final List<ElementModel> _selectedElements = [];
  String? _resultCompound;
  String? _resultFormula;
  Color _liquidColor = const Color(0xFFE0E5EC);

  // Simple reaction master list using localization keys
  final Map<String, Map<String, String>> _reactions = {
    'H,H,O': {
      'nameKey': 'molWater',
      'formula': 'H₂O',
      'factKey': 'factWater',
      'equation': '2H + O → H₂O',
    },
    'Na,Cl': {
      'nameKey': 'molSalt',
      'formula': 'NaCl',
      'factKey': 'factSalt',
      'equation': 'Na + Cl → NaCl',
    },
    'C,O,O': {
      'nameKey': 'molCo2',
      'formula': 'CO₂',
      'factKey': 'factCo2',
      'equation': 'C + 2O → CO₂',
    },
    'H,Cl': {
      'nameKey': 'molHcl',
      'formula': 'HCl',
      'factKey': 'factHcl',
      'equation': 'H + Cl → HCl',
    },
    'C,H,H,H,H': {
      'nameKey': 'molMethane',
      'formula': 'CH₄',
      'factKey': 'factMethane',
      'equation': 'C + 4H → CH₄',
    },
    'N,H,H,H': {
      'nameKey': 'molAmmonia',
      'formula': 'NH₃',
      'factKey': 'factAmmonia',
      'equation': 'N + 3H → NH₃',
    },
    'H,H,O,O,O,O,S': {
      'nameKey': 'molH2so4',
      'formula': 'H₂SO₄',
      'factKey': 'factH2so4',
      'equation': '2H + S + 4O → H₂SO₄',
    },
    'Na,O,H': {
      'nameKey': 'molNaoh',
      'formula': 'NaOH',
      'factKey': 'factNaoh',
      'equation': 'Na + O + H → NaOH',
    },
    'H,H': {
      'nameKey': 'molH2',
      'formula': 'H₂',
      'factKey': 'factH2',
      'equation': 'H + H → H₂',
    },
    'O,O': {
      'nameKey': 'molO2',
      'formula': 'O₂',
      'factKey': 'factO2',
      'equation': 'O + O → O₂',
    },
    'N,N': {
      'nameKey': 'molN2',
      'formula': 'N₂',
      'factKey': 'factN2',
      'equation': 'N + N → N₂',
    },
    'Cl,Cl': {
      'nameKey': 'molCl2',
      'formula': 'Cl₂',
      'factKey': 'factCl2',
      'equation': '2Cl → Cl₂',
    },
    'C,C,H,H,H,H,O,O': {
      'nameKey': 'molAceticAcid',
      'formula': 'CH₃COOH',
      'factKey': 'factAceticAcid',
      'equation': '2C + 4H + 2O → CH₃COOH',
    },
    'C,H,Na,O,O,O': {
      'nameKey': 'molSodiumBicarbonate',
      'formula': 'NaHCO₃',
      'factKey': 'factSodiumBicarbonate',
      'equation': 'Na + H + C + 3O → NaHCO₃',
    },
    'CH₃COOH,NaHCO₃': {
      'nameKey': 'molVolcano',
      'formula': '💥',
      'factKey': 'factVolcano',
      'equation': 'CH₃COOH + NaHCO₃ → 💥',
    },
    'C,H,H,H,H,H,H,H,H,H,H,H,H,Na,O,O': {
      // Simplified Soap (Sodium Laurate C12)
      'nameKey': 'molSoap',
      'formula': 'Soap',
      'factKey': 'factSoap',
      'equation': 'Fat + Lye → Soap',
    },
    'O,O,Ti': {
      'nameKey': 'molTio2',
      'formula': 'TiO₂',
      'factKey': 'factTio2',
      'equation': 'Ti + 2O → TiO₂',
    },
    'O,O,Pt': {
      'nameKey': 'molPto2',
      'formula': 'PtO₂',
      'factKey': 'factPto2',
      'equation': 'Pt + 2O → PtO₂',
    },
    'Cr,O,O,O': {
      'nameKey': 'molCro3',
      'formula': 'CrO₃',
      'factKey': 'factCro3',
      'equation': 'Cr + 3O → CrO₃',
    },
    'Mg,O': {
      'nameKey': 'molMagnesiumOxide',
      'formula': 'MgO',
      'factKey': 'factMagnesiumOxide',
      'equation': 'Mg + O → MgO',
    },
    'Fe,Fe,O,O,O': {
      'nameKey': 'molFe2o3',
      'formula': 'Fe₂O₃',
      'factKey': 'factFe2o3',
      'equation': '2Fe + 3O → Fe₂O₃',
    },
    'Cu,Cl,Cl': {
      'nameKey': 'molCuCl2',
      'formula': 'CuCl₂',
      'factKey': 'factCuCl2',
      'equation': 'Cu + 2Cl → CuCl₂',
    },
    'Ag,Ag,S': {
      'nameKey': 'molAg2s',
      'formula': 'Ag₂S',
      'factKey': 'factAg2s',
      'equation': '2Ag + S → Ag₂S',
    },
    'H,H,O,O': {
      'nameKey': 'molH2o2',
      'formula': 'H₂O₂',
      'factKey': 'factH2o2',
      'equation': '2H + 2O → H₂O₂',
    },
    'C,C,H,H,H,H,H,H,O': {
      'nameKey': 'molEthanol',
      'formula': 'C₂H₅OH',
      'factKey': 'factEthanol',
      'equation': '2C + 6H + O → C₂H₅OH',
    },
    'C,C,C,C,C,C,H,H,H,H,H,H,H,H,H,H,H,H,O,O,O,O,O,O': {
      'nameKey': 'molGlucose',
      'formula': 'C₆H₁₂O₆',
      'factKey': 'factGlucose',
      'equation': '6C + 12H + 6O → C₆H₁₂O₆',
    },
    'O,O,Si': {
      'nameKey': 'molSio2',
      'formula': 'SiO₂',
      'factKey': 'factSio2',
      'equation': 'Si + 2O → SiO₂',
    },
    'C,Ca,O,O,O': {
      'nameKey': 'molCaco3',
      'formula': 'CaCO₃',
      'factKey': 'factCaco3',
      'equation': 'Ca + C + 3O → CaCO₃',
    },
    'Al,Al,O,O,O': {
      'nameKey': 'molAl2o3',
      'formula': 'Al₂O₃',
      'factKey': 'factAl2o3',
      'equation': '2Al + 3O → Al₂O₃',
    },
    'Au,Cl,Cl,Cl': {
      'nameKey': 'molAucl3',
      'formula': 'AuCl₃',
      'factKey': 'factAucl3',
      'equation': 'Au + 3Cl → AuCl₃',
    },
  };

  double _temperature = 25.0; // Celsius
  double _pressure = 1.0; // atm
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
    });
  }

  void _checkReaction() {
    if (_selectedElements.isEmpty) return;

    final localizations = AppLocalizations.of(context)!;
    List<String> symbols = _selectedElements.map((e) => e.symbol).toList()
      ..sort();
    String key = symbols.join(',');

    if (_reactions.containsKey(key)) {
      final reaction = _reactions[key]!;

      // Catalyst check
      bool conditionsMet = true;
      if (reaction['nameKey'] == 'molAmmonia' && _temperature < 400) {
        conditionsMet = false;
      }
      if (reaction['nameKey'] == 'molH2so4' && _temperature < 450) {
        conditionsMet = false;
      }

      if (conditionsMet) {
        HapticFeedback.mediumImpact();
        setState(() {
          _resultCompound = _getLocalizedName(
            reaction['nameKey']!,
            localizations,
          );
          _resultFormula = reaction['formula'];
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
          _liquidColor = _getAverageElementColor().withValues(alpha: 0.3);
        });
      }
    } else {
      setState(() {
        _resultCompound = null;
        _resultFormula = null;
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
    return Color.from(
      alpha: 0.6,
      red: r / len / 255.0,
      green: g / len / 255.0,
      blue: b / len / 255.0,
    );
  }

  Color _getElementColor(String symbol) {
    switch (symbol) {
      case 'H':
        return Colors.white;
      case 'O':
        return Colors.red;
      case 'N':
        return Colors.blue;
      case 'Cl':
        return Colors.green;
      case 'Na':
        return Colors.orange;
      case 'C':
        return Colors.grey;
      case 'S':
        return Colors.yellow;
      case 'Ti':
        return Colors.blueGrey.shade300;
      case 'Cr':
        return Colors.blueGrey.shade100;
      case 'Pt':
        return Colors.grey.shade300;
      case 'Mg':
        return Colors.white70;
      case 'Fe':
        return Colors.brown;
      case 'Cu':
        return Colors.brown.shade300;
      case 'Ag':
        return Colors.grey.shade200;
      case 'Al':
        return Colors.grey.shade400;
      case 'Si':
        return Colors.blueGrey.shade700;
      case 'Ca':
        return Colors.grey.shade100;
      case 'Au':
        return Colors.amber;
      default:
        return Colors.blue;
    }
  }

  Color _getReactionColor(String nameKey) {
    switch (nameKey) {
      case 'molWater':
        return Colors.blue.shade300;
      case 'molSalt':
        return Colors.white;
      case 'molCo2':
        return Colors.grey.shade400;
      case 'molHcl':
        return Colors.greenAccent;
      case 'molMethane':
        return Colors.deepOrangeAccent;
      case 'molAmmonia':
        return Colors.purpleAccent;
      case 'molH2so4':
        return Colors.yellowAccent;
      case 'molNaoh':
        return Colors.white70;
      case 'molH2o2':
        return Colors.blue.withValues(alpha: 0.2);
      case 'molFe2o3':
        return Colors.deepOrange.shade900;
      case 'molEthanol':
        return Colors.blue.withValues(alpha: 0.3);
      case 'molGlucose':
        return Colors.white;
      case 'molSio2':
        return Colors.amber.shade100;
      case 'molCaco3':
        return Colors.grey.shade100;
      case 'molAl2o3':
        return Colors.blue.shade900;
      case 'molAucl3':
        return Colors.red.shade900;
      default:
        return Colors.blue;
    }
  }

  String _getLocalizedName(String key, AppLocalizations local) {
    switch (key) {
      case 'molWater':
        return local.molWater;
      case 'molSalt':
        return local.molSalt;
      case 'molCo2':
        return local.molCo2;
      case 'molHcl':
        return local.molHcl;
      case 'molMethane':
        return local.molMethane;
      case 'molAmmonia':
        return local.molAmmonia;
      case 'molH2so4':
        return local.molH2so4;
      case 'molNaoh':
        return local.molNaoh;
      case 'molH2':
        return local.molH2;
      case 'molO2':
        return local.molO2;
      case 'molN2':
        return local.molN2;
      case 'molCl2':
        return local.molCl2;
      case 'molTio2':
        return local.molTio2;
      case 'molPto2':
        return local.molPto2;
      case 'molCro3':
        return local.molCro3;
      case 'molH2o2':
        return local.molH2o2;
      case 'molFe2o3':
        return local.molFe2o3;
      case 'molEthanol':
        return local.molEthanol;
      case 'molGlucose':
        return local.molGlucose;
      case 'molSio2':
        return local.molSio2;
      case 'molCaco3':
        return local.molCaco3;
      case 'molAl2o3':
        return local.molAl2o3;
      case 'molAucl3':
        return local.molAucl3;
      default:
        return key;
    }
  }

  final bool _isPanelExpanded = false;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.compoundPlayground),
        actions: [
          IconButton(
            onPressed: _showChemistsNotebook,
            icon: const Icon(Icons.menu_book),
          ),
          IconButton(onPressed: _clear, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: PeriodicTableRepository.getElements(localizations),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No elements available.'));
          }

          final allElements = snapshot.data!.cast<ElementModel>();

          return LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 900;

              return Row(
                children: [
                  // Vertical Element Selector Sidebar
                  SizedBox(
                    width: isWide ? 300 : 120,
                    child: _buildVerticalElementSelector(
                      theme,
                      localizations,
                      allElements,
                    ),
                  ),

                  // Main Interactive Area (Mixing Zone + Catalyst)
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: _buildMixingZone(theme, constraints, !isWide),
                        ),
                        _buildCatalystPanel(theme, localizations),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  // Helper to get discovered compounds as ElementModels for the list
  List<ElementModel> _getDiscoveredCompounds() {
    final user = ref.read(currentUserNotifierProvider);
    if (user == null) return [];

    final discoveredIds = user.researchJournal.keys.toSet();
    final models = <ElementModel>[];

    for (final entry in _reactions.values) {
      if (discoveredIds.contains(entry['nameKey'])) {
        models.add(
          ElementModel(
            atomicNumber: -1,
            symbol: entry['formula']!, // Use Formula as symbol for logic
            name: entry['nameKey']!, // Need to localize later
            category: 'Compound',
            categoryType: ElementCategoryType.unknown,
            atomicMass: '',
            summary: entry['factKey']!,
            dailyLifeUse: '',
            discoveredBy: 'You',
            isCompound: true,
            colorValue: _getReactionColor(
              entry['nameKey']!,
            ).value, // ignore: deprecated_member_use
          ),
        );
      }
    }
    return models;
  }

  Widget _buildMixingZone(
    ThemeData theme,
    BoxConstraints constraints,
    bool isMobile,
  ) {
    return DragTarget<ElementModel>(
      onAcceptWithDetails: (details) => _addElement(details.data),
      builder: (context, candidateData, rejectedData) {
        return Container(
          margin: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: candidateData.isNotEmpty
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.primary.withValues(alpha: 0.2),
              width: candidateData.isNotEmpty ? 3.0 : 1.0,
            ),
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

                  if (_resultCompound != null)
                    _buildResultCard(theme, constraints),

                  // Floating Elements
                  ...List.generate(_selectedElements.length, (index) {
                    final element = _selectedElements[index];
                    final angle = (2 * pi / _selectedElements.length) * index;
                    // Adjust radius for mobile vs desktop
                    final activeRadius = isMobile
                        ? 120.0
                        : (constraints.maxWidth > 600 ? 150.0 : 120.0);
                    final inactiveRadius = isMobile
                        ? 80.0
                        : (constraints.maxWidth > 600 ? 100.0 : 80.0);

                    final radius = _resultCompound != null
                        ? activeRadius
                        : inactiveRadius;

                    // Center point calculation might vary slightly if constraints are infinite (in scroll view)
                    // But here we are passed constraints from LayoutBuilder or using fixed Container size
                    // In ScrollView case, we wrapped it in SizedBox(height: 400), so we can use that.

                    return AnimatedPositioned(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.elasticOut,
                      // Use Container center (approximate for simpler math, strict center requires LayoutBuilder inside)
                      left:
                          (isMobile
                              ? MediaQuery.of(context).size.width / 2
                              : constraints.maxWidth / 2) -
                          27 +
                          cos(angle) * radius -
                          16, // -16 margin adjustment
                      top:
                          (isMobile ? 200 : (constraints.maxHeight / 2)) -
                          27 +
                          sin(angle) * radius,
                      child: GestureDetector(
                        onTap: () => _removeElement(index),
                        child: _buildFloatingElement(theme, element),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildResultCard(ThemeData theme, BoxConstraints constraints) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(scale: 0.8 + (0.2 * value), child: child),
        );
      },
      child: SynthesisPulse(
        active: _isSynthesisActive,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: theme.colorScheme.surface.withValues(alpha: 0.1),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InteractiveBeaker(
                fillLevel: 0.8,
                liquidColor: _liquidColor,
                isBubbling: true,
                height: 120, // Smaller for better mobile fit
                width: 90,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _resultFormula!,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        // Smaller font
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (_getActiveEquation() != null)
                    Tooltip(
                      message: _getActiveEquation()!,
                      child: Icon(
                        Icons.info_outline,
                        size: 16,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              if (_getActiveEquation() != null)
                Text(
                  _getActiveEquation()!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                  ),
                ),
              const SizedBox(height: 12),
              _buildJournalButton(theme, AppLocalizations.of(context)!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingElement(ThemeData theme, ElementModel element) {
    return Container(
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
          ),
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
    );
  }

  Widget _buildVerticalElementSelector(
    ThemeData theme,
    AppLocalizations localizations,
    List<ElementModel> allElements,
  ) {
    // Helper to filter elements
    List<ElementModel> getMetals() => allElements
        .where(
          (e) => [
            ElementCategoryType.alkaliMetal,
            ElementCategoryType.alkalineEarth,
            ElementCategoryType.transitionMetal,
            ElementCategoryType.postTransitionMetal,
            ElementCategoryType.lanthanide,
            ElementCategoryType.actinide,
          ].contains(e.categoryType),
        )
        .toList();

    List<ElementModel> getNonMetals() => allElements
        .where(
          (e) => [
            ElementCategoryType.nonmetal,
            ElementCategoryType.halogen,
            ElementCategoryType.nobleGas,
            ElementCategoryType.metalloid,
          ].contains(e.categoryType),
        )
        .toList();

    final compounds = _getDiscoveredCompounds();

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    color: theme.colorScheme.secondary,
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    localizations.compounds,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: theme.colorScheme.primary,
              labelColor: theme.colorScheme.primary,
              unselectedLabelColor: theme.hintColor,
              tabs: const [
                Tab(icon: Icon(Icons.all_inclusive, size: 20)),
                Tab(icon: Icon(Icons.hardware, size: 20)),
                Tab(icon: Icon(Icons.eco, size: 20)),
                Tab(icon: Icon(Icons.biotech, size: 20)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildVerticalElementList(theme, allElements),
                  _buildVerticalElementList(theme, getMetals()),
                  _buildVerticalElementList(theme, getNonMetals()),
                  _buildVerticalElementList(
                    theme,
                    compounds,
                    isCompounds: true,
                    localizations: localizations,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalElementList(
    ThemeData theme,
    List<ElementModel> elements, {
    bool isCompounds = false,
    AppLocalizations? localizations,
  }) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      itemCount: elements.length,
      itemBuilder: (context, index) {
        final element = elements[index];
        final displayName = isCompounds && localizations != null
            ? _getLocalizedName(element.name, localizations)
            : element.name;
        final color = element.colorValue != null
            ? Color(element.colorValue!)
            : _getElementColor(element.symbol);

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Draggable<ElementModel>(
                data: element,
                feedback: Material(
                  type: MaterialType.transparency,
                  child: _buildSimpleToken(color, element.symbol),
                ),
                child: InkWell(
                  onTap: () => _addElement(element),
                  child: _buildSimpleToken(color, element.symbol),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                displayName,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSimpleToken(Color color, String symbol) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
      ),
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  String? _getActiveEquation() {
    List<String> symbols = _selectedElements.map((e) => e.symbol).toList()
      ..sort();
    String key = symbols.join(',');
    return _reactions[key]?['equation'];
  }

  Widget _buildJournalButton(ThemeData theme, AppLocalizations localizations) {
    final user = ref.watch(currentUserNotifierProvider);
    final currentCompoundId = _reactions.entries.firstWhere((e) {
      List<String> symbols = _selectedElements.map((el) => el.symbol).toList()
        ..sort();
      return e.key == symbols.join(',');
    }).value['nameKey'];

    final isDiscovered =
        user?.researchJournal.containsKey(currentCompoundId) ?? false;

    return ElevatedButton.icon(
      onPressed: isDiscovered ? null : () => _saveToJournal(currentCompoundId!),
      icon: Icon(
        isDiscovered ? Icons.check_circle : Icons.bookmark_add_outlined,
      ),
      label: Text(
        isDiscovered ? localizations.saved : localizations.researchJournal,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isDiscovered
            ? Colors.green.withValues(alpha: 0.2)
            : theme.colorScheme.primary,
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
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.thermostat, size: 16, color: Colors.orange),
              const SizedBox(width: 8),
              Text(
                '${_temperature.toInt()}°C',
                style: theme.textTheme.bodySmall,
              ),
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
              Text(
                '${_pressure.toStringAsFixed(1)} atm',
                style: theme.textTheme.bodySmall,
              ),
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

  void _showChemistsNotebook() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => ChemistsNotebookScreen(
        recipes: _reactions,
        onSearch: (query) {
          // Implement search if needed
        },
      ),
    );
  }
}
