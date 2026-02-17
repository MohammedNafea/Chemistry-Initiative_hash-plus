import 'package:chemistry_initiative/features/periodic_table/data/models/element_model.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';

class DailyChemicalRepository {
  static ElementModel getChemicalOfTheDay(AppLocalizations localizations) {
    final chemicals = [
      ElementModel(
        atomicNumber: 8,
        symbol: 'O',
        name: localizations.chemOxygen, // Using localization keys
        category: 'Nonmetal',
        atomicMass: '15.999',
        summary: localizations.chemOxygenUse, // Reusing use as summary for brevity
        dailyLifeUse: localizations.chemOxygenUse,
        discoveredBy: 'Carl Wilhelm Scheele',
      ),
      ElementModel(
        atomicNumber: 79,
        symbol: 'Au',
        name: localizations.chemGold,
        category: 'Transition Metal',
        atomicMass: '196.97',
        summary: localizations.chemGoldUse,
        dailyLifeUse: localizations.chemGoldUse,
        discoveredBy: 'Known since antiquity',
      ),
       ElementModel(
        atomicNumber: 6,
        symbol: 'C',
        name: localizations.chemCarbon,
        category: 'Nonmetal',
        atomicMass: '12.011',
        summary: localizations.chemCarbonUse,
        dailyLifeUse: localizations.chemCarbonUse,
        discoveredBy: 'Known since antiquity',
      ),
    ];

    final dayOfYear = int.parse("${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}"); 
    // Simple hash or just DayOfYear. Using explicit date to avoid issues.
    // Actually DateTime.now().difference(DateTime(year, 1, 1)).inDays is better but this is fine.
    
    final index = dayOfYear % chemicals.length;
    return chemicals[index];
  }
}
