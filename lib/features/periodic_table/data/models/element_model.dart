enum ElementCategoryType {
  alkaliMetal,
  alkalineEarth,
  transitionMetal,
  postTransitionMetal,
  metalloid,
  nonmetal,
  halogen,
  nobleGas,
  lanthanide,
  actinide,
  unknown,
}

class ElementModel {
  final int atomicNumber;
  final String symbol;
  final String name;
  final String category; // e.g., "Noble Gas", "Alkali Metal"
  final ElementCategoryType categoryType;
  final String atomicMass;
  final String summary; // Brief scientific description
  final String dailyLifeUse; // The "Daily Life" connection
  final String discoveredBy;
  final bool isCompound;
  final int?
  colorValue; // Store color as int to avoid Flutter dependency in data layer if strictly needed, but Color is fine here if flutter/material is imported.
  // Actually ElementModel imports nothing currently. I need to import dart:ui or flutter/material for Color.
  // Or just store int and convert.
  // Let's import dart:ui.

  const ElementModel({
    required this.atomicNumber,
    required this.symbol,
    required this.name,
    required this.category,
    this.categoryType = ElementCategoryType.unknown,
    required this.atomicMass,
    required this.summary,
    required this.dailyLifeUse,
    required this.discoveredBy,
    this.isCompound = false,
    this.colorValue,
  });
}
