import 'package:chemistry_initiative/features/quiz/data/models/quiz_question.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';

class QuizRepository {
  static List<QuizQuestion> getQuestions(AppLocalizations l) {
    final String lang = l.localeName;
    final bool isAr = lang == 'ar';

    return [
      QuizQuestion(
        id: 1,
        question: isAr
            ? 'ما هو الرمز الكيميائي للذهب؟'
            : 'What is the chemical symbol for Gold?',
        options: ['Ag', 'Au', 'Gd', 'Go'],
        correctIndex: 1,
        explanation: isAr
            ? 'Au يأتي من الكلمة اللاتينية "Aurum".'
            : 'Au comes from the Latin word "Aurum".',
      ),
      QuizQuestion(
        id: 2,
        question: isAr
            ? 'أي غاز تمتصه النباتات من الغلاف الجوي؟'
            : 'Which gas do plants absorb from the atmosphere?',
        options: isAr
            ? ['الأكسجين', 'النيتروجين', 'ثاني أكسيد الكربون', 'الهيدروجين']
            : ['Oxygen', 'Nitrogen', 'Carbon Dioxide', 'Hydrogen'],
        correctIndex: 2,
        explanation: isAr
            ? 'تمتص النباتات ثاني أكسيد الكربون (CO2) لعملية التمثيل الضوئي.'
            : 'Plants absorb Carbon Dioxide (CO2) for photosynthesis.',
      ),
      QuizQuestion(
        id: 3,
        question: isAr
            ? 'ما هو أكثر الغازات وفرة في الغلاف الجوي للأرض؟'
            : 'What is the most abundant gas in Earth\'s atmosphere?',
        options: isAr
            ? ['الأكسجين', 'النيتروجين', 'ثاني أكسيد الكربون', 'الأرجون']
            : ['Oxygen', 'Nitrogen', 'Carbon Dioxide', 'Argon'],
        correctIndex: 1,
        explanation: isAr
            ? 'يشكل النيتروجين حوالي 78% من الغلاف الجوي للأرض.'
            : 'Nitrogen makes up about 78% of Earth\'s atmosphere.',
      ),
      QuizQuestion(
        id: 4,
        question: isAr
            ? 'ما هو مستوى الأس الهيدروجيني (pH) للماء النقي؟'
            : 'What is the pH level of pure water?',
        options: ['0', '7', '14', '5'],
        correctIndex: 1,
        explanation: isAr
            ? 'الماء النقي متعادل، أي أن الأس الهيدروجيني له يساوي 7.'
            : 'Pure water is neutral, which is pH 7.',
      ),
      QuizQuestion(
        id: 5,
        question: isAr
            ? 'أي عنصر ضروري لعظام قوية؟'
            : 'Which element is needed for strong bones?',
        options: isAr
            ? ['البوتاسيوم', 'الحديد', 'الكالسيوم', 'الزنك']
            : ['Potassium', 'Iron', 'Calcium', 'Zinc'],
        correctIndex: 2,
        explanation: isAr
            ? 'الكالسيوم ضروري لبنية العظام وقوتها.'
            : 'Calcium is essential for bone structure and strength.',
      ),
    ];
  }
}
