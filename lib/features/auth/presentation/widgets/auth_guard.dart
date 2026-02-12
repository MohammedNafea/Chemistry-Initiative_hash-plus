import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/features/auth/data/current_user_provider.dart';
import 'package:chemistry_initiative/features/auth/presentation/pages/login_screen.dart';
import 'package:chemistry_initiative/features/home/presentation/pages/home_page.dart';

/// Determines which screen to show based on auth state.
class AuthGuard extends ConsumerWidget {
  const AuthGuard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserNotifierProvider);
    return ValueListenableBuilder<bool>(
      valueListenable: showWelcomeNotifier,
      builder: (context, showWelcome, _) {
        if (user != null) {
          return HomePage(showWelcome: showWelcome);
        }
        return const LoginScreen();
      },
    );
  }
}
