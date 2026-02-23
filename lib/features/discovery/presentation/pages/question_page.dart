import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/features/bookmark/data/bookmark_provider.dart';
import 'package:chemistry_initiative/features/home/presentation/pages/home_page.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';

class QuestionPage extends ConsumerWidget {
  final String image;
  final String title;

  const QuestionPage({
    super.key,
    this.image = "assets/images/download (9).jpg",
    this.title = "ظاهرة الشفق القطبي",
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Instead of hardcoded darkBrown, use primary color from theme or a specific dark shade if needed
    final primaryColor = isDark
        ? theme.colorScheme.primary
        : const Color(0xFF5C4033);
    final backgroundColor = theme.scaffoldBackgroundColor;
    final textColor = isDark ? Colors.white : const Color(0xFF5C4033);
    final descriptionColor = isDark ? Colors.grey[300] : Colors.black87;

    final topic = {'image': image, 'title': title};
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Hero(
              tag: image,
              child: Container(
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      localizations.auroraQuestion,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        fontFamily: 'Cairo',
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      localizations.auroraDescription,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: descriptionColor,
                      ),
                    ),

                    const Spacer(),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDark
                                    ? Colors.grey[800]
                                    : Colors.white,
                                foregroundColor: isDark
                                    ? Colors.white
                                    : primaryColor,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: primaryColor),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    localizations.backToHome,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isDark
                                          ? Colors.white
                                          : primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    Icons.home,
                                    size: 20,
                                    color: isDark ? Colors.white : primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                ref.read(bookmarkProvider.notifier).add(topic);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      localizations.addedToBookmarks,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    localizations.addToBookmarks,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isDark
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    Icons.bookmark,
                                    size: 20,
                                    color: isDark ? Colors.black : Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
