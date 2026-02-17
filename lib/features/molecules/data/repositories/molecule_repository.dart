import 'package:chemistry_initiative/features/molecules/data/models/molecule.dart';

class MoleculeRepository {
  static List<Molecule> getMolecules() {
    return [
      const Molecule(
        id: 'water',
        name: 'molWater',
        formula: 'H₂O',
        description: 'factWater',
        imagePath: 'assets/images/molecules/water.png',
        category: 'Inorganic',
      ),
      const Molecule(
        id: 'co2',
        name: 'molCo2',
        formula: 'CO₂',
        description: 'factCo2',
        imagePath: 'assets/images/molecules/co2.png',
        category: 'Inorganic',
      ),
      const Molecule(
        id: 'methane',
        name: 'molMethane',
        formula: 'CH₄',
        description: 'factMethane',
        imagePath: 'assets/images/molecules/methane.png',
        category: 'Organic',
      ),
      const Molecule(
        id: 'salt',
        name: 'molSalt',
        formula: 'NaCl',
        description: 'factSalt',
        imagePath: 'assets/images/molecules/salt.png',
        category: 'Salt',
      ),
    ];
  }
}
