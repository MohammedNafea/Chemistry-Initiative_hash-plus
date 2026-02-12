import 'package:chemistry_initiative/splash_screen1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chemistry_initiative/core/database/app_database.dart';
import 'package:chemistry_initiative/core/theme/theme_controller.dart';
import 'package:chemistry_initiative/features/auth/presentation/widgets/auth_guard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.instance.init();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chemistry -Initiative',
      theme: ThemeData(
        // Using the "Warm Chocolate" palette from the splash screen
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5D4037),
          brightness: Brightness.dark,
          surface: const Color(0xFF1A120B),
          onSurface: const Color(0xFFF5F5DC),
        ),
        useMaterial3: true,
        fontFamily: 'Segoe UI',
      ),
      home: const SplashScreen(),
    );
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  void initState() {
    super.initState();
    // Ensure system UI is visible again after splash screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A120B), // Deep background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Color(0xFFFFD700), // Gold
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xFFF5F5DC),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "الصفحة الرئيسية", // "Home Page" in Arabic
          style: TextStyle(
            fontSize: 24,
            color: Color(0xFFF5F5DC),
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF2D1B15),
        selectedItemColor: const Color(0xFFFFD700),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "المناهج"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
        ],
      ),
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chemistry Initiative',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          darkTheme: ThemeData.dark(),
          themeMode: mode,
          home: const AuthGuard(),
        );
      },
    );
  }
}
