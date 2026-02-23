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
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  try {
    await dotenv.load(fileName: ".env");
    
    if (identical(0, 0.0)) { // Check if running on web
      // Use the verified Web API Key consistently
      const String webApiKey = "AIzaSyCLbyEaFC_oCXwstxmxQITja6WQGHixEX4";
      debugPrint("Initializing Firebase on Web with key: ${webApiKey.substring(0, 10)}...");
      
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: webApiKey,
            authDomain: "wonders-of-chemistry.firebaseapp.com",
            projectId: "wonders-of-chemistry",
            storageBucket: "wonders-of-chemistry.firebasestorage.app",
            messagingSenderId: "111827250668",
            appId: "1:111827250668:web:8336acdae7a5a82497e4c9",
            measurementId: "G-ERVTPVFW67",
          ),
        );
        debugPrint("Firebase initialized successfully on Web.");
      } else {
        debugPrint("Firebase already initialized on Web.");
      }
    } else {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }
    }
  } catch (e) {
    debugPrint("Firebase initialization failed: $e");
  }

  await AppDatabase.instance.init();

  // Initialize and schedule daily notifications
  final notificationService = NotificationService();
  await notificationService.init();
  await notificationService.scheduleDailyChemFact();

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
              onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
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
