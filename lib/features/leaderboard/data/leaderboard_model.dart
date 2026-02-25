class LeaderboardEntry {
  final String uid;
  final String name;
  final int points;
  final String? avatarUrl;
  final int rank;

  LeaderboardEntry({
    required this.uid,
    required this.name,
    required this.points,
    this.avatarUrl,
    required this.rank,
  });

  factory LeaderboardEntry.fromMap(Map<String, dynamic> map, int rank) {
    return LeaderboardEntry(
      uid: map['uid'] ?? '',
      name: map['name'] ?? 'Unknown',
      points: map['points'] ?? 0,
      avatarUrl: map['avatarUrl'],
      rank: rank,
    );
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'name': name, 'points': points, 'avatarUrl': avatarUrl};
  }
}
