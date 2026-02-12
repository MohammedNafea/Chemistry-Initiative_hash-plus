import 'package:flutter/material.dart';
import 'home_page.dart';
import '../core/theme/theme_controller.dart';
import '../shared/widgets/custom_button.dart';
import '../shared/widgets/custom_textfield.dart';

// Simple auth service mock for now
class AuthService {
  static Future<String?> registerUser(String name, String email, String password) async {
    // Mock implementation
    await Future.delayed(Duration(seconds: 1));
    return null; // Return null for success
  }
  
  static Future<bool> loginUser(String email, String password) async {
    // Mock implementation
    await Future.delayed(Duration(seconds: 1));
    return true; // Return true for success
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _confirmCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isSignup = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _nameCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: isLight ? const Color(0xFFFDF7F5) : Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.brightness_6, color: Theme.of(context).iconTheme.color),
                    onPressed: () {
                      themeNotifier.value = themeNotifier.value == ThemeMode.light
                          ? ThemeMode.dark
                          : ThemeMode.light;
                    },
                  ),
                ],
              ),
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
                  color: isLight ? Colors.white : Theme.of(context).cardColor,
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
                        color: isLight ? Colors.grey[100] : Colors.grey[800],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _isSignup = true),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: _isSignup ? (isLight ? Colors.white : Theme.of(context).cardColor) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Text(
                                      "حساب جديد",
                                      style: TextStyle(
                                        color: _isSignup ? Theme.of(context).textTheme.bodyLarge?.color : Colors.grey,
                                        fontWeight: _isSignup ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _isSignup = false),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: !_isSignup ? (isLight ? Colors.white : Theme.of(context).cardColor) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Text(
                                      "تسجيل الدخول",
                                      style: TextStyle(
                                        color: !_isSignup ? Theme.of(context).textTheme.bodyLarge?.color : Colors.grey,
                                        fontWeight: !_isSignup ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // form
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (_isSignup) ...[
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Text('الاسم الكامل', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 8),
                            CustomTextfield(hintText: 'الاسم الكامل', controller: _nameCtrl),
                            const SizedBox(height: 12),
                          ],

                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "البريد الإلكتروني",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextfield(hintText: "example@email.com", controller: _emailCtrl),

                          const SizedBox(height: 12),

                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "كلمة المرور",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextfield(
                            hintText: "********",
                            isPassword: true,
                            controller: _passCtrl,
                          ),

                          if (_isSignup) ...[
                            const SizedBox(height: 12),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Text('إعادة كلمة المرور', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 8),
                            CustomTextfield(hintText: '********', isPassword: true, controller: _confirmCtrl),
                          ],

                          const SizedBox(height: 18),

                          CustomButton(
                            text: _isSignup ? 'إنشاء حساب' : 'تسجيل الدخول',
                            onTap: () async {
                              final email = _emailCtrl.text.trim();
                              final pass = _passCtrl.text;
                              final messenger = ScaffoldMessenger.of(context);
                              final navigator = Navigator.of(context);

                              if (_isSignup) {
                                final name = _nameCtrl.text.trim();
                                final confirm = _confirmCtrl.text;
                                if (name.isEmpty || email.isEmpty || pass.isEmpty || confirm.isEmpty) {
                                  messenger.showSnackBar(const SnackBar(content: Text('يرجى ملء جميع الحقول')));
                                  return;
                                }
                                if (pass != confirm) {
                                  messenger.showSnackBar(const SnackBar(content: Text('كلمة المرور غير متطابقة')));
                                  return;
                                }
                                final err = await AuthService.registerUser(name, email, pass);
                                if (!mounted) return;
                                if (err != null) {
                                  messenger.showSnackBar(SnackBar(content: Text(err)));
                                  return;
                                }
                                messenger.showSnackBar(const SnackBar(content: Text('تم إنشاء الحساب')));
                                setState(() => _isSignup = false);
                                return;
                              }

                              // Login flow
                              if (email.isEmpty || pass.isEmpty) {
                                messenger.showSnackBar(const SnackBar(content: Text('يرجى إدخال البريد وكلمة المرور')));
                                return;
                              }
                              messenger.showSnackBar(const SnackBar(content: Text('جاري التحقق...')));
                              final ok = await AuthService.loginUser(email, pass);
                              if (!mounted) return;
                              if (!ok) {
                                messenger.showSnackBar(const SnackBar(content: Text('بيانات الدخول غير صحيحة')));
                                return;
                              }
                              navigator.pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(showWelcome: true),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Center(child: Text('أو', style: TextStyle(color: Colors.grey))),
              const SizedBox(height: 12),

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
