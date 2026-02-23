import 'package:cloud_firestore/cloud_firestore.dart';
import 'leaderboard_model.dart';

class LeaderboardRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<LeaderboardEntry>> getTopRankings({int limit = 10}) {
    return _firestore
        .collection('leaderboard')
        .orderBy('points', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
      int rank = 1;
      return snapshot.docs.map((doc) {
        return LeaderboardEntry.fromMap(doc.data(), rank++);
      }).toList();
    });
  }

  Future<void> updateUserPoints(String uid, String name, int pointsToAdd) async {
    final docRef = _firestore.collection('leaderboard').doc(uid);
    
    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) {
        transaction.set(docRef, {
          'uid': uid,
          'name': name,
          'points': pointsToAdd,
        });
      } else {
        final currentPoints = snapshot.data()?['points'] ?? 0;
        transaction.update(docRef, {
          'points': currentPoints + pointsToAdd,
        });
      }
    });
  }
}
