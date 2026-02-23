import 'package:flutter/material.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';
import 'package:chemistry_initiative/features/quiz/data/models/quiz_question.dart';
import 'package:chemistry_initiative/features/quiz/data/repositories/quiz_repository.dart';
import 'package:chemistry_initiative/features/quiz/presentation/pages/quiz_result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<QuizQuestion> _questions;
  int _currentIndex = 0;
  int _score = 0;
  bool _answered = false;
  int? _selectedOptionIndex;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final localizations = AppLocalizations.of(context)!;
    // TODO: Ideally fetch random 5 if we have a larger bank
    _questions = QuizRepository.getQuestions(localizations);
  }

  void _submitAnswer(int optionIndex) {
    if (_answered) return;

    setState(() {
      _answered = true;
      _selectedOptionIndex = optionIndex;
      if (optionIndex == _questions[_currentIndex].correctIndex) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _answered = false;
        _selectedOptionIndex = null;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizResultScreen(
            score: _score,
            totalQuestions: _questions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final question = _questions[_currentIndex];
    final colorScheme = theme.colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.dailyQuiz),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                '${_currentIndex + 1}/${_questions.length}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress Bar
            LinearProgressIndicator(
              value: (_currentIndex + 1) / _questions.length,
              backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 40),

            // Question
            Text(
              question.question,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Options
            ...List.generate(question.options.length, (index) {
              final isSelected = _selectedOptionIndex == index;
              final isCorrect = question.correctIndex == index;

              Color? backgroundColor;
              Color borderColor = isDark
                  ? Colors.grey[700]!
                  : Colors.grey[300]!;
              IconData? icon;

              if (_answered) {
                if (isCorrect) {
                  backgroundColor = Colors.green.withValues(alpha: 0.2);
                  borderColor = Colors.green;
                  icon = Icons.check_circle;
                } else if (isSelected) {
                  backgroundColor = Colors.red.withValues(alpha: 0.2);
                  borderColor = Colors.red;
                  icon = Icons.cancel;
                }
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () => _submitAnswer(index),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color:
                          backgroundColor ??
                          (isDark ? Colors.grey[900] : Colors.white),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected && !_answered
                            ? colorScheme.primary
                            : borderColor,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            question.options[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                        if (icon != null) Icon(icon, color: borderColor),
                      ],
                    ),
                  ),
                ),
              );
            }),

            const Spacer(),

            // Explanation & Next Button
            if (_answered) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.blueGrey[900] : Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isAr ? 'التفسير:' : 'Explanation:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.blue[200] : Colors.blue[800],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(question.explanation),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _currentIndex < _questions.length - 1
                      ? (isAr ? 'السؤال التالي' : 'Next Question')
                      : (isAr ? 'عرض النتائج' : 'See Results'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
