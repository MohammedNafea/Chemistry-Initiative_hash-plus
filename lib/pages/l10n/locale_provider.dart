import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_localizations.dart';

final localeProvider = Provider<ValueNotifier<Locale>>(
  (ref) => ValueNotifier<Locale>(const Locale('en')),
);

final localizationProvider = FutureProvider<AppLocalizations>((ref) async {
  final locale = ref.watch(localeProvider).value;
  // In a real app you'd load localized resources based on `locale`.
  return AppLocalizations(locale);
});
