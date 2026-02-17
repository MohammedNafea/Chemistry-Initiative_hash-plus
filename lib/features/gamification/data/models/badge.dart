class Badge {
  final String id;
  final String name; // Localization key
  final String description; // Localization key
  final String iconPath; // Asset path
  final String condition; // e.g. 'login_1', 'quiz_5'

  const Badge({
    required this.id,
    required this.name,
    required this.description,
    required this.iconPath,
    required this.condition,
  });
}
