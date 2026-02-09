import 'package:flutter/material.dart';
import '../../../../main.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F5), // خلفية هادئة نفس الصورة
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1. الشعار والعنوان العلوي
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.purpleAccent,
                child: Icon(Icons.star_border, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 10),
              const Text(
                "عجائب",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                "عالم من الاكتشافات في انتظارك",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // 2. الكارد (المربع الأبيض)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // تبديل (تسجيل دخول - حساب جديد)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "حساب جديد",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  "تسجيل الدخول",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // الحقول
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "البريد الإلكتروني",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const CustomTextfield(hintText: "example@email.com"),

                    const SizedBox(height: 20),

                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "كلمة المرور",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const CustomTextfield(
                      hintText: "********",
                      isPassword: true,
                    ),

                    const SizedBox(height: 30),

                    // زر الدخول
                    CustomButton(
                      text: "تسجيل الدخول",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  MyHomePage(title: "عجائب"),
                          ),
                        );
                        debugPrint("تم الضغط على دخول");
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text("أو", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),

              // أزرار جوجل وفيسبوك
              socialButton("متابعة مع جوجل", Icons.g_mobiledata, Colors.red),
              const SizedBox(height: 10),
              socialButton("متابعة مع فيسبوك", Icons.facebook, Colors.blue),
            ],
          ),
        ),
      ),
    );
  }

  // ويدجت صغير لأزرار التواصل الاجتماعي
  Widget socialButton(String text, IconData icon, Color color) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
