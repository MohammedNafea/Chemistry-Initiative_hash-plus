class Experiment {
  final String id;
  final String title; // Localization key
  final String description; // Localization key
  final String difficulty; // 'easy', 'medium', 'hard' -> Localization key
  final String duration; // e.g. '15 min'
  final List<String> ingredients; // Localization keys
  final List<String> steps; // Localization keys
  final String explanation; // Localization key (Scientific explanation)
  final String safetyWarning; // Localization key
  final String imagePath; // Asset path

  const Experiment({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.duration,
    required this.ingredients,
    required this.steps,
    required this.explanation,
    required this.safetyWarning,
    required this.imagePath,
  });
}
