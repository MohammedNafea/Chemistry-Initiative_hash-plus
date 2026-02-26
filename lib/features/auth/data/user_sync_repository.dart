import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chemistry_initiative/core/database/models/user_model.dart';
import 'package:flutter/foundation.dart';

class UserSyncRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Sync local user profile to cloud
  Future<void> syncLocalToCloud(UserModel user) async {
    if (user.id.isEmpty) return;
    
    try {
      debugPrint("UserSyncRepository: Syncing user ${user.email} to cloud...");
      await _firestore
          .collection('users')
          .doc(user.id)
          .set(user.toJson(), SetOptions(merge: true));
      debugPrint("UserSyncRepository: Cloud sync successful.");
    } catch (e) {
      debugPrint("UserSyncRepository: Cloud sync failed: $e");
    }
  }

  /// Fetch user profile from cloud
  Future<UserModel?> fetchFromCloud(String userId) async {
    try {
      debugPrint("UserSyncRepository: Fetching user $userId from cloud...");
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        debugPrint("UserSyncRepository: User found in cloud.");
        return UserModel.fromJson(doc.data()!);
      }
    } catch (e) {
      debugPrint("UserSyncRepository: Failed to fetch from cloud: $e");
    }
    return null;
  }
}
