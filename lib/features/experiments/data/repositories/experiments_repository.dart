import 'package:chemistry_initiative/features/experiments/data/models/experiment.dart';

class ExperimentsRepository {
  static List<Experiment> getExperiments() {
    return [
      const Experiment(
        id: 'volcano',
        title: 'volcanoExp',
        description: 'volcanoDesc',
        difficulty: 'easy',
        duration: '15 min',
        ingredients: [
          'bakingSoda',
          'vinegar',
          'foodColoring',
          'dishSoap',
          'container',
        ],
        steps: [
          'volcanoStep1',
          'volcanoStep2',
          'volcanoStep3',
          'volcanoStep4',
        ],
        explanation: 'volcanoExplanation',
        safetyWarning: 'generalSafety',
        imagePath: 'assets/images/volcano.png', // Placeholder, use generic if needed
      ),
      const Experiment(
        id: 'cabbageIndicator',
        title: 'cabbageExp',
        description: 'cabbageDesc',
        difficulty: 'medium',
        duration: '30 min',
        ingredients: [
          'redCabbage',
          'water',
          'lemonJuice',
          'bakingSoda',
          'cups',
        ],
        steps: [
          'cabbageStep1',
          'cabbageStep2',
          'cabbageStep3',
          'cabbageStep4',
        ],
        explanation: 'cabbageExplanation',
        safetyWarning: 'hotWaterSafety',
        imagePath: 'assets/images/cabbage.png',
      ),
      const Experiment(
        id: 'invisibleInk',
        title: 'invisibleInkExp',
        description: 'invisibleInkDesc',
        difficulty: 'easy',
        duration: '10 min',
        ingredients: [
          'lemonJuice',
          'cottonSwab',
          'whitePaper',
          'heatSource', // lamp or iron
        ],
        steps: [
          'inkStep1',
          'inkStep2',
          'inkStep3',
        ],
        explanation: 'inkExplanation',
        safetyWarning: 'heatSafety',
        imagePath: 'assets/images/ink.png',
      ),
    ];
  }
}
