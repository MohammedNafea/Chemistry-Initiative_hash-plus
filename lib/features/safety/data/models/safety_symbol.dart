import 'package:flutter/material.dart';

class SafetySymbol {
  final String id;
  final String name; // Localization key
  final String description; // Localization key
  final IconData icon;
  final Color color;

  const SafetySymbol({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}
