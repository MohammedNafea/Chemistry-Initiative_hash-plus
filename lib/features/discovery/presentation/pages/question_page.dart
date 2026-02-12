import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/features/bookmark/data/bookmark_provider.dart';
import 'package:chemistry_initiative/features/home/presentation/pages/home_page.dart';

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
    const Color darkBrown = Color(0xFF5C4033);
    final topic = {'image': image, 'title': title};

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Container(
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

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  textDirection: TextDirection.rtl,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      "هل تساءلت يوماً لماذا تتلألأ السماء بألوان الشفق القطبي؟",
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: darkBrown,
                        fontFamily: 'Cairo',
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "الشفق القطبي يحدث عندما تصطدم جسيمات مشحونة من الشمس بالغازات في الغلاف الجوي للأرض، مثل الأكسجين والنيتروجين. هذه الاصطدامات تثير الذرات والجزيئات وتمنحها طاقة إضافية.\n"
                      "• الأكسجين على ارتفاع منخفض يعطي ضوءاً أخضر\n"
                      "• الأكسجين على ارتفاع مرتفع يعطي ضوءاً أحمر\n"
                      "• النيتروجين يعطي ألوان زرقاء وبنفسجية\n\n"
                      "عندما تعود هذه الذرات إلى حالتها الطبيعية، تطلق الطاقة على شكل ضوء مرئي. هذه العملية هي سبب الألوان المذهلة للشفق، وهي مثال حي على تفاعل كيميائي وفيزيائي طبيعي يمكن ملاحظته في حياتنا اليومية.",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.black87,
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
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: darkBrown),
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
                                children: const [
                                  Text(
                                    "العودة للصفحة الرئيسية",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: darkBrown,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Icon(Icons.home, size: 20, color: darkBrown),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: darkBrown,
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
                                  const SnackBar(
                                    content: Text("تم الإضافة إلى المفضلة"),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "إضافة إلى المفضلة",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Icon(
                                    Icons.bookmark,
                                    size: 20,
                                    color: Colors.white,
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
