import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/core/database/app_database.dart';
import 'package:chemistry_initiative/core/database/models/user_model.dart';

/// Notifier for current user - refresh after login, logout, or profile update.
final currentUserNotifierProvider =
    NotifierProvider<CurrentUserNotifier, UserModel?>(CurrentUserNotifier.new);

class CurrentUserNotifier extends Notifier<UserModel?> {
  @override
  UserModel? build() => AppDatabase.instance.currentUser;

  void refresh() {
    state = AppDatabase.instance.currentUser;
  }
}

/// Set to true after login to show welcome overlay on HomePage.
final showWelcomeNotifier = ValueNotifier<bool>(false);
