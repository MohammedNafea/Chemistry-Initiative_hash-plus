import 'package:hive_flutter/hive_flutter.dart';
import 'package:chemistry_initiative/core/database/models/user_model.dart';

/// Database keys
class _Keys {
  static const String usersBox = 'users_box';
  static const String appBox = 'app_box';
  static const String currentUserEmail = 'current_user_email';
}

/// Local database service using Hive - provides CRUD operations.
class AppDatabase {
  AppDatabase._();
  static final AppDatabase _instance = AppDatabase._();
  static AppDatabase get instance => _instance;

  Box<dynamic>? _usersBox;
  Box<dynamic>? _appBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _usersBox = await Hive.openBox(_Keys.usersBox);
    _appBox = await Hive.openBox(_Keys.appBox);
  }

  Box<dynamic> get _users {
    final box = _usersBox;
    if (box == null) {
      throw StateError('Database not initialized. Call init() first.');
    }
    return box;
  }

  Box<dynamic> get _app {
    final box = _appBox;
    if (box == null) {
      throw StateError('Database not initialized. Call init() first.');
    }
    return box;
  }

  // ---------------------------------------------------------------------------
  // User CRUD
  // ---------------------------------------------------------------------------

  /// Create - Add new user
  Future<void> createUser(UserModel user) async {
    final key = user.email.toLowerCase().trim();
    await _users.put(key, user.toJson());
  }

  /// Read - Get user by email
  UserModel? readUserByEmail(String email) {
    final key = email.toLowerCase().trim();
    final data = _users.get(key);
    if (data == null || data is! Map) return null;
    return UserModel.fromJson(Map<String, dynamic>.from(data));
  }

  /// Read - Get all users
  List<UserModel> readAllUsers() {
    final list = <UserModel>[];
    for (final key in _users.keys) {
      final data = _users.get(key);
      if (data != null && data is Map) {
        list.add(UserModel.fromJson(Map<String, dynamic>.from(data)));
      }
    }
    return list;
  }

  /// Update - Update existing user. Handles email change (deletes old, creates new).
  Future<void> updateUser(UserModel user, {String? previousEmail}) async {
    final newKey = user.email.toLowerCase().trim();
    if (previousEmail != null) {
      final oldKey = previousEmail.toLowerCase().trim();
      if (oldKey != newKey) {
        await _users.delete(oldKey);
        if (currentUserEmail == oldKey) {
          await setCurrentUser(newKey);
        }
      }
    }
    await _users.put(newKey, user.toJson());
  }

  /// Delete - Remove user by email
  Future<void> deleteUser(String email) async {
    final key = email.toLowerCase().trim();
    await _users.delete(key);
  }

  /// Check if user exists by email
  bool userExists(String email) {
    return readUserByEmail(email) != null;
  }

  // ---------------------------------------------------------------------------
  // Current user (session)
  // ---------------------------------------------------------------------------

  String? get currentUserEmail => _app.get(_Keys.currentUserEmail) as String?;

  Future<void> setCurrentUser(String? email) async {
    if (email == null) {
      await _app.delete(_Keys.currentUserEmail);
    } else {
      await _app.put(_Keys.currentUserEmail, email.toLowerCase().trim());
    }
  }

  UserModel? get currentUser {
    final email = currentUserEmail;
    if (email == null) return null;
    return readUserByEmail(email);
  }

  Future<void> logout() => setCurrentUser(null);
}
