import 'package:chemistry_initiative/features/guide/data/models/household_item.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';

class HouseholdItemRepository {
  // TODO: Localize data later
  static List<HouseholdItem> getItems(AppLocalizations localizations) {
    return [
      HouseholdItem(
        id: 1,
        commonName: 'Vinegar',
        chemicalName: 'Acetic Acid',
        formula: 'CH₃COOH',
        description: 'Commonly used in cooking and cleaning.',
        safetyLevel: SafetyLevel.safe,
        warning: 'Safe for consumption in small amounts. Acidic.',
      ),
      HouseholdItem(
        id: 2,
        commonName: 'Baking Soda',
        chemicalName: 'Sodium Bicarbonate',
        formula: 'NaHCO₃',
        description: 'Used in baking and as a mild abrasive cleaner.',
        safetyLevel: SafetyLevel.safe,
        warning: 'Safe. Produces gas when mixed with acid.',
      ),
      HouseholdItem(
        id: 3,
        commonName: 'Bleach',
        chemicalName: 'Sodium Hypochlorite',
        formula: 'NaOCl',
        description: 'Strong disinfectant and whitener.',
        safetyLevel: SafetyLevel.danger,
        warning: 'DANGER: Never mix with Vinegar or Ammonia! Produces toxic gas.',
      ),
      HouseholdItem(
        id: 4,
        commonName: 'Table Salt',
        chemicalName: 'Sodium Chloride',
        formula: 'NaCl',
        description: 'Essential for life, used for seasoning.',
        safetyLevel: SafetyLevel.safe,
        warning: 'Safe. Excessive intake can raise blood pressure.',
      ),
      HouseholdItem(
        id: 5,
        commonName: 'Ammonia',
        chemicalName: 'Ammonium Hydroxide',
        formula: 'NH₄OH',
        description: 'Common glass cleaner.',
        safetyLevel: SafetyLevel.caution,
        warning: 'Irritating fumes. Do not mix with bleach.',
      ),
      HouseholdItem(
        id: 6,
        commonName: 'Sugar',
        chemicalName: 'Sucrose',
        formula: 'C₁₂H₂₂O₁₁',
        description: 'Sweetener found in many foods.',
        safetyLevel: SafetyLevel.safe,
        warning: 'Safe. High consumption leads to health issues.',
      ),
      HouseholdItem(
        id: 7,
        commonName: 'Nail Polish Remover',
        chemicalName: 'Acetone',
        formula: '(CH₃)₂CO',
        description: 'Solvent for removing nail polish and glue.',
        safetyLevel: SafetyLevel.caution,
        warning: 'flammable. Keep away from fire.',
      ),
    ];
  }
}
