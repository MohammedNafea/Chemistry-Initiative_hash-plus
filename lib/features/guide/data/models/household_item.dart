enum SafetyLevel { safe, caution, danger }

class HouseholdItem {
  final int id;
  final String commonName;
  final String chemicalName;
  final String formula;
  final String description;
  final SafetyLevel safetyLevel;
  final String warning; // e.g., "Do not mix with bleach"

  const HouseholdItem({
    required this.id,
    required this.commonName,
    required this.chemicalName,
    required this.formula,
    required this.description,
    required this.safetyLevel,
    required this.warning,
  });
}
