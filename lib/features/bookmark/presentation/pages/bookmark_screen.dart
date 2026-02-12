import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/features/bookmark/data/bookmark_provider.dart';
import 'package:chemistry_initiative/features/discovery/presentation/pages/question_page.dart';

class BookmarkScreen extends ConsumerWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const darkBrown = Color(0xFF5A3E2B);
    const softBrown = Color(0xFF8C6B4F);
    final bookmarks = ref.watch(bookmarkProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: bookmarks.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bookmark_border,
                        size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'لا توجد مواضيع محفوظة',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'احفظ المواضيع المفضلة لديك',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Text(
                          'المواضيع المحفوظة',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: darkBrown,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${bookmarks.length}',
                          style: TextStyle(
                            fontSize: 18,
                            color: softBrown,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: bookmarks.length,
                      itemBuilder: (context, index) {
                        final topic = bookmarks[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
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
                            borderRadius: BorderRadius.circular(12),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                  child: Image.asset(
                                    topic['image']!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          topic['title']!,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: darkBrown,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(Icons.bookmark,
                                                size: 16, color: softBrown),
                                            const SizedBox(width: 4),
                                            Text(
                                              'محفوظ',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  color: Colors.red[300],
                                  onPressed: () {
                                    ref.read(bookmarkProvider.notifier).remove(topic);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('تم حذف الموضوع'),
                                      ),
                                    );
                                  },
                                ),
                              ],
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
