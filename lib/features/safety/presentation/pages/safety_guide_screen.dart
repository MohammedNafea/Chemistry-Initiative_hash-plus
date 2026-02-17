import 'package:flutter/material.dart';
import 'package:chemistry_initiative/features/safety/data/models/safety_symbol.dart';
import 'package:chemistry_initiative/features/safety/data/repositories/safety_repository.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';

class SafetyGuideScreen extends StatelessWidget {
  const SafetyGuideScreen({super.key});

  String _getLocalizedName(AppLocalizations localizations, String key) {
    // Basic mapping, in a real app these would be in ARB
    switch (key) {
      case 'flammable': return localizations.flammable;
      case 'oxidizer': return localizations.oxidizer;
      case 'toxic': return localizations.toxic;
      case 'corrosive': return localizations.corrosive;
      case 'explosive': return localizations.explosive;
      case 'irritant': return localizations.irritant;
      case 'healthHazard': return localizations.healthHazard;
      case 'environment': return localizations.environment;
      default: return key;
    }
  }

  String _getLocalizedDesc(AppLocalizations localizations, String key) {
    switch (key) {
      case 'flammableDesc': return localizations.flammableDesc;
      case 'oxidizerDesc': return localizations.oxidizerDesc;
      case 'toxicDesc': return localizations.toxicDesc;
      case 'corrosiveDesc': return localizations.corrosiveDesc;
      case 'explosiveDesc': return localizations.explosiveDesc;
      case 'irritantDesc': return localizations.irritantDesc;
      case 'healthHazardDesc': return localizations.healthHazardDesc;
      case 'environmentDesc': return localizations.environmentDesc;
      default: return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final symbols = SafetyRepository.getSymbols();
    final localizations = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.safetyGuide),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemCount: symbols.length,
          itemBuilder: (context, index) {
            final symbol = symbols[index];
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => _SymbolDetailDialog(
                    symbol: symbol,
                    name: _getLocalizedName(localizations, symbol.name),
                    desc: _getLocalizedDesc(localizations, symbol.description),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: isDark ? const Color(0xFF2A2831) : Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(symbol.icon, size: 48, color: symbol.color),
                    const SizedBox(height: 12),
                    Text(
                      _getLocalizedName(localizations, symbol.name),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SymbolDetailDialog extends StatelessWidget {
  final SafetySymbol symbol;
  final String name;
  final String desc;

  const _SymbolDetailDialog({
    required this.symbol,
    required this.name,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: symbol.color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(symbol.icon, size: 64, color: symbol.color),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              desc,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: symbol.color,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('OK'), // TODO: Localize 'Close'/'OK' if needed, but 'OK' is universal-ish
              ),
            ),
          ],
        ),
      ),
    );
  }
}
