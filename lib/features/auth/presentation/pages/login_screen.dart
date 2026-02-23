import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/core/theme/theme_controller.dart';
import 'package:chemistry_initiative/shared/widgets/custom_textfield.dart';
import 'package:chemistry_initiative/features/auth/data/auth_repository.dart';
import 'package:chemistry_initiative/features/auth/data/current_user_provider.dart';
import 'package:chemistry_initiative/core/localization/language_switcher.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _confirmCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isSignup = false;
  final _authRepo = AuthRepository.instance;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _nameCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleAuth() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text.trim();
    final name = _nameCtrl.text.trim();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      if (_isSignup) {
        if (pass != _confirmCtrl.text.trim()) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('كلمات المرور غير متطابقة')),
          );
          return;
        }

        final error = await _authRepo.registerUser(name, email, pass);
        Navigator.pop(context);
        
        if (error == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إنشاء الحساب بنجاح! يمكنك الدخول الآن.')),
          );
          setState(() {
            _isSignup = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          );
        }
      } else {
        final success = await _authRepo.loginUser(email, pass);
        Navigator.pop(context);
        
        if (success) {
          ref.read(currentUserNotifierProvider.notifier).refresh();
          showWelcomeNotifier.value = true;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('خطأ في البريد الإلكتروني أو كلمة المرور')),
          );
        }
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ غير متوقع: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: isLight
          ? Colors.white
          : const Color(0xFF0F172A), // Deep dark blue for dark mode
      body: Stack(
        children: [
          // Background Chemistry Effects
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    isLight
                        ? Colors.deepPurpleAccent.withValues(alpha: 0.3)
                        : Colors.cyan.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    isLight
                        ? Colors.blueAccent.withValues(alpha: 0.2)
                        : Colors.purpleAccent.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const LanguageSwitcher(),
                          IconButton(
                            icon: Icon(
                              themeNotifier.value == ThemeMode.light
                                  ? Icons.dark_mode_outlined
                                  : Icons.light_mode_outlined,
                              color: isLight ? Colors.black87 : Colors.white,
                            ),
                            onPressed: () {
                              themeNotifier.value =
                                  themeNotifier.value == ThemeMode.light
                                  ? ThemeMode.dark
                                  : ThemeMode.light;
                            },
                          ),
                        ],
                      ),
                    ),

                    // Logo
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isLight
                            ? Colors.deepPurple.withValues(alpha: 0.1)
                            : Colors.cyanAccent.withValues(alpha: 0.1),
                        boxShadow: [
                          BoxShadow(
                            color: isLight
                                ? Colors.deepPurpleAccent.withValues(alpha: 0.2)
                                : Colors.cyanAccent.withValues(alpha: 0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.science_outlined,
                        color: isLight ? Colors.deepPurple : Colors.cyanAccent,
                        size: 50,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      localizations.wonders,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: isLight ? Colors.black87 : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      localizations.discoveryWorld,
                      style: TextStyle(
                        fontSize: 16,
                        color: isLight ? Colors.grey[600] : Colors.grey[400],
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Glassmorphism Card
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: isLight
                            ? Colors.white.withValues(alpha: 0.7)
                            : Colors.black.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: isLight
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.1),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: isLight ? 0.05 : 0.2,
                            ),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              // Toggle Switch
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: isLight
                                      ? Colors.grey[200]
                                      : Colors.grey[900],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () =>
                                            setState(() => _isSignup = true),
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _isSignup
                                                ? (isLight
                                                      ? Colors.white
                                                      : Colors.grey[800])
                                                : Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            boxShadow: _isSignup
                                                ? [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withValues(
                                                            alpha: 0.05,
                                                          ),
                                                      blurRadius: 4,
                                                      spreadRadius: 1,
                                                    ),
                                                  ]
                                                : [],
                                          ),
                                          child: Center(
                                            child: Text(
                                              localizations.newAccount,
                                              style: TextStyle(
                                                color: _isSignup
                                                    ? (isLight
                                                          ? Colors.deepPurple
                                                          : Colors.cyanAccent)
                                                    : Colors.grey,
                                                fontWeight: _isSignup
                                                    ? FontWeight.bold
                                                    : FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () =>
                                            setState(() => _isSignup = false),
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: !_isSignup
                                                ? (isLight
                                                      ? Colors.white
                                                      : Colors.grey[800])
                                                : Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            boxShadow: !_isSignup
                                                ? [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withValues(
                                                            alpha: 0.05,
                                                          ),
                                                      blurRadius: 4,
                                                      spreadRadius: 1,
                                                    ),
                                                  ]
                                                : [],
                                          ),
                                          child: Center(
                                            child: Text(
                                              localizations.login,
                                              style: TextStyle(
                                                color: !_isSignup
                                                    ? (isLight
                                                          ? Colors.deepPurple
                                                          : Colors.cyanAccent)
                                                    : Colors.grey,
                                                fontWeight: !_isSignup
                                                    ? FontWeight.bold
                                                    : FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),

                              Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    if (_isSignup) ...[
                                      CustomTextfield(
                                        hintText: localizations.fullName,
                                        controller: _nameCtrl,
                                        prefixIcon: Icons.person_outline,
                                        validator: (val) => val == null || val.isEmpty ? 'يرجى إدخال الاسم' : null,
                                      ),
                                      const SizedBox(height: 16),
                                    ],

                                    CustomTextfield(
                                      hintText: localizations.email,
                                      controller: _emailCtrl,
                                      prefixIcon: Icons.email_outlined,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) return 'يرجى إدخال البريد الإلكتروني';
                                        if (!val.contains('@')) return 'بريد إلكتروني غير صالح';
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),

                                    CustomTextfield(
                                      hintText: localizations.password,
                                      isPassword: true,
                                      controller: _passCtrl,
                                      prefixIcon: Icons.lock_outline,
                                      validator: (val) => val == null || val.length < 6 ? 'كلمة المرور يجب أن تكون 6 أحرف على الأقل' : null,
                                    ),

                                    if (_isSignup) ...[
                                      const SizedBox(height: 16),
                                      CustomTextfield(
                                        hintText: localizations.confirmPassword,
                                        isPassword: true,
                                        controller: _confirmCtrl,
                                        prefixIcon: Icons.lock_reset_outlined,
                                        validator: (val) {
                                          if (val == null || val.isEmpty) return 'يرجى تأكيد كلمة المرور';
                                          if (val != _passCtrl.text) return 'كلمات المرور غير متطابقة';
                                          return null;
                                        },
                                      ),
                                    ],

                                    if (!_isSignup) ...[
                                      const SizedBox(height: 8),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('نسيت كلمة المرور؟ هذه الميزة ستتوفر قريباً.')),
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: isLight
                                                ? Colors.deepPurple
                                                : Colors.cyanAccent,
                                          ),
                                          child: Text(
                                            localizations.forgotPassword,
                                          ),
                                        ),
                                      ),
                                    ] else
                                      const SizedBox(height: 24),

                                    const SizedBox(height: 24),
                                    
                                    // Primary Action Button
                                    ElevatedButton(
                                      onPressed: _handleAuth,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: isLight ? Colors.deepPurple : Colors.cyanAccent,
                                        foregroundColor: isLight ? Colors.white : Colors.black87,
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        elevation: 5,
                                      ),
                                      child: Text(
                                        _isSignup ? localizations.newAccount : localizations.login,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 24),
                                    Row(
                                      children: [
                                        const Expanded(child: Divider()),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          child: Text(
                                            localizations.orContinueWith,
                                            style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        const Expanded(child: Divider()),
                                      ],
                                    ),
                                    const SizedBox(height: 20),

                                    // Social Login Grid
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _socialIconTile(
                                          icon: Icons.g_mobiledata,
                                          color: Colors.redAccent,
                                          onTap: () async {
                                            final cred = await _authRepo.signInWithGoogle();
                                            if (cred != null && mounted) {
                                              ref.read(currentUserNotifierProvider.notifier).refresh();
                                              showWelcomeNotifier.value = true;
                                            }
                                          },
                                        ),
                                        _socialIconTile(
                                          icon: Icons.apple,
                                          color: isLight ? Colors.black : Colors.white,
                                          onTap: () async {
                                            final cred = await _authRepo.signInWithApple();
                                            if (cred != null && mounted) {
                                              ref.read(currentUserNotifierProvider.notifier).refresh();
                                              showWelcomeNotifier.value = true;
                                            }
                                          },
                                        ),
                                        _socialIconTile(
                                          icon: Icons.facebook,
                                          color: Colors.blueAccent,
                                          onTap: () async {
                                            final cred = await _authRepo.signInWithFacebook();
                                            if (cred != null && mounted) {
                                              ref.read(currentUserNotifierProvider.notifier).refresh();
                                              showWelcomeNotifier.value = true;
                                            }
                                          },
                                        ),
                                        _socialIconTile(
                                          icon: Icons.code_rounded, // GitHub icon
                                          color: Colors.black,
                                          onTap: () async {
                                            final cred = await _authRepo.signInWithGitHub();
                                            if (cred != null && mounted) {
                                              ref.read(currentUserNotifierProvider.notifier).refresh();
                                              showWelcomeNotifier.value = true;
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIconTile({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: isLight ? Colors.grey[100] : Colors.white10,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isLight ? Colors.grey[300]! : Colors.white10,
          ),
        ),
        child: Icon(icon, color: color, size: 30),
      ),
    );
  }

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
