import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/features/auth/data/current_user_provider.dart';
import 'package:chemistry_initiative/features/discovery/presentation/pages/question_page.dart';
import 'package:chemistry_initiative/features/discovery/presentation/pages/discovery_hub_screen.dart';
import 'package:chemistry_initiative/features/search/presentation/pages/search_screen.dart';
import 'package:chemistry_initiative/features/bookmark/presentation/pages/bookmark_screen.dart';
import 'package:chemistry_initiative/features/profile/presentation/pages/profile_screen.dart';
import 'package:chemistry_initiative/features/home/data/models/home_card_model.dart';
import 'package:chemistry_initiative/features/home/data/providers/home_provider.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';
import 'package:chemistry_initiative/features/guide/presentation/pages/household_items_screen.dart';
import 'package:chemistry_initiative/features/periodic_table/presentation/pages/periodic_table_screen.dart';
import 'package:chemistry_initiative/features/quiz/presentation/pages/quiz_screen.dart';
import 'package:chemistry_initiative/features/safety/presentation/pages/safety_guide_screen.dart';
import 'package:chemistry_initiative/features/experiments/presentation/pages/experiments_list_screen.dart';
import 'package:chemistry_initiative/features/molecules/presentation/pages/molecule_viewer_screen.dart';
import 'package:chemistry_initiative/features/home/presentation/widgets/chemical_of_the_day_card.dart';
import 'package:chemistry_initiative/features/home/presentation/widgets/chemistry_particle_background.dart';
import 'package:chemistry_initiative/core/widgets/lab_widgets.dart';
import 'package:chemistry_initiative/features/gamification/data/providers/scientist_rank_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  final bool showWelcome;
  const HomePage({super.key, this.showWelcome = false});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;
  bool _showWelcome = false;

  @override
  void initState() {
    super.initState();
    _showWelcome = widget.showWelcome;
    if (_showWelcome) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() => _showWelcome = false);
          showWelcomeNotifier.value = false;
        }
      });
    }
  }

  String _getRankLabel(ScientistRank rank, AppLocalizations localizations) {
    switch (rank) {
      case ScientistRank.novice:
        return localizations.novice.toUpperCase();
      case ScientistRank.labAssistant:
        return localizations.labAssistant.toUpperCase();
      case ScientistRank.researcher:
        return localizations.researcherRank.toUpperCase();
      case ScientistRank.seniorChemist:
        return localizations.seniorChemist.toUpperCase();
      case ScientistRank.alchemist:
        return localizations.alchemist.toUpperCase();
    }
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return _buildHomeContent();
      case 1:
        return const SearchScreen();
      case 2:
        return const DiscoveryHubScreen();
      case 3:
        return const BookmarkScreen();
      case 4:
        return const ProfileScreen();
      default:
        return _buildHomeContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final isWide = MediaQuery.of(context).size.width >= 1200;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Row(
        children: [
          if (isWide)
            NavigationRail(
              selectedIndex: _currentIndex,
              backgroundColor: isDark ? theme.cardColor : Colors.white,
              onDestinationSelected: (index) {
                setState(() => _currentIndex = index);
              },
              labelType: NavigationRailLabelType.all,
              selectedIconTheme: IconThemeData(color: colorScheme.primary),
              unselectedIconTheme: IconThemeData(color: theme.unselectedWidgetColor),
              selectedLabelTextStyle: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold),
              destinations: [
                NavigationRailDestination(icon: const Icon(Icons.home_rounded), label: Text(localizations.home)),
                NavigationRailDestination(icon: const Icon(Icons.search_rounded), label: Text(localizations.search)),
                NavigationRailDestination(icon: const Icon(Icons.hub_rounded), label: Text(localizations.discoveryLabel)),
                NavigationRailDestination(icon: const Icon(Icons.bookmark_rounded), label: Text(localizations.bookmark)),
                NavigationRailDestination(icon: const Icon(Icons.person_rounded), label: Text(localizations.profile)),
              ],
            ),
          Expanded(
            child: Stack(
              children: [
                const ChemistryParticleBackground(),
                _getPage(_currentIndex),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: isWide ? null : BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: isDark ? theme.cardColor : Colors.white,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: theme.unselectedWidgetColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home_rounded), label: localizations.home),
          BottomNavigationBarItem(icon: const Icon(Icons.search_rounded), label: localizations.search),
          BottomNavigationBarItem(icon: const Icon(Icons.hub_rounded), label: localizations.discoveryLabel),
          BottomNavigationBarItem(icon: const Icon(Icons.bookmark_rounded), label: localizations.bookmark),
          BottomNavigationBarItem(icon: const Icon(Icons.person_rounded), label: localizations.profile),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    const double progressValue = 0.6;
    final user = ref.watch(currentUserNotifierProvider);
    final localizations = AppLocalizations.of(context)!;
    final homeRepository = ref.read(homeRepositoryProvider);

    final natureCards = homeRepository.getNatureCards(localizations);
    final waterCards = homeRepository.getWaterCards(localizations);
    final dailyCards = homeRepository.getDailyCards(localizations);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Use theme colors instead of hardcoded ones
    final textColor = isDark ? Colors.white : theme.colorScheme.primary;

    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: colorScheme.primary,
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          localizations.welcomeUser(user?.name ?? localizations.user),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),

                    const SizedBox(height: 35),
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Hero(
                            tag: 'assets/images/Aurora Boreal Aesthetic _ Travel Inspo & Dream Destinations.jpg',
                            child: Image.asset(
                              'assets/images/Aurora Boreal Aesthetic _ Travel Inspo & Dream Destinations.jpg',
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          bottom: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                localizations.auroraTitle,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 4,
                                      color: Colors.black54,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QuestionPage(
                                        image: 'assets/images/Aurora Boreal Aesthetic _ Travel Inspo & Dream Destinations.jpg',
                                        title: localizations.auroraTitle,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.secondary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  localizations.exploreMore,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    Text(
                      localizations.yourProgress,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const BeakerProgressIndicator(
                          value: progressValue,
                          height: 80,
                          width: 50,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${(progressValue * 100).toInt()}% ${localizations.complete}', // Add "Complete" or similar if available
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.secondary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: colorScheme.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: colorScheme.primary.withValues(alpha: 0.2)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.terminal_rounded, size: 14, color: colorScheme.primary),
                                    const SizedBox(width: 6),
                                    Text(
                                      _getRankLabel(ref.watch(scientistRankProvider), localizations),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme.primary,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    sectionTitle(localizations.natureSection, textColor),
                    horizontalList(natureCards, textColor),

                    const SizedBox(height: 16),
                    sectionTitle(localizations.waterAirSection, textColor),
                    horizontalList(waterCards, textColor),

                    const SizedBox(height: 16),
                    sectionTitle(localizations.dailyLifeSection, textColor),
                    horizontalList(dailyCards, textColor),

                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth < 340) {
                            return Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const PeriodicTableScreen(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                                      foregroundColor: theme.colorScheme.primary,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.2)),
                                      ),
                                    ),
                                    icon: const Icon(Icons.grid_view_rounded),
                                    label: Text(
                                      localizations.periodicTable,
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const QuizScreen(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.colorScheme.secondary.withValues(alpha: 0.1),
                                      foregroundColor: theme.colorScheme.secondary,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(color: theme.colorScheme.secondary.withValues(alpha: 0.2)),
                                      ),
                                    ),
                                    icon: const Icon(Icons.school_rounded),
                                    label: Text(
                                      localizations.dailyQuiz,
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const PeriodicTableScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                                    foregroundColor: theme.colorScheme.primary,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.2)),
                                    ),
                                  ),
                                  icon: const Icon(Icons.grid_view_rounded),
                                  label: Text(
                                    localizations.periodicTable,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const QuizScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.secondary.withValues(alpha: 0.1),
                                    foregroundColor: theme.colorScheme.secondary,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(color: theme.colorScheme.secondary.withValues(alpha: 0.2)),
                                    ),
                                  ),
                                  icon: const Icon(Icons.school_rounded),
                                  label: Text(
                                    localizations.dailyQuiz,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth < 340) {
                            return Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const HouseholdItemsScreen(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.colorScheme.tertiary.withValues(alpha: 0.1),
                                      foregroundColor: theme.colorScheme.tertiary,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(color: theme.colorScheme.tertiary.withValues(alpha: 0.2)),
                                      ),
                                    ),
                                    icon: const Icon(Icons.search_rounded),
                                    label: Text(
                                      localizations.whatsInThis,
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const SafetyGuideScreen(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.colorScheme.error.withValues(alpha: 0.1),
                                      foregroundColor: theme.colorScheme.error,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(color: theme.colorScheme.error.withValues(alpha: 0.2)),
                                      ),
                                    ),
                                    icon: const Icon(Icons.warning_amber_rounded),
                                    label: Text(
                                      localizations.safetyGuide,
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HouseholdItemsScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.tertiary.withValues(alpha: 0.1),
                                    foregroundColor: theme.colorScheme.tertiary,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(color: theme.colorScheme.tertiary.withValues(alpha: 0.2)),
                                    ),
                                  ),
                                  icon: const Icon(Icons.search_rounded),
                                  label: Text(
                                    localizations.whatsInThis,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SafetyGuideScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.error.withValues(alpha: 0.1),
                                    foregroundColor: theme.colorScheme.error,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(color: theme.colorScheme.error.withValues(alpha: 0.2)),
                                    ),
                                  ),
                                  icon: const Icon(Icons.warning_amber_rounded),
                                  label: Text(
                                    localizations.safetyGuide,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ExperimentsListScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(Icons.science_rounded),
                            label: Text(
                              localizations.virtualLab,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MoleculeViewerScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.secondary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(Icons.hub_rounded),
                            label: Text(
                              localizations.moleculeViewer,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    ChemicalOfTheDayCard(localizations: localizations),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
          if (_showWelcome)
            Positioned.fill(
              child: Container(
                color: Colors.black45,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      localizations.welcomeMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget horizontalList(List<HomeCardModel> cards, Color textColor) {
    return SizedBox(
      height: 180,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final theme = Theme.of(context);
          // Responsive item width: 40% of screen width on small screens, fixed max on large
          final screenWidth = MediaQuery.of(context).size.width;
          final itemWidth = screenWidth > 600 ? 160.0 : screenWidth * 0.38;
          
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionPage(
                        image: card.image,
                        title: card.title,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: itemWidth,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.brightness == Brightness.dark 
                              ? Colors.white.withValues(alpha: 0.03) 
                              : Colors.black.withValues(alpha: 0.02),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Hero(
                                tag: card.image,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                    image: DecorationImage(
                                      image: AssetImage(card.image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                card.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: textColor.withValues(alpha: 0.9),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }
}
