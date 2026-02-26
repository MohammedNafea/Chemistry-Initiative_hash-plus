import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AIHistorySyncRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Sync a specific chat session to cloud
  Future<void> syncSessionToCloud(String userId, Map<String, dynamic> session) async {
    if (userId.isEmpty || session['id'] == null) return;
    
    try {
      debugPrint("AIHistorySyncRepository: Syncing session ${session['id']} for user $userId to cloud...");
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('ai_history')
          .doc(session['id'] as String)
          .set(session, SetOptions(merge: true));
      debugPrint("AIHistorySyncRepository: Session sync successful.");
    } catch (e) {
      debugPrint("AIHistorySyncRepository: Session sync failed: $e");
    }
  }

  /// Fetch all chat sessions from cloud for a user
  Future<List<Map<String, dynamic>>> fetchAllHistoryFromCloud(String userId) async {
    try {
      debugPrint("AIHistorySyncRepository: Fetching AI history for user $userId from cloud...");
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('ai_history')
          .get();
      
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      debugPrint("AIHistorySyncRepository: Failed to fetch AI history: $e");
      return [];
    }
  }
}
