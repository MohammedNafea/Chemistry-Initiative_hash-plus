import 'package:flutter/material.dart';
import 'package:chemistry_initiative/features/discovery/presentation/pages/question_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _allTopics = [
    {'image': 'assets/images/download (4).jpg', 'title': 'احتراق الغازات'},
    {'image': 'assets/images/Ancient Forest.jpg', 'title': 'الغابات'},
    {'image': 'assets/images/A bowl of coal.jpg', 'title': 'اشتعال الفحم'},
    {'image': 'assets/images/جبل الفيل -  العلاء.jpg', 'title': 'الصخور'},
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

  List<Map<String, String>> _filteredTopics = [];

  @override
  void initState() {
    super.initState();
    _filteredTopics = _allTopics;
    _searchController.addListener(_filterTopics);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterTopics);
    _searchController.dispose();
    super.dispose();
  }

  void _filterTopics() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredTopics = _allTopics;
      } else {
        _filteredTopics = _allTopics
            .where((topic) =>
                topic['title']!.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const softBrown = Color(0xFF8C6B4F);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'ابحث عن موضوع...',
                  prefixIcon: const Icon(Icons.search, color: softBrown),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
            ),

            Expanded(
              child: _filteredTopics.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off,
                              size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            'لا توجد نتائج',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: _filteredTopics.length,
                      itemBuilder: (context, index) {
                        final topic = _filteredTopics[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuestionPage(
                                  image: topic['image']!,
                                  title: topic['title']!,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: AssetImage(topic['image']!),
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
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: 0.7),
                                  ],
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    topic['title']!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
