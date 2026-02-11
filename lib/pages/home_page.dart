import 'package:flutter/material.dart';
import 'package:chemistry_initiative/pages/second_page.dart';
import 'package:chemistry_initiative/pages/profile_screen.dart';

class HomePage extends StatefulWidget {
  final bool showWelcome;
  const HomePage({super.key, this.showWelcome = false});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showWelcome = false;

  @override
  void initState() {
    super.initState();
    _showWelcome = widget.showWelcome;
    if (_showWelcome) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _showWelcome = false);
      });
    }
  }
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Home tab is default

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return _buildHomeContent();
      case 1:
        return const Center(child: Text('Search'));
      case 2:
        return const Center(child: Text('Bookmark'));
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
        backgroundColor: const Color(0xFFF9F4EA), // OYSTER
        selectedItemColor: const Color(0xFFC47457), // TERRACOTTA
        unselectedItemColor: const Color(0xFF9C9E80), // SAGE
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
    final double progressValue = 0.6;

    final List<Map<String, String>> natureCards = [
      {'image': 'assets/images/download (4).jpg', 'title': 'احتراق الغازات'},
      {'image': 'assets/images/Ancient Forest.jpg', 'title': 'الغابات'},
      {'image': 'assets/images/A bowl of coal.jpg', 'title': 'اشتعال الفحم'},
      {'image': 'assets/images/جبل الفيل -  العلاء.jpg', 'title': 'الصخور'},
    ];

    final List<Map<String, String>> waterCards = [
      {
        'image': 'assets/images/Enchanting Nature and Art.jpg',
        'title': ' امتصاص المحلول ',
      },
      {
        'image': 'assets/images/#nature #rain #aesthetics #overcast.jpg',
        'title': 'قطرات المطر',
      },
      {'image': 'assets/images/contaminación.jpg', 'title': 'دخان المصانع'},
      {
        'image':
            'assets/images/Discover Top Vacation Spots Across the Planet.jpg',
        'title': 'الكريستال',
      },
    ];

    final List<Map<String, String>> dailyCards = [
      {'image': 'assets/images/欧包 by vcg-ailsapan.jpg', 'title': 'تخمير الخبز'},
      {
        'image': 'assets/images/Carbon Quantum Dots.jpg',
        'title': 'المعامل الطبية',
      },
      {'image': 'assets/images/Handmade.jpg', 'title': 'الأدوية'},
      {
        'image': 'assets/images/michael-glazier-5q5K8Q3x6e4-unsplash.jpg',
        'title': 'الاشتعال',
      },
    ];

    // ألوان
    const darkBrown = Color(0xFF5A3E2B); // نصوص داكنة وعناوين الأقسام
    const softBrown = Color(0xFF8C6B4F); // الأيقونات وزر الاستكشاف
    const lightBackground = Color(0xFFEDE6D9); // خلفية شريط التقدم

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              // أيقونة البروفايل + الاسم + أيقونة الإشعارات
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: softBrown,
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'مرحبا ريوف',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: darkBrown,
                    ),
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // أيقونة البروفايل + الاسم + أيقونة الإشعارات
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: softBrown,
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Text(
                  'مرحبا ريوف',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: darkBrown,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications,
                    color: softBrown,
                    size: 28,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 35), // زيادة المسافة بين الابار والصورة
            // الصورة الكبيرة مع العنوان وزر استكشف
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/Aurora Boreal Aesthetic _ Travel Inspo & Dream Destinations.jpg',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ظاهرة الشفق القطبي',
                        style: TextStyle(
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
                              builder: (context) => const QuestionPage(),
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
                        child: const Text(
                          'استكشف أكثر',
                          style: TextStyle(
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

            // شريط التقدم + النسبة
            const Text(
              'مستوى تقدمك',
              style: TextStyle(
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

            sectionTitle('الطبيعة', darkBrown),
            horizontalList(natureCards, darkBrown),

            const SizedBox(height: 16),
            sectionTitle('الماء والهواء', darkBrown),
            horizontalList(waterCards, darkBrown),

            const SizedBox(height: 16),
            sectionTitle('الحياة اليومية', darkBrown),
            horizontalList(dailyCards, darkBrown),
          ],
        ),
        // Welcome overlay
            if (_showWelcome)
              Positioned.fill(
                child: Container(
                  color: Colors.black45,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'أهلاً بك في عجائب الكيمياء',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
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

  Widget horizontalList(List<Map<String, String>> cards, Color textColor) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Container(
            width: 140,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(cards[index]['image']!),
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
                const SizedBox(height: 6),
                Text(
                  cards[index]['title']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal, // غير بولد
                    color: textColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
