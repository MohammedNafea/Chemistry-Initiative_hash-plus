import 'package:chemistry_initiative/features/quiz/data/models/quiz_question.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';

class QuizRepository {
  // TODO: Localization support for questions in the future if needed
  static List<QuizQuestion> getQuestions(AppLocalizations localizations) {
    return [
      QuizQuestion(
        id: 1,
        question: 'What is the chemical symbol for Gold?',
        options: ['Ag', 'Au', 'Gd', 'Go'],
        correctIndex: 1,
        explanation: 'Au comes from the Latin word "Aurum".',
      ),
      QuizQuestion(
        id: 2,
        question: 'Which gas do plants absorb from the atmosphere?',
        options: ['Oxygen', 'Nitrogen', 'Carbon Dioxide', 'Hydrogen'],
        correctIndex: 2,
        explanation: 'Plants absorb Carbon Dioxide (CO2) for photosynthesis.',
      ),
      QuizQuestion(
        id: 3,
        question: 'What is the most abundant gas in Earth\'s atmosphere?',
        options: ['Oxygen', 'Nitrogen', 'Carbon Dioxide', 'Argon'],
        correctIndex: 1,
        explanation: 'Nitrogen makes up about 78% of Earth\'s atmosphere.',
      ),
      QuizQuestion(
        id: 4,
        question: 'What is the pH level of pure water?',
        options: ['0', '7', '14', '5'],
        correctIndex: 1,
        explanation: 'Pure water is neutral, which is pH 7.',
      ),
      QuizQuestion(
        id: 5,
        question: 'Which element is needed for strong bones?',
        options: ['Potassium', 'Iron', 'Calcium', 'Zinc'],
        correctIndex: 2,
        explanation: 'Calcium is essential for bone structure and strength.',
      ),
    ];
  }
}
