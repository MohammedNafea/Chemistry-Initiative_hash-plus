import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chemistry_initiative/features/safety/data/models/safety_symbol.dart';

class SafetyRepository {
  static List<SafetySymbol> getSymbols() {
    return [
      const SafetySymbol(
        id: 'flammable',
        name: 'flammable',
        description: 'flammableDesc',
        icon: FontAwesomeIcons.fire,
        color: Colors.red,
      ),
      const SafetySymbol(
        id: 'oxidizer',
        name: 'oxidizer',
        description: 'oxidizerDesc',
        icon: FontAwesomeIcons.circleNotch, // Approximation for O with flames
        color: Colors.yellow,
      ),
      const SafetySymbol(
        id: 'toxic',
        name: 'toxic',
        description: 'toxicDesc',
        icon: FontAwesomeIcons.skullCrossbones,
        color: Colors.purple,
      ),
      const SafetySymbol(
        id: 'corrosive',
        name: 'corrosive',
        description: 'corrosiveDesc',
        icon: FontAwesomeIcons.flask, // Represents chemical damage
        color: Colors.grey,
      ),
      const SafetySymbol(
        id: 'explosive',
        name: 'explosive',
        description: 'explosiveDesc',
        icon: FontAwesomeIcons.bomb,
        color: Colors.orange,
      ),
      const SafetySymbol(
        id: 'irritant',
        name: 'irritant',
        description: 'irritantDesc',
        icon: FontAwesomeIcons.circleExclamation,
        color: Colors.amber,
      ),
      const SafetySymbol(
        id: 'healthHazard',
        name: 'healthHazard',
        description: 'healthHazardDesc',
        icon: FontAwesomeIcons.heartCrack, // Represents internal health hazard
        color: Colors.brown,
      ),
      const SafetySymbol(
        id: 'environment',
        name: 'environment',
        description: 'environmentDesc',
        icon: FontAwesomeIcons.tree, // Dead tree/fish symbol approximation
        color: Colors.teal,
      ),
    ];
  }
}
