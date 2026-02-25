import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/lab_experiment_model.dart';

class LabSyncRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _boxName = 'lab_experiments_box';

  Future<Box<dynamic>> get _box async => await Hive.openBox(_boxName);

  /// Save experiment locally and sync to cloud
  Future<void> saveExperiment(LabExperiment experiment) async {
    // 1. Save to Hive
    final box = await _box;
    await box.put(experiment.id, experiment.toMap());

    // 2. Sync to Firestore if user is logged in
    if (experiment.userId.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(experiment.userId)
          .collection('experiments')
          .doc(experiment.id)
          .set(experiment.toMap());
    }
  }

  /// Sync all local experiments to cloud (e.g., after login)
  Future<void> syncLocalToCloud(String userId) async {
    final box = await _box;
    final experiments = box.values
        .map((e) => LabExperiment.fromMap(Map<String, dynamic>.from(e)))
        .toList();

    for (var exp in experiments) {
      if (exp.userId.isEmpty || exp.userId == userId) {
        final syncedExp = LabExperiment(
          id: exp.id,
          userId: userId,
          title: exp.title,
          data: exp.data,
          updatedAt: exp.updatedAt,
        );
        await saveExperiment(syncedExp);
      }
    }
  }

  /// Fetch experiments from cloud and update local cache
  Future<void> syncCloudToLocal(String userId) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('experiments')
        .get();

    final box = await _box;
    for (var doc in snapshot.docs) {
      final exp = LabExperiment.fromMap(doc.data());
      await box.put(exp.id, exp.toMap());
    }
  }
}
