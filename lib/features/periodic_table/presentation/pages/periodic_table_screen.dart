import 'package:flutter/material.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';
import 'package:chemistry_initiative/features/periodic_table/data/repositories/periodic_table_repository.dart';
import 'package:chemistry_initiative/features/periodic_table/presentation/widgets/element_card.dart';
import 'package:chemistry_initiative/features/periodic_table/presentation/pages/compound_playground_screen.dart';

class PeriodicTableScreen extends StatelessWidget {
  const PeriodicTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final elements = PeriodicTableRepository.getElements(localizations);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          localizations.periodicTable,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Responsive grid calculation
            final crossAxisCount = constraints.maxWidth > 600 ? 5 : 3;
            
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 0.85, 
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: elements.length,
              itemBuilder: (context, index) {
                return ElementCard(element: elements[index]);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CompoundPlaygroundScreen(),
            ),
          );
        },
        icon: const Icon(Icons.science),
        label: Text(localizations.compoundPlayground),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
    );
  }
}
