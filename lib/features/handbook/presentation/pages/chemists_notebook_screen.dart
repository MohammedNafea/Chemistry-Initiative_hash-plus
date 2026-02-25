import 'package:flutter/material.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';
import 'package:chemistry_initiative/features/periodic_table/data/repositories/periodic_table_repository.dart';
import 'package:chemistry_initiative/core/database/app_database.dart';

class ChemistsNotebookScreen extends StatefulWidget {
  final Map<String, Map<String, String>> recipes;
  final Function(String query) onSearch; // Placeholder for search

  const ChemistsNotebookScreen({
    super.key,
    required this.recipes,
    required this.onSearch,
  });

  @override
  State<ChemistsNotebookScreen> createState() => _ChemistsNotebookScreenState();
}

class _ChemistsNotebookScreenState extends State<ChemistsNotebookScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    final size = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.8,
        constraints: const BoxConstraints(maxWidth: 800, maxHeight: 800),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.3,
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.menu_book_rounded,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      localizations.chemistsNotebook, // Updated from Lab Manual
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Tabs
            TabBar(
              controller: _tabController,
              labelColor: theme.colorScheme.primary,
              unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
              indicatorColor: theme.colorScheme.primary,
              tabs: [
                Tab(
                  text: localizations.recipes,
                  icon: const Icon(Icons.science),
                ),
                Tab(
                  text: localizations.journal,
                  icon: const Icon(Icons.history_edu),
                ),
                Tab(
                  text: localizations.dictionary,
                  icon: const Icon(Icons.library_books),
                ),
              ],
            ),

            // Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildRecipesTab(localizations, theme),
                  _buildJournalTab(localizations, theme),
                  _buildDictionaryTab(localizations, theme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipesTab(AppLocalizations localizations, ThemeData theme) {
    if (widget.recipes.isEmpty) {
      return Center(child: Text(localizations.noData));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.recipes.length,
      itemBuilder: (context, index) {
        final key = widget.recipes.keys.elementAt(index);
        final data = widget.recipes[key]!;
        final name = _getLocalizedName(data['nameKey']!, localizations);

        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                data['formula'] ?? '?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            title: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  data['equation'] ?? '',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildJournalTab(AppLocalizations localizations, ThemeData theme) {
    // Get current user synchronously
    final user = AppDatabase.instance.currentUser;
    final journal = user?.researchJournal ?? {};

    if (journal.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_clock,
              size: 48,
              color: theme.colorScheme.tertiary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(localizations.noData, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(localizations.undiscovered, style: theme.textTheme.bodySmall),
          ],
        ),
      );
    }

    final discoveries = journal.entries.map((e) {
      final recipe = widget.recipes[e.key];
      return {
        'id': e.key,
        'name': recipe?['nameKey'] ?? e.key,
        'formula': recipe?['formula'] ?? '?',
        'date': e.value,
      };
    }).toList();

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: discoveries.length,
      itemBuilder: (context, index) {
        final discovery = discoveries[index];
        final name = _getLocalizedName(
          discovery['name'] as String,
          localizations,
        );

        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.tertiary.withValues(alpha: 0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.tertiary.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 24),
              const SizedBox(height: 8),
              Text(
                discovery['formula'] as String,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDictionaryTab(AppLocalizations localizations, ThemeData theme) {
    return FutureBuilder<List<dynamic>>(
      future: PeriodicTableRepository.getElements(localizations),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No elements available.'));
        }

        final elements = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: elements.length,
          itemBuilder: (context, index) {
            final element = elements[index];
            return Card(
              elevation: 0,
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.3,
              ),
              margin: const EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    element.symbol,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  element.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  element.category,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                trailing: Text(
                  element.atomicNumber.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
} // End of class

// Helper to localize names
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
