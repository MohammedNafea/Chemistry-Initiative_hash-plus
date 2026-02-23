import 'package:flutter/material.dart';
import 'package:chemistry_initiative/features/experiments/data/repositories/experiments_repository.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';
import 'package:chemistry_initiative/features/experiments/presentation/pages/experiment_detail_screen.dart';
import 'package:chemistry_initiative/features/experiments/presentation/pages/chemical_scanner_screen.dart';

class ExperimentsListScreen extends StatelessWidget {
  const ExperimentsListScreen({super.key});

  String _getLocalizedText(AppLocalizations localizations, String key) {
    // Mapping keys to localized getters dynamically via Map or Switch
    // For simplicity in this demo, accessing known keys manualy or falling back
    // In a real app with code gen, this might be handled differently or with a map
    switch (key) {
      case 'volcanoExp':
        return localizations.volcanoExp;
      case 'cabbageExp':
        return localizations.cabbageExp;
      case 'invisibleInkExp':
        return localizations.invisibleInkExp;
      case 'elephantExp':
        return localizations.elephantExp;
      case 'crystalExp':
        return localizations.crystalExp;
      case 'milkArtExp':
        return localizations.milkArtExp;
      case 'oilWaterExp':
        return localizations.oilWaterExp;
      case 'eggExp':
        return localizations.eggExp;
      case 'volcanoDesc':
        return localizations.volcanoDesc;
      case 'cabbageDesc':
        return localizations.cabbageDesc;
      case 'invisibleInkDesc':
        return localizations.invisibleInkDesc;
      case 'elephantDesc':
        return localizations.elephantDesc;
      case 'crystalDesc':
        return localizations.crystalDesc;
      case 'milkArtDesc':
        return localizations.milkArtDesc;
      case 'oilWaterDesc':
        return localizations.oilWaterDesc;
      case 'eggDesc':
        return localizations.eggDesc;
      case 'easy':
        return localizations.easy;
      case 'medium':
        return localizations.medium;
      case 'hard':
        return localizations.hard;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final experiments = ExperimentsRepository.getExperiments();
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(localizations.virtualLab),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChemicalScannerScreen(),
                ),
              );
            },
            icon: const Icon(Icons.qr_code_scanner),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 1;
          double childAspectRatio = 1.3;

          if (constraints.maxWidth > 1200) {
            crossAxisCount = 3;
            childAspectRatio = 1.4;
          } else if (constraints.maxWidth > 600) {
            crossAxisCount = 2;
            childAspectRatio = 1.2;
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: experiments.length,
            itemBuilder: (context, index) {
              final exp = experiments[index];
              final difficulty = _getLocalizedText(
                localizations,
                exp.difficulty,
              );
              Color badgeColor = Colors.green;
              if (exp.difficulty == 'medium') badgeColor = Colors.orange;
              if (exp.difficulty == 'hard') badgeColor = Colors.red;

              return Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ExperimentDetailScreen(experiment: exp),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                theme.colorScheme.primary.withValues(
                                  alpha: 0.1,
                                ),
                                theme.colorScheme.secondary.withValues(
                                  alpha: 0.1,
                                ),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.science_rounded,
                              size: 48,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    _getLocalizedText(localizations, exp.title),
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: badgeColor.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    difficulty,
                                    style: TextStyle(
                                      color: badgeColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _getLocalizedText(localizations, exp.description),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.timer_outlined,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  exp.duration,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
