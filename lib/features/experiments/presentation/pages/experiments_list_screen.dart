import 'package:flutter/material.dart';
import 'package:chemistry_initiative/features/experiments/data/repositories/experiments_repository.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';
import 'package:chemistry_initiative/features/experiments/presentation/pages/experiment_detail_screen.dart';

class ExperimentsListScreen extends StatelessWidget {
  const ExperimentsListScreen({super.key});

  String _getLocalizedText(AppLocalizations localizations, String key) {
    // Mapping keys to localized getters dynamically via Map or Switch
    // For simplicity in this demo, accessing known keys manualy or falling back
    // In a real app with code gen, this might be handled differently or with a map
    switch (key) {
      case 'volcanoExp': return localizations.volcanoExp;
      case 'cabbageExp': return localizations.cabbageExp;
      case 'invisibleInkExp': return localizations.invisibleInkExp;
      case 'volcanoDesc': return localizations.volcanoDesc;
      case 'cabbageDesc': return localizations.cabbageDesc;
      case 'invisibleInkDesc': return localizations.invisibleInkDesc;
      case 'easy': return localizations.easy;
      case 'medium': return localizations.medium;
      case 'hard': return localizations.hard;
      default: return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final experiments = ExperimentsRepository.getExperiments();
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.virtualLab),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: experiments.length,
        itemBuilder: (context, index) {
          final exp = experiments[index];
          final difficulty = _getLocalizedText(localizations, exp.difficulty);
          Color badgeColor = Colors.green;
          if (exp.difficulty == 'medium') badgeColor = Colors.orange;
          if (exp.difficulty == 'hard') badgeColor = Colors.red;

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExperimentDetailScreen(experiment: exp),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Placeholder for image or icon
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[800] : Colors.grey[200],
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Center(
                      child: Icon(Icons.science, size: 48, color: theme.colorScheme.primary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _getLocalizedText(localizations, exp.title),
                              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: badgeColor.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                difficulty,
                                style: TextStyle(color: badgeColor, fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getLocalizedText(localizations, exp.description),
                          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.timer, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(exp.duration, style: theme.textTheme.bodySmall),
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
      ),
    );
  }
}
