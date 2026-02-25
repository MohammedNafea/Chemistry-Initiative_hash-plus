import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chemistry_initiative/core/database/app_database.dart';
import 'package:chemistry_initiative/core/theme/theme_controller.dart';
import 'package:chemistry_initiative/core/theme/app_theme.dart';
import 'package:chemistry_initiative/splash_screen1.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';
import 'package:chemistry_initiative/core/localization/locale_provider.dart';

import 'package:chemistry_initiative/core/services/notification_service.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Load .env if exists (silent fail on web)
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      debugPrint("Dotenv load failed: $e");
    }

    // Initialize Firebase
    try {
      if (kIsWeb) {
        debugPrint("Initializing Firebase for Web...");
        if (Firebase.apps.isEmpty) {
          await Firebase.initializeApp(
            options: const FirebaseOptions(
              apiKey: "AIzaSyCLbyEaFC_oCXwstxmxQITja6WQGHixEX4",
              authDomain: "wonders-of-chemistry.firebaseapp.com",
              projectId: "wonders-of-chemistry",
              storageBucket: "wonders-of-chemistry.firebasestorage.app",
              messagingSenderId: "111827250668",
              appId: "1:111827250668:web:8336acdae7a5a82497e4c9",
              measurementId: "G-ERVTPVFW67",
            ),
          );
          debugPrint("Firebase initialized successfully on Web.");
        }
      } else {
        if (Firebase.apps.isEmpty) {
          await Firebase.initializeApp();
        }
      }
    } catch (e) {
      debugPrint("Firebase initialization failed: $e");
    }
  } catch (e) {
    debugPrint("Critical Pre-App failure: $e");
  }

  // Initialize secondary services
  try {
    await AppDatabase.instance.init();

    // Initialize and schedule daily notifications
    final notificationService = NotificationService();
    await notificationService.init();
    await notificationService.scheduleDailyChemFact();
  } catch (e) {
    debugPrint("Secondary services initialization failed: $e");
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return ValueListenableBuilder<bool>(
      valueListenable: highContrastNotifier,
      builder: (context, isHighContrast, _) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier,
          builder: (context, mode, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateTitle: (context) =>
                  AppLocalizations.of(context)?.appTitle ?? "Chemistry Wonders",
              theme: AppTheme.light,
              darkTheme: isHighContrast
                  ? AppTheme.highContrastDark
                  : AppTheme.dark,
              themeMode: isHighContrast ? ThemeMode.dark : mode,
              locale: locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}
