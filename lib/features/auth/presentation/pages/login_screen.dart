import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/core/theme/theme_controller.dart';
import 'package:chemistry_initiative/shared/widgets/custom_button.dart';
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

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: isLight ? const Color(0xFFFDF7F5) : Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const LanguageSwitcher(),
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
              ),
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.purpleAccent,
                child: Icon(Icons.star_border, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 10),
              Text(
                localizations.wonders,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text(
                localizations.discoveryWorld,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: isLight ? Colors.white : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
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
                                      localizations.newAccount,
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
                                      localizations.login,
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

                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (_isSignup) ...[
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(localizations.fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 8),
                            CustomTextfield(hintText: localizations.fullName, controller: _nameCtrl),
                            const SizedBox(height: 12),
                          ],

                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              localizations.email,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextfield(hintText: "example@email.com", controller: _emailCtrl),

                          const SizedBox(height: 12),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              localizations.password,
                              style: const TextStyle(fontWeight: FontWeight.bold),
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
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(localizations.confirmPassword, style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 8),
                            CustomTextfield(hintText: '********', isPassword: true, controller: _confirmCtrl),
                          ],

                          const SizedBox(height: 18),

                          CustomButton(
                            text: _isSignup ? localizations.createAccount : localizations.login,
                            onTap: () async {
                              final email = _emailCtrl.text.trim();
                              final pass = _passCtrl.text;
                              final messenger = ScaffoldMessenger.of(context);

                              if (_isSignup) {
                                final name = _nameCtrl.text.trim();
                                final confirm = _confirmCtrl.text;
                                if (name.isEmpty || email.isEmpty || pass.isEmpty || confirm.isEmpty) {
                                  messenger.showSnackBar(SnackBar(content: Text(localizations.fillAllFields)));
                                  return;
                                }
                                if (pass != confirm) {
                                  messenger.showSnackBar(SnackBar(content: Text(localizations.passwordsDoNotMatch)));
                                  return;
                                }
                                final err = await _authRepo.registerUser(name, email, pass);
                                if (!mounted) return;
                                if (err != null) {
                                  messenger.showSnackBar(SnackBar(content: Text(err)));
                                  return;
                                }
                                messenger.showSnackBar(SnackBar(content: Text(localizations.accountCreated)));
                                setState(() => _isSignup = false);
                                return;
                              }

                              if (email.isEmpty || pass.isEmpty) {
                                messenger.showSnackBar(SnackBar(content: Text(localizations.enterEmailPassword)));
                                return;
                              }
                              messenger.showSnackBar(SnackBar(content: Text(localizations.verifying)));
                              final ok = await _authRepo.loginUser(email, pass);
                              if (!mounted) return;
                              if (!ok) {
                                messenger.showSnackBar(SnackBar(content: Text(localizations.invalidCredentials)));
                                return;
                              }
                              ref.read(currentUserNotifierProvider.notifier).refresh();
                              showWelcomeNotifier.value = true;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Center(child: Text(localizations.or, style: const TextStyle(color: Colors.grey))),
              const SizedBox(height: 12),

              socialButton(localizations.continueGoogle, Icons.g_mobiledata, Colors.red),
              const SizedBox(height: 10),
              socialButton(localizations.continueFacebook, Icons.facebook, Colors.blue),
            ],
          ),
        ),
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
