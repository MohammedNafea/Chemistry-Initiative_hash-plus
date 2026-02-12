import 'package:chemistry_initiative/core/database/app_database.dart';
import 'package:chemistry_initiative/core/database/models/user_model.dart';

/// Repository for profile updates - persists to local database.
class ProfileRepository {
  ProfileRepository._();
  static final ProfileRepository _instance = ProfileRepository._();
  static ProfileRepository get instance => _instance;

  final _db = AppDatabase.instance;

  Future<void> updateProfile(UserModel user, {String? previousEmail}) async {
    await _db.updateUser(user, previousEmail: previousEmail);
  }

  UserModel? get currentUser => _db.currentUser;
}
