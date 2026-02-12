import 'package:chemistry_initiative/core/database/app_database.dart';
import 'package:chemistry_initiative/core/database/models/user_model.dart';

/// Auth repository - handles user registration and login using local database.
class AuthRepository {
  AuthRepository._();
  static final AuthRepository _instance = AuthRepository._();
  static AuthRepository get instance => _instance;

  final _db = AppDatabase.instance;

  /// Register new user
  Future<String?> registerUser(
    String fullName,
    String email,
    String password,
  ) async {
    final key = email.toLowerCase().trim();
    if (_db.userExists(key)) {
      return 'الحساب موجود بالفعل لهذا الإيميل';
    }
    final user = UserModel(
      id: key,
      email: key,
      password: password,
      name: fullName.trim(),
    );
    await _db.createUser(user);
    return null;
  }

  /// Login user and set current session
  Future<bool> loginUser(String email, String password) async {
    final user = _db.readUserByEmail(email);
    if (user == null || user.password != password) return false;
    await _db.setCurrentUser(user.email);
    return true;
  }

  /// Logout - clear current session
  Future<void> logout() async {
    await _db.logout();
  }

  /// Check if user is logged in
  bool get isLoggedIn => _db.currentUser != null;

  /// Get current logged-in user
  UserModel? get currentUser => _db.currentUser;
}
