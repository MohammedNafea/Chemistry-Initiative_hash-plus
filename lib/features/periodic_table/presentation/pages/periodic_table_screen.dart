import 'package:flutter/material.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';
import 'package:chemistry_initiative/features/periodic_table/data/repositories/periodic_table_repository.dart';
import 'package:chemistry_initiative/features/periodic_table/data/models/element_model.dart';
import 'package:chemistry_initiative/features/periodic_table/presentation/widgets/element_card.dart';
import 'package:chemistry_initiative/features/periodic_table/presentation/pages/compound_playground_screen.dart';

class PeriodicTableScreen extends StatelessWidget {
  const PeriodicTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
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
        child: FutureBuilder<List<ElementModel>>(
          future: PeriodicTableRepository.getElements(localizations),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error loading elements: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No elements found.'));
            }

            final elements = snapshot.data!;

            return LayoutBuilder(
              builder: (context, constraints) {
                // Responsive grid calculation
                int crossAxisCount = 3;
                if (constraints.maxWidth > 1200) {
                  crossAxisCount = 9;
                } else if (constraints.maxWidth > 800) {
                  crossAxisCount = 6;
                } else if (constraints.maxWidth > 600) {
                  crossAxisCount = 4;
                }

                return GridView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 0.9,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: elements.length,
                  itemBuilder: (context, index) {
                    return ElementCard(element: elements[index]);
                  },
                );
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
