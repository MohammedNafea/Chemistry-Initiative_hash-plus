import 'package:chemistry_initiative/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'theme_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Global theme controller used by screens
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
      builder: (context, mode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chemistry Initiative',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
          ),
          darkTheme: ThemeData.dark(),
          themeMode: mode,
          home: const LoginScreen(),
        );
      },
    );
  }
}
