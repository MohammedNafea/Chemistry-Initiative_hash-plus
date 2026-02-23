import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/features/auth/data/current_user_provider.dart';
import 'package:chemistry_initiative/features/gamification/data/repositories/achievement_repository.dart';
import 'package:chemistry_initiative/core/database/app_database.dart';

final achievementProvider = Provider((ref) => AchievementManager(ref));

class AchievementManager {
  final Ref _ref;

  AchievementManager(this._ref);

  Future<void> checkAndUnlock(String condition) async {
    final user = _ref.read(currentUserNotifierProvider);
    if (user == null) return;

    final allBadges = AchievementRepository.getBadges();
    final matchingBadges = allBadges.where((b) => b.condition == condition);

    for (final badge in matchingBadges) {
      if (!user.badges.contains(badge.id)) {
        // Unlock!
        final updatedBadges = List<String>.from(user.badges)..add(badge.id);
        final updatedUser = user.copyWith(badges: updatedBadges);

        await AppDatabase.instance.updateUser(updatedUser);
        _ref.read(currentUserNotifierProvider.notifier).refresh();

        // Ensure UI knows about update (optional, user provider refresh should trigger rebuilds)
      }
    }
  }

  bool hasBadge(String badgeId) {
    final user = _ref.read(currentUserNotifierProvider);
    return user?.badges.contains(badgeId) ?? false;
  }
}
