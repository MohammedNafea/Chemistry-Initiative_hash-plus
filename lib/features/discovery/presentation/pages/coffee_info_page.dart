import 'package:flutter/material.dart';

class CoffeeInfoPage extends StatefulWidget {
  const CoffeeInfoPage({super.key});

  @override
  State<CoffeeInfoPage> createState() => _CoffeeInfoPageState();
}

class _CoffeeInfoPageState extends State<CoffeeInfoPage>
    with SingleTickerProviderStateMixin {
  int _currentStep = 1;
  final int _maxSteps = 4;

  void _revealNextStep() {
    if (_currentStep < _maxSteps) {
      setState(() {
        _currentStep++;
      });
    } else {
      setState(() {
        _currentStep = _maxSteps;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F0),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () => Navigator.pop(context),
                            style: IconButton.styleFrom(
                              backgroundColor: const Color(0xFFF5F5F0),
                              foregroundColor: const Color(0xFF2C3E50),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=800&h=400&fit=crop',
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: const Color(0xFF8B7355),
                            child: const Center(
                              child: Icon(
                                Icons.coffee,
                                size: 64,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF8B7355), Color(0xFFA0826D)],
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'سحر يومي',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        'ما الذي يجعل رائحة قهوتي الصباحية جميلة جداً؟',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                          height: 1.4,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          _buildInfoItem(
                            1,
                            'حبوب القهوة مثل صناديق الكنز الصغيرة. تحتوي على أكثر من 1000 جزيء رائحة مختلف بداخلها.',
                          ),
                          _buildInfoItem(
                            2,
                            'عندما يلامس الماء الساخن الحبوب، يكون الأمر مثل فتح كل تلك الصناديق دفعة واحدة. تطفو الجزيئات في الهواء.',
                          ),
                          _buildInfoItem(
                            3,
                            'أنفك يلتقط هذه الجزيئات الطافية. كل واحدة تخبر دماغك قصة مختلفة: كراميل، شوكولاتة، زهور، مكسرات.',
                          ),
                          _buildInfoItem(
                            4,
                            'الحرارة هي المفتاح. بدونها، تبقى الحبوب مقفلة. لهذا السبب الحبوب الباردة ليس لها رائحة قوية!',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                            colors: [
                              const Color(0xFF8B7355).withValues(alpha: 0.1),
                              const Color(0xFFA0826D).withValues(alpha: 0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF8B7355).withValues(alpha: 0.2),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF8B7355),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    '💡',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'هل تعلم؟',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2C3E50),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'يمكن لرائحة القهوة أن تجعلك تشعر بمزيد من اليقظة حتى قبل أن تشربها! يتعرف دماغك على الرائحة ويبدأ في تحضير جسمك للكافيين!',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF555555),
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ElevatedButton(
                        onPressed: _revealNextStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2C3E50),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          'أخبرني المزيد',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(int number, String text) {
    final isVisible = number <= _currentStep;
    final arabicNumbers = ['١', '٢', '٣', '٤'];

    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: isVisible ? null : 0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B7355), Color(0xFFA0826D)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    arabicNumbers[number - 1],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF555555),
                      height: 1.6,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
