class LabExperiment {
  final String id;
  final String userId;
  final String title;
  final Map<String, dynamic> data;
  final DateTime updatedAt;

  LabExperiment({
    required this.id,
    required this.userId,
    required this.title,
    required this.data,
    required this.updatedAt,
  });

  factory LabExperiment.fromMap(Map<String, dynamic> map) {
    return LabExperiment(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      title: map['title'] ?? 'Untitled Experiment',
      data: Map<String, dynamic>.from(map['data'] ?? {}),
      updatedAt: DateTime.parse(
        map['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'data': data,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
