import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/features/auth/data/current_user_provider.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';
import 'package:chemistry_initiative/features/molecules/presentation/pages/molecule_viewer_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';

class DiscoveryHubScreen extends ConsumerStatefulWidget {
  const DiscoveryHubScreen({super.key});

  @override
  ConsumerState<DiscoveryHubScreen> createState() => _DiscoveryHubScreenState();
}

class _DiscoveryHubScreenState extends ConsumerState<DiscoveryHubScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserNotifierProvider);
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final discoveries = user?.researchJournal.entries.toList() ?? [];

    // Filtered discoveries
    final filteredDiscoveries = discoveries.where((entry) {
      final name = _getLocalizedName(entry.key, localizations).toLowerCase();
      final formula = _getFormula(entry.key).toLowerCase();
      return name.contains(_searchQuery.toLowerCase()) ||
          formula.contains(_searchQuery.toLowerCase());
    }).toList();

    filteredDiscoveries.sort(
      (a, b) => b.value.compareTo(a.value),
    ); // Newest first

    return Scaffold(
      backgroundColor:
          Colors.transparent, // Background handled by HomePage stack
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.researchJournal,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${filteredDiscoveries.length} ${localizations.discoveries}',
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Search Bar
                  TextField(
                    controller: _searchController,
                    onChanged: (val) => setState(() => _searchQuery = val),
                    decoration: InputDecoration(
                      hintText: localizations.searchCompounds,
                      prefixIcon: const Icon(Icons.search_rounded),
                      filled: true,
                      fillColor: theme.cardColor.withValues(alpha: 0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: filteredDiscoveries.isEmpty
                  ? _buildEmptyState(localizations, theme)
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredDiscoveries.length,
                      itemBuilder: (context, index) {
                        final entry = filteredDiscoveries[index];
                        return _buildDiscoveryCard(
                          context,
                          entry.key,
                          entry.value,
                          theme,
                          localizations,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations local, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.flaskVial,
            size: 64,
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isEmpty
                ? local.noResults
                : "No records found for '$_searchQuery'",
            style: TextStyle(
              color: theme.colorScheme.primary.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 8),
          if (_searchQuery.isEmpty)
            Text(
              "Start mixing in the Compound Playground!",
              style: TextStyle(fontSize: 12, color: theme.hintColor),
            ),
        ],
      ),
    );
  }

  Widget _buildDiscoveryCard(
    BuildContext context,
    String compoundId,
    String date,
    ThemeData theme,
    AppLocalizations local,
  ) {
    final name = _getLocalizedName(compoundId, local);
    final formula = _getFormula(compoundId);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.cardColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: InkWell(
            onTap: () => _showCompoundDetails(
              context,
              compoundId,
              name,
              formula,
              local,
              theme,
            ),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        formula,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getLocalizedFact(compoundId, local),
                          style: theme.textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showCompoundDetails(
    BuildContext context,
    String id,
    String name,
    String formula,
    AppLocalizations local,
    ThemeData theme,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    formula,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    name,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              local.scientificInsight,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _getLocalizedFact(id, local),
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            if (id == 'molWater')
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MoleculeViewerScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.view_in_ar_rounded),
                  label: Text(local.viewIn3D),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.check_circle_outline),
                label: Text(local.gotIt),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
      default:
        return 'Compound';
    }
  }

  String _getLocalizedFact(String compoundId, AppLocalizations local) {
    switch (compoundId) {
      case 'molWater':
        return local.factWater;
      case 'molSalt':
        return local.factSalt;
      case 'molCo2':
        return local.factCo2;
      case 'molHcl':
        return local.factHcl;
      case 'molMethane':
        return local.factMethane;
      case 'molAmmonia':
        return local.factAmmonia;
      case 'molH2so4':
        return local.factH2so4;
      default:
        return 'A fascinating chemical compound discovery.';
    }
  }

  String _getFormula(String nameKey) {
    switch (nameKey) {
      case 'molWater':
        return 'H₂O';
      case 'molSalt':
        return 'NaCl';
      case 'molCo2':
        return 'CO₂';
      case 'molHcl':
        return 'HCl';
      case 'molMethane':
        return 'CH₄';
      case 'molAmmonia':
        return 'NH₃';
      case 'molH2so4':
        return 'H₂SO₄';
      default:
        return '???';
    }
  }
}
