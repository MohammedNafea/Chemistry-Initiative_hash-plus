class Molecule {
  final String id;
  final String name; // Localization key
  final String formula; // e.g. H2O
  final String description; // Localization key
  final String imagePath; // Asset path (2D image for now)
  final String category; // Organic, Inorganic, etc.

  const Molecule({
    required this.id,
    required this.name,
    required this.formula,
    required this.description,
    required this.imagePath,
    required this.category,
  });
}
