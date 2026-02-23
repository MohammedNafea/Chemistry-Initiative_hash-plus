import 'package:chemistry_initiative/features/guide/data/models/household_item.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';

class HouseholdItemRepository {
  // TODO: Localize data later
  static List<HouseholdItem> getItems(AppLocalizations localizations) {
    return [
      HouseholdItem(
        id: 1,
        commonName: localizations.hhVinegar,
        chemicalName: localizations.hhVinegarChem,
        formula: 'CH₃COOH',
        description: localizations.hhVinegarDesc,
        safetyLevel: SafetyLevel.safe,
        warning: localizations.hhVinegarWarn,
      ),
      HouseholdItem(
        id: 2,
        commonName: localizations.hhBakingSoda,
        chemicalName: localizations.hhBakingSodaChem,
        formula: 'NaHCO₃',
        description: localizations.hhBakingSodaDesc,
        safetyLevel: SafetyLevel.safe,
        warning: localizations.hhBakingSodaWarn,
      ),
      HouseholdItem(
        id: 3,
        commonName: localizations.hhBleach,
        chemicalName: localizations.hhBleachChem,
        formula: 'NaOCl',
        description: localizations.hhBleachDesc,
        safetyLevel: SafetyLevel.danger,
        warning: localizations.hhBleachWarn,
      ),
      HouseholdItem(
        id: 4,
        commonName: localizations.hhSalt,
        chemicalName: localizations.hhSaltChem,
        formula: 'NaCl',
        description: localizations.hhSaltDesc,
        safetyLevel: SafetyLevel.safe,
        warning: localizations.hhSaltWarn,
      ),
      HouseholdItem(
        id: 5,
        commonName: localizations.hhAmmonia,
        chemicalName: localizations.hhAmmoniaChem,
        formula: 'NH₄OH',
        description: localizations.hhAmmoniaDesc,
        safetyLevel: SafetyLevel.caution,
        warning: localizations.hhAmmoniaWarn,
      ),
      HouseholdItem(
        id: 6,
        commonName: localizations.hhSugar,
        chemicalName: localizations.hhSugarChem,
        formula: 'C₁₂H₂₂O₁₁',
        description: localizations.hhSugarDesc,
        safetyLevel: SafetyLevel.safe,
        warning: localizations.hhSugarWarn,
      ),
      HouseholdItem(
        id: 7,
        commonName: localizations.hhNailPolish,
        chemicalName: localizations.hhNailPolishChem,
        formula: '(CH₃)₂CO',
        description: localizations.hhNailPolishDesc,
        safetyLevel: SafetyLevel.caution,
        warning: localizations.hhNailPolishWarn,
      ),
    ];
  }
}
