class ElementModel {
  final int atomicNumber;
  final String symbol;
  final String name;
  final String category; // e.g., "Noble Gas", "Alkali Metal"
  final String atomicMass;
  final String summary; // Brief scientific description
  final String dailyLifeUse; // The "Daily Life" connection
  final String discoveredBy;

  const ElementModel({
    required this.atomicNumber,
    required this.symbol,
    required this.name,
    required this.category,
    required this.atomicMass,
    required this.summary,
    required this.dailyLifeUse,
    required this.discoveredBy,
  });
}
