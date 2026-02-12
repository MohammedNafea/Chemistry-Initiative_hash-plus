import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/core/l10n/app_localizations.dart';

final localeProvider = Provider<ValueNotifier<Locale>>(
  (ref) => ValueNotifier<Locale>(const Locale('en')),
);

final localizationProvider = FutureProvider<AppLocalizations>((ref) async {
  final locale = ref.watch(localeProvider).value;
  return AppLocalizations(locale);
});
