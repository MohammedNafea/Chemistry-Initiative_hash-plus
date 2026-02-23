import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chemistry_initiative/core/localization/locale_provider.dart';

class LanguageSwitcher extends ConsumerWidget {
  final Color? iconColor;

  const LanguageSwitcher({super.key, this.iconColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);

    final languages = {
      'ar': 'العربية',
      'en': 'English',
      'tr': 'Türkçe',
      'fr': 'Français',
      'es': 'Español',
      'de': 'Deutsch',
      'it': 'Italiano',
      'ru': 'Русский',
      'zh': '中文',
      'ja': '日本語',
      'ko': '한국어',
      'hi': 'हिन्दी',
      'pt': 'Português',
      'id': 'Bahasa Indonesia',
      'fa': 'فارسی',
    };

    return PopupMenuButton<String>(
      icon: Icon(
        Icons.language,
        color: iconColor ?? Theme.of(context).iconTheme.color,
      ),
      tooltip: 'Change Language',
      onSelected: (String code) {
        ref.read(localeProvider.notifier).setLocale(Locale(code));
      },
      itemBuilder: (BuildContext context) {
        return languages.entries.map((entry) {
          return PopupMenuItem<String>(
            value: entry.key,
            child: Row(
              children: [
                Text(
                  entry.value,
                  style: TextStyle(
                    fontWeight: currentLocale.languageCode == entry.key
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: currentLocale.languageCode == entry.key
                        ? Theme.of(context).primaryColor
                        : null,
                  ),
                ),
                if (currentLocale.languageCode == entry.key) ...[
                  const Spacer(),
                  Icon(
                    Icons.check,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
