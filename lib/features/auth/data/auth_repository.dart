import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:chemistry_initiative/features/virtual_lab/data/repositories/lab_sync_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:chemistry_initiative/core/database/app_database.dart';
import 'package:chemistry_initiative/core/database/models/user_model.dart';
import 'package:flutter/foundation.dart';

/// Auth repository - handles user registration and login using Firebase & local database.
class AuthRepository {
  AuthRepository._();
  static final AuthRepository _instance = AuthRepository._();
  static AuthRepository get instance => _instance;

  final _db = AppDatabase.instance;
  final _auth = FirebaseAuth.instance;
  // Initialize without a placeholder to avoid assertion errors if the user hasn't set it yet
  final _googleSignIn = GoogleSignIn();

  /// Register new user (Email/Password)
  Future<String?> registerUser(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      // 1. Create in Firebase
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      
      if (cred.user != null) {
        await cred.user!.updateDisplayName(fullName.trim());
        
        // 2. Sync with local DB
        final key = email.toLowerCase().trim();
        final user = UserModel(
          id: key,
          email: key,
          password: password, // Store for local compat if needed
          name: fullName.trim(),
        );
        await _db.createUser(user);
        return null;
      }
    } on FirebaseAuthException catch (e) {
      return _mapFirebaseError(e.code);
    } catch (e) {
      return "An unexpected error occurred: $e";
    }
    return "Registration failed";
  }

  /// Login user (Email/Password)
  Future<bool> loginUser(String email, String password) async {
    debugPrint("AuthRepository: Starting login for $email");
    try {
      debugPrint("AuthRepository: Calling signInWithEmailAndPassword...");
      final cred = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      debugPrint("AuthRepository: Firebase call completed. User: ${cred.user?.uid}");
      if (cred.user != null) {
        // Sync local session and user profile
        await _syncLocalUserFromFirebase(cred.user!);
        debugPrint("AuthRepository: Local sync completed.");
        return true;
      }
    } catch (e) {
      debugPrint("AuthRepository: Firebase login failed with error: $e");
      // Fallback to local DB check for offline compatibility or legacy users
      final user = _db.readUserByEmail(email);
      if (user != null && user.password == password) {
        debugPrint("AuthRepository: Fallback to local DB successful.");
        await _db.setCurrentUser(user.email);
        return true;
      }
    }
    debugPrint("AuthRepository: Login process finished with false.");
    return false;
  }

  /// Google Sign In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final cred = await _auth.signInWithCredential(credential);
      if (cred.user != null) {
        _syncLocalUserFromFirebase(cred.user!);
      }
      return cred;
    } catch (e) {
      debugPrint("Google Sign In Error: $e");
      return null;
    }
  }

  /// Facebook Sign In
  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
        final cred = await _auth.signInWithCredential(credential);
        if (cred.user != null) {
          _syncLocalUserFromFirebase(cred.user!);
        }
        return cred;
      }
    } catch (e) {
      debugPrint("Facebook Sign In Error: $e");
    }
    return null;
  }

  /// Apple Sign In
  Future<UserCredential?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final OAuthCredential credential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final cred = await _auth.signInWithCredential(credential);
      if (cred.user != null) {
        _syncLocalUserFromFirebase(cred.user!);
      }
      return cred;
    } catch (e) {
      debugPrint("Apple Sign In Error: $e");
    }
    return null;
  }

  /// GitHub Sign In
  Future<UserCredential?> signInWithGitHub() async {
    try {
      final OAuthProvider githubProvider = OAuthProvider("github.com");
      final cred = await _auth.signInWithProvider(githubProvider);
      if (cred.user != null) {
        _syncLocalUserFromFirebase(cred.user!);
      }
      return cred;
    } catch (e) {
      debugPrint("GitHub Sign In Error: $e");
    }
    return null;
  }

  /// Sync Firebase user info with local database
  Future<void> _syncLocalUserFromFirebase(User fbUser) async {
    final email = fbUser.email ?? "";
    if (email.isEmpty) return;
    
    final key = email.toLowerCase().trim();
    if (!_db.userExists(key)) {
      final newUser = UserModel(
        id: key,
        email: key,
        password: "", // Social accounts don't use local pass
        name: fbUser.displayName ?? "User",
      );
      await _db.createUser(newUser);
    }
    await _db.setCurrentUser(email);
    
    // Trigger Lab Cloud Sync in background - don't block login
    debugPrint("AuthRepository: Triggering lab cloud sync...");
    LabSyncRepository().syncCloudToLocal(fbUser.uid).catchError((e) {
      debugPrint("AuthRepository: Lab cloud sync failed (non-critical): $e");
    });
  }

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'email-already-in-use': return 'الحساب موجود بالفعل لهذا الإيميل';
      case 'weak-password': return 'كلمة المرور ضعيفة جداً';
      case 'invalid-email': return 'البريد الإلكتروني غير صحيح';
      case 'configuration-not-found':
        return 'إعدادات Firebase غير مكتملة. يرجى التأكد من تفعيل "Email/Password" في Firebase Console (Build > Authentication > Sign-in method).';
      case 'api-key-not-valid':
      case 'api-key-not-valid-please-pass-a-valid-api-key': 
        return 'مفتاح Firebase غير صالح. يرجى التأكد من ضبط FIREBASE_API_KEY في ملف .env بشكل صحيح.';
      default: return 'حدث خطأ أثناء التسجيل: $code';
    }
  }

  /// Logout - clear current session
  Future<void> logout() async {
    debugPrint("AuthRepository: Starting logout process...");
    
    // 1. Firebase Sign Out (Primary)
    try {
      await _auth.signOut();
      debugPrint("AuthRepository: Firebase signOut completed.");
    } catch (e) {
      debugPrint("AuthRepository: Firebase signOut failed: $e");
    }

    // 2. Google Sign Out (Optional/Social)
    try {
      if (!kIsWeb) {
        // Only attempt on mobile where config is usually valid
        await _googleSignIn.signOut();
        debugPrint("AuthRepository: GoogleSignIn signOut completed.");
      } else {
        // On Web, only attempt if initialized or skip if prone to assertion errors
        // For now, we'll try it but it's wrapped in a safe catch
        await _googleSignIn.signOut(); 
      }
    } catch (e) {
      debugPrint("AuthRepository: GoogleSignIn signOut skipped or failed: $e");
    }

    // 3. Local DB Session (Essential)
    try {
      await _db.logout();
      debugPrint("AuthRepository: Local database session cleared.");
    } catch (e) {
      debugPrint("AuthRepository: Local database logout failed: $e");
    }
  }

  /// Check if user is logged in
  bool get isLoggedIn => _auth.currentUser != null || _db.currentUser != null;

  /// Get current logged-in user
  UserModel? get currentUser => _db.currentUser;
}
