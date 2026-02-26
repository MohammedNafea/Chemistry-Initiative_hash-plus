import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/core/database/app_database.dart';
import 'package:chemistry_initiative/core/database/models/user_model.dart';
import 'package:chemistry_initiative/features/auth/data/user_sync_repository.dart';

/// Notifier for current user - refresh after login, logout, or profile update.
final currentUserNotifierProvider =
    NotifierProvider<CurrentUserNotifier, UserModel?>(CurrentUserNotifier.new);

class CurrentUserNotifier extends Notifier<UserModel?> {
  @override
  UserModel? build() => AppDatabase.instance.currentUser;

  void refresh() {
    state = AppDatabase.instance.currentUser;
  }

  Future<void> updatePoints(int additionalPoints) async {
    final user = state;
    if (user == null) return;

    final updatedUser = user.copyWith(
      totalPoints: user.totalPoints + additionalPoints,
      quizzesCompleted: user.quizzesCompleted + 1,
      pointsHistory: [...user.pointsHistory, additionalPoints],
    );

    await AppDatabase.instance.updateUser(updatedUser);
    
    // Sync to cloud in background
    UserSyncRepository().syncLocalToCloud(updatedUser);
    
    refresh();
  }
}

/// Set to true after login to show welcome overlay on HomePage.
final showWelcomeNotifier = ValueNotifier<bool>(false);
