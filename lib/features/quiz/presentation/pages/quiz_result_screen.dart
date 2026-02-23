import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/features/quiz/presentation/pages/quiz_screen.dart';
import 'package:chemistry_initiative/features/leaderboard/data/leaderboard_repository.dart';
import 'package:chemistry_initiative/features/auth/data/current_user_provider.dart';

class QuizResultScreen extends ConsumerWidget {
  final int score;
  final int totalQuestions;

  const QuizResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final percentage = score / totalQuestions;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    // Report to Leaderboard if logged in
    final user = ref.watch(currentUserNotifierProvider);
    if (user != null) {
      LeaderboardRepository().updateUserPoints(user.id, user.name, score);
    }

    String message;
    IconData icon;
    Color color;

    if (percentage >= 0.8) {
      message = isAr ? 'ممتاز!' : 'Excellent!';
      icon = Icons.emoji_events;
      color = Colors.amber;
    } else if (percentage >= 0.5) {
      message = isAr ? 'عمل جيد!' : 'Good Job!';
      icon = Icons.thumb_up;
      color = Colors.blue;
    } else {
      message = isAr ? 'واصل التعلم!' : 'Keep Learning!';
      icon = Icons.school;
      color = Colors.orange;
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 100, color: color),
            const SizedBox(height: 24),
            Text(
              message,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              isAr
                  ? 'حصلت على $score من $totalQuestions'
                  : 'You scored $score out of $totalQuestions',
              style: TextStyle(
                fontSize: 20,
                color: theme.textTheme.bodyMedium?.color?.withValues(
                  alpha: 0.7,
                ),
              ),
            ),
            const SizedBox(height: 60),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isAr ? 'إعادة اللعب' : 'Play Again',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context); // Goes back to Home
                },
                child: Text(
                  isAr ? 'العودة للرئيسية' : 'Back to Home',
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
