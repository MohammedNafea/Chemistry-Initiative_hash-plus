import 'package:flutter/material.dart';
import 'package:chemistry_initiative/features/experiments/data/models/experiment.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';

class ExperimentDetailScreen extends StatefulWidget {
  final Experiment experiment;

  const ExperimentDetailScreen({super.key, required this.experiment});

  @override
  State<ExperimentDetailScreen> createState() => _ExperimentDetailScreenState();
}

class _ExperimentDetailScreenState extends State<ExperimentDetailScreen> with SingleTickerProviderStateMixin {
  bool _isSimulating = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startSimulation() {
    if (_isSimulating) return;
    setState(() => _isSimulating = true);
    _animationController.forward(from: 0).then((_) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() => _isSimulating = false);
        }
      });
    });
  }

  String _getLocalizedText(AppLocalizations localizations, String key) {
     // Dynamic fallback for demo
    switch (key) {
      // Titles & Descs
      case 'volcanoExp': return localizations.volcanoExp;
      case 'cabbageExp': return localizations.cabbageExp;
      case 'invisibleInkExp': return localizations.invisibleInkExp;
      case 'volcanoDesc': return localizations.volcanoDesc;
      case 'cabbageDesc': return localizations.cabbageDesc;
      case 'invisibleInkDesc': return localizations.invisibleInkDesc;
      
      // Safety
      case 'generalSafety': return localizations.generalSafety;
      case 'hotWaterSafety': return localizations.hotWaterSafety;
      case 'heatSafety': return localizations.heatSafety;

      // Explanation
      case 'volcanoExplanation': return localizations.volcanoExplanation;
      case 'cabbageExplanation': return localizations.cabbageExplanation;
      case 'inkExplanation': return localizations.inkExplanation;

      // Ingredients
      case 'bakingSoda': return localizations.bakingSoda;
      case 'vinegar': return localizations.vinegar;
      case 'foodColoring': return localizations.foodColoring;
      case 'dishSoap': return localizations.dishSoap;
      case 'container': return localizations.container;
      case 'redCabbage': return localizations.redCabbage;
      case 'water': return localizations.water;
      case 'lemonJuice': return localizations.lemonJuice;
      case 'cups': return localizations.cups;
      case 'cottonSwab': return localizations.cottonSwab;
      case 'whitePaper': return localizations.whitePaper;
      case 'heatSource': return localizations.heatSource;

      // Steps
      case 'volcanoStep1': return localizations.volcanoStep1;
      case 'volcanoStep2': return localizations.volcanoStep2;
      case 'volcanoStep3': return localizations.volcanoStep3;
      case 'volcanoStep4': return localizations.volcanoStep4;
      
      case 'cabbageStep1': return localizations.cabbageStep1;
      case 'cabbageStep2': return localizations.cabbageStep2;
      case 'cabbageStep3': return localizations.cabbageStep3;
      case 'cabbageStep4': return localizations.cabbageStep4;

      case 'inkStep1': return localizations.inkStep1;
      case 'inkStep2': return localizations.inkStep2;
      case 'inkStep3': return localizations.inkStep3;

      default: return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final title = _getLocalizedText(localizations, widget.experiment.title);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Interactive Simulation Zone
            GestureDetector(
              onTap: _startSimulation,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Container(
                    height: 220,
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.colorScheme.primary.withValues(alpha: 0.1),
                          theme.colorScheme.secondary.withValues(alpha: 0.1),
                        ],
                      ),
                      border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.2)),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Experiment-specific effects
                        if (_isSimulating)
                          ...List.generate(12, (index) {
                            final val = (_animationController.value * 1.5 + (index * 0.1)) % 1.0;
                            Color effectColor = theme.colorScheme.secondary;
                            IconData effectIcon = Icons.blur_on;

                            if (widget.experiment.title == 'volcanoExp') {
                              effectColor = Colors.orangeAccent;
                              effectIcon = Icons.local_fire_department;
                            } else if (widget.experiment.title == 'cabbageExp') {
                              effectColor = index % 2 == 0 ? Colors.purple : Colors.pink;
                              effectIcon = Icons.water_drop;
                            } else if (widget.experiment.title == 'invisibleInkExp') {
                              effectColor = Colors.lightBlueAccent;
                              effectIcon = Icons.auto_fix_high;
                            }

                            return Positioned(
                              bottom: 60 + (val * 120),
                              left: 80 + (index * 25.0 % 200),
                              child: Opacity(
                                opacity: (1.0 - val).clamp(0.0, 1.0),
                                child: Transform.scale(
                                  scale: 0.5 + val,
                                  child: Icon(effectIcon, size: 24, color: effectColor.withValues(alpha: 0.6)),
                                ),
                              ),
                            );
                          }),

                        // Eruption effect for volcano
                        if (_isSimulating && widget.experiment.title == 'volcanoExp')
                           Positioned(
                            top: 40,
                            child: Opacity(
                              opacity: _animationController.value < 0.5 ? _animationController.value * 2 : (1 - _animationController.value) * 2,
                              child: Icon(Icons.volcano, size: 120, color: Colors.deepOrange.withValues(alpha: 0.4)),
                            ),
                          ),

                        Transform.rotate(
                          angle: _isSimulating ? _animationController.value * 0.2 : 0,
                          child: Icon(
                            _isSimulating ? Icons.science : Icons.science_outlined, 
                            size: 100, 
                            color: _isSimulating 
                                ? (widget.experiment.title == 'cabbageExp' ? Colors.purple : theme.colorScheme.secondary) 
                                : Colors.blueAccent
                          ),
                        ),
                        
                        Positioned(
                          bottom: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  _isSimulating ? Icons.loop : Icons.touch_app, 
                                  size: 16, 
                                  color: theme.colorScheme.primary
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _isSimulating ? 'Reaction in progress...' : 'Tap to simulate reaction',
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),

            // Safety Warning
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                   Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.priority_high, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Safety First',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getLocalizedText(localizations, widget.experiment.safetyWarning),
                          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red[900]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Ingredients
            Text(
              localizations.ingredients,
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.experiment.ingredients.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline, size: 20, color: theme.colorScheme.secondary),
                      const SizedBox(width: 12),
                      Text(
                        _getLocalizedText(localizations, widget.experiment.ingredients[index]),
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 32),
            
            // Steps
            Text(
              localizations.steps,
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 12),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.experiment.steps.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.05)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          _getLocalizedText(localizations, widget.experiment.steps[index]),
                          style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 40),

            // Scientific Explanation (Glassmorphism card)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.lightbulb_outline, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        localizations.scientificExplanation,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                     _getLocalizedText(localizations, widget.experiment.explanation),
                     style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
