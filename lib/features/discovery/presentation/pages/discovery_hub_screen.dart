import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/features/auth/data/current_user_provider.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';

class DiscoveryHubScreen extends ConsumerWidget {
  const DiscoveryHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserNotifierProvider);
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final discoveries = user?.researchJournal.entries.toList() ?? [];
    discoveries.sort((a, b) => b.value.compareTo(a.value)); // Newest first

    return Scaffold(
      backgroundColor: Colors.transparent, // Background handled by HomePage stack
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
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
                    '${discoveries.length} ${localizations.discoveries}',
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: discoveries.isEmpty
                  ? _buildEmptyState(localizations, theme)
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: discoveries.length,
                      itemBuilder: (context, index) {
                        final entry = discoveries[index];
                        return _buildDiscoveryCard(context, entry.key, entry.value, theme, localizations);
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
          Icon(FontAwesomeIcons.flaskVial, size: 64, color: theme.colorScheme.primary.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          Text(
            local.noResults,
            style: TextStyle(color: theme.colorScheme.primary.withValues(alpha: 0.5)),
          ),
          const SizedBox(height: 8),
          Text(
            "Start mixing in the Compound Playground!",
            style: TextStyle(fontSize: 12, color: theme.hintColor),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoveryCard(BuildContext context, String compoundId, String date, ThemeData theme, AppLocalizations local) {
    final name = _getLocalizedName(compoundId, local);
    final formula = _getFormula(compoundId);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.cardColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
    );
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

  String _getLocalizedFact(String compoundId, AppLocalizations local) {
    switch (compoundId) {
      case 'molWater': return local.factWater;
      case 'molSalt': return local.factSalt;
      case 'molCo2': return local.factCo2;
      case 'molHcl': return local.factHcl;
      case 'molMethane': return local.factMethane;
      case 'molAmmonia': return local.factAmmonia;
      case 'molH2so4': return local.factH2so4;
      default: return 'A fascinating chemical compound discovery.';
    }
  }

  String _getFormula(String nameKey) {
    switch (nameKey) {
      case 'molWater': return 'H₂O';
      case 'molSalt': return 'NaCl';
      case 'molCo2': return 'CO₂';
      case 'molHcl': return 'HCl';
      case 'molMethane': return 'CH₄';
      case 'molAmmonia': return 'NH₃';
      case 'molH2so4': return 'H₂SO₄';
      default: return '???';
    }
  }
}
