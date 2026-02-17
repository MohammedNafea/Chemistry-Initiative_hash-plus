import 'package:chemistry_initiative/features/gamification/data/models/badge.dart';

class AchievementRepository {
  static List<Badge> getBadges() {
    return [
      const Badge(
        id: 'new_scientist',
        name: 'badgeNewScientist',
        description: 'badgeNewScientistDesc',
        iconPath: 'assets/images/badges/new_scientist.png',
        condition: 'login_1',
      ),
      const Badge(
        id: 'quiz_master',
        name: 'badgeQuizMaster',
        description: 'badgeQuizMasterDesc',
        iconPath: 'assets/images/badges/quiz_master.png',
        condition: 'quiz_5',
      ),
      const Badge(
        id: 'safety_expert',
        name: 'badgeSafetyExpert',
        description: 'badgeSafetyExpertDesc',
        iconPath: 'assets/images/badges/safety_expert.png',
        condition: 'safety_read',
      ),
    ];
  }
}
