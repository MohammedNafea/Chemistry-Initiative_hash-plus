import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/features/auth/data/current_user_provider.dart';

enum ScientistRank {
  novice,
  labAssistant,
  researcher,
  seniorChemist,
  alchemist,
}

extension ScientistRankExtension on ScientistRank {
  String get labelKey {
    switch (this) {
      case ScientistRank.novice:
        return 'novice';
      case ScientistRank.labAssistant:
        return 'labAssistant';
      case ScientistRank.researcher:
        return 'researcherRank';
      case ScientistRank.seniorChemist:
        return 'seniorChemist';
      case ScientistRank.alchemist:
        return 'alchemist';
    }
  }

  String get displayName {
    // This will be handled by localization in the UI
    return name.toUpperCase();
  }
}

final scientistRankProvider = Provider<ScientistRank>((ref) {
  final user = ref.watch(currentUserNotifierProvider);
  if (user == null) return ScientistRank.novice;

  final badgeCount = user.badges.length;
  final journalCount = user.researchJournal.length;
  final totalPoints = user.totalPoints;
  // New weighted score: Badges (1.0), Discoveries (0.5), Points (0.02 per point)
  final totalScore = badgeCount + (journalCount / 2).floor() + (totalPoints / 50).floor();

  if (totalScore >= 15) return ScientistRank.alchemist;
  if (totalScore >= 10) return ScientistRank.seniorChemist;
  if (totalScore >= 6) return ScientistRank.researcher;
  if (totalScore >= 3) return ScientistRank.labAssistant;
  return ScientistRank.novice;
});
