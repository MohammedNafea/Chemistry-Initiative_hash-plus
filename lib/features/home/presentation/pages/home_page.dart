import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/features/auth/data/current_user_provider.dart';
import 'package:chemistry_initiative/features/discovery/presentation/pages/question_page.dart';
import 'package:chemistry_initiative/features/search/presentation/pages/search_screen.dart';
import 'package:chemistry_initiative/features/bookmark/presentation/pages/bookmark_screen.dart';
import 'package:chemistry_initiative/features/profile/presentation/pages/profile_screen.dart';
import 'package:chemistry_initiative/features/home/data/models/home_card_model.dart';
import 'package:chemistry_initiative/features/home/data/providers/home_provider.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';

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

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return _buildHomeContent();
      case 1:
        return const SearchScreen();
      case 2:
        return const BookmarkScreen();
      case 3:
        return const ProfileScreen();
      default:
        return _buildHomeContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _getPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFF9F4EA),
        selectedItemColor: const Color(0xFFC47457),
        unselectedItemColor: const Color(0xFF9C9E80),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
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

    const darkBrown = Color(0xFF5A3E2B);
    const softBrown = Color(0xFF8C6B4F);
    const lightBackground = Color(0xFFEDE6D9);

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
                          backgroundColor: softBrown,
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          localizations.welcomeUser(user?.name ?? localizations.user),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: darkBrown,
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
                                  backgroundColor: softBrown,
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
                                    color: Colors.white,
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
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: darkBrown,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: LinearProgressIndicator(
                            value: progressValue,
                            minHeight: 20,
                            backgroundColor: lightBackground,
                            color: darkBrown,
                          ),
                        ),
                        Positioned.fill(
                          child: Center(
                            child: Text(
                              '${(progressValue * 100).toInt()}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    sectionTitle(localizations.natureSection, darkBrown),
                    horizontalList(natureCards, darkBrown),

                    const SizedBox(height: 16),
                    sectionTitle(localizations.waterAirSection, darkBrown),
                    horizontalList(waterCards, darkBrown),

                    const SizedBox(height: 16),
                    sectionTitle(localizations.dailyLifeSection, darkBrown),
                    horizontalList(dailyCards, darkBrown),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      localizations.welcomeMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
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
      child: ListView.builder(
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
              width: 140,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Hero(
                      tag: card.image,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(card.image),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(80, 0, 0, 0),
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    card.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
