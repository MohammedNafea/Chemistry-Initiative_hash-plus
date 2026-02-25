import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chemistry_initiative/core/theme/theme_controller.dart';
import 'package:chemistry_initiative/core/constants/app_colors.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';
// import 'package:chemistry_initiative/core/l10n/locale_provider.dart'; // Removed
import 'package:chemistry_initiative/core/database/models/user_model.dart';
import 'package:chemistry_initiative/features/auth/data/auth_repository.dart';
import 'package:chemistry_initiative/features/auth/data/current_user_provider.dart';
import 'package:chemistry_initiative/features/profile/data/profile_repository.dart';
import 'package:chemistry_initiative/features/profile/presentation/pages/edit_profile_screen.dart';
// import 'package:chemistry_initiative/features/auth/presentation/pages/login_screen.dart'; // Unused now that AuthGuard handles redirection
import 'package:chemistry_initiative/core/localization/language_switcher.dart';
import 'package:chemistry_initiative/core/utils/image_helper.dart';

import 'package:chemistry_initiative/features/gamification/data/repositories/achievement_repository.dart';
import 'package:chemistry_initiative/features/gamification/data/providers/achievement_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Check for 'New Scientist' badge on profile load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(achievementProvider).checkAndUnlock('login_1');
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserNotifierProvider);
    final localizations = AppLocalizations.of(context)!;

    if (user == null) {
      return Center(
        child: Text(localizations.user),
      ); // Should ideally be "Please login"
    }

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF1D1B20)
          : AppColors.oyster,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _ProfileSliverAppBar(user: user, localizations: localizations),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _SectionHeader(title: localizations.achievements),
                  const SizedBox(height: 10),
                  _BadgesSection(
                    userBadges: user.badges,
                    localizations: localizations,
                  ),
                  const SizedBox(height: 30),
                  _SectionHeader(title: localizations.contactInfo),
                  const SizedBox(height: 10),
                  _ContactInfoSection(user: user, localizations: localizations),
                  const SizedBox(height: 30),
                  _SectionHeader(title: localizations.settings),
                  const SizedBox(height: 10),
                  _SettingsSection(localizations: localizations),
                  const SizedBox(height: 40),
                  _ActionButtons(localizations: localizations, user: user),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgesSection extends StatelessWidget {
  final List<String> userBadges;
  final AppLocalizations localizations;

  const _BadgesSection({required this.userBadges, required this.localizations});

  String _getLocalizedText(String key) {
    switch (key) {
      case 'badgeNewScientist':
        return localizations.badgeNewScientist;
      case 'badgeQuizMaster':
        return localizations.badgeQuizMaster;
      case 'badgeSafetyExpert':
        return localizations.badgeSafetyExpert;
      case 'badgeNewScientistDesc':
        return localizations.badgeNewScientistDesc;
      case 'badgeQuizMasterDesc':
        return localizations.badgeQuizMasterDesc;
      case 'badgeSafetyExpertDesc':
        return localizations.badgeSafetyExpertDesc;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final allBadges = AchievementRepository.getBadges();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allBadges.length,
        itemBuilder: (context, index) {
          final badge = allBadges[index];
          final isUnlocked = userBadges.contains(badge.id);

          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                Opacity(
                  opacity: isUnlocked ? 1.0 : 0.4,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUnlocked
                          ? (isDark
                                ? Colors.amber.withValues(alpha: 0.2)
                                : Colors.amber.withValues(alpha: 0.2))
                          : (isDark ? Colors.grey[800] : Colors.grey[300]),
                      shape: BoxShape.circle,
                      border: isUnlocked
                          ? Border.all(color: Colors.amber, width: 2)
                          : null,
                    ),
                    child: Icon(
                      Icons.star_rounded, // Placeholder for badge icon
                      size: 32,
                      color: isUnlocked ? Colors.amber : Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _getLocalizedText(badge.name),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: isUnlocked
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isUnlocked
                        ? (isDark ? Colors.white : Colors.black)
                        : Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProfileSliverAppBar extends StatelessWidget {
  final UserModel user;
  final AppLocalizations localizations;
  const _ProfileSliverAppBar({required this.user, required this.localizations});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SliverAppBar(
      expandedHeight: 320,
      pinned: true,
      stretch: true,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: colorScheme.surface.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.edit_rounded, size: 20),
            tooltip: localizations.editProfile,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditProfileScreen(currentThemeMode: themeNotifier.value),
                ),
              );
            },
          ),
        ),
      ],
      backgroundColor: colorScheme.surface,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDark
                      ? [const Color(0xFF2A2831), const Color(0xFF1D1B20)]
                      : [const Color(0xFFF3EDF7), const Color(0xFFFFFFFF)],
                ),
              ),
            ),
            Positioned(
              top: -50,
              right: -50,
              child: CircleAvatar(
                radius: 130,
                backgroundColor: colorScheme.primary.withValues(alpha: 0.05),
              ),
            ),
            Positioned(
              bottom: 50,
              left: -30,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: colorScheme.secondary.withValues(alpha: 0.05),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.truffle.withAlpha(128),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.truffle.withAlpha(51),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: ImageHelper.getImageProvider(
                      user.imageUrl,
                    ),
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.truffle,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.sand.withAlpha(128),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    user.bio.isEmpty ? 'مستكشف فضولي' : user.bio,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? Colors.white70
                          : AppColors.truffle.withAlpha(230),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      title,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
        color: isDark ? Colors.grey[400] : AppColors.sage,
      ),
    );
  }
}

class _ContactInfoSection extends ConsumerWidget {
  final UserModel user;
  final AppLocalizations localizations;
  const _ContactInfoSection({required this.user, required this.localizations});

  Future<void> _showEditSheet(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String initialValue,
    required TextInputType keyboardType,
    required Future<void> Function(String) onSave,
  }) async {
    final formKey = GlobalKey<FormState>();
    final controller = TextEditingController(text: initialValue);

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Form(
                key: formKey,
                child: TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: title,
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'هذا الحقل مطلوب';
                    }
                    if (keyboardType == TextInputType.emailAddress &&
                        !RegExp(
                          r"^[\w\.-]+@[\w\.-]+\.[a-zA-Z]{2,}",
                        ).hasMatch(v)) {
                      return 'أدخل بريداً إلكترونياً صالحاً';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.terracotta,
                      ),
                      child: Text(localizations.save),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await onSave(controller.text.trim());
                          if (context.mounted) Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _SettingsTile(
          icon: FontAwesomeIcons.solidEnvelope,
          title: localizations.email,
          subtitle: user.email,
          isLink: true,
          onTap: () async {
            await _showEditSheet(
              context,
              ref,
              title: localizations.email,
              initialValue: user.email,
              keyboardType: TextInputType.emailAddress,
              onSave: (val) async {
                final updated = user.copyWith(email: val);
                await ProfileRepository.instance.updateProfile(
                  updated,
                  previousEmail: user.email,
                );
                ref.read(currentUserNotifierProvider.notifier).refresh();
              },
            );
          },
        ),
        const SizedBox(height: 12),
        _SettingsTile(
          icon: FontAwesomeIcons.phone,
          title: localizations.phone,
          subtitle: user.phone,
          isLink: true,
          onTap: () async {
            await _showEditSheet(
              context,
              ref,
              title: localizations.phone,
              initialValue: user.phone,
              keyboardType: TextInputType.phone,
              onSave: (val) async {
                final updated = user.copyWith(phone: val);
                await ProfileRepository.instance.updateProfile(
                  updated,
                  previousEmail: user.email,
                );
                ref.read(currentUserNotifierProvider.notifier).refresh();
              },
            );
          },
        ),
        const SizedBox(height: 12),
        _SettingsTile(
          icon: FontAwesomeIcons.locationDot,
          title: localizations.location,
          subtitle: user.location,
          onTap: () async {
            await _showEditSheet(
              context,
              ref,
              title: localizations.location,
              initialValue: user.location,
              keyboardType: TextInputType.text,
              onSave: (val) async {
                final updated = user.copyWith(location: val);
                await ProfileRepository.instance.updateProfile(
                  updated,
                  previousEmail: user.email,
                );
                ref.read(currentUserNotifierProvider.notifier).refresh();
              },
            );
          },
        ),
      ],
    );
  }
}

class _SettingsSection extends ConsumerWidget {
  final AppLocalizations localizations;
  const _SettingsSection({required this.localizations});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier,
          builder: (context, mode, child) {
            final isDark =
                mode == ThemeMode.dark ||
                (mode == ThemeMode.system &&
                    MediaQuery.platformBrightnessOf(context) ==
                        Brightness.dark);
            return Card(
              margin: EdgeInsets.zero,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2A2831) : AppColors.sand,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isDark ? FontAwesomeIcons.moon : FontAwesomeIcons.sun,
                    color: isDark ? Colors.white : AppColors.truffle,
                    size: 18,
                  ),
                ),
                title: Text(localizations.theme),
                trailing: Switch.adaptive(
                  value: mode == ThemeMode.dark,
                  onChanged: (value) {
                    themeNotifier.value = value
                        ? ThemeMode.dark
                        : ThemeMode.light;
                  },
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        // High Contrast Mode Toggle
        ValueListenableBuilder<bool>(
          valueListenable: highContrastNotifier,
          builder: (context, isHighContrast, child) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return Card(
              margin: EdgeInsets.zero,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2A2831) : AppColors.sand,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    FontAwesomeIcons.eye,
                    color: isDark ? Colors.white : AppColors.truffle,
                    size: 18,
                  ),
                ),
                title: const Text('وضع عمى الألوان (Color Blind)'),
                trailing: Switch.adaptive(
                  value: isHighContrast,
                  onChanged: (value) {
                    highContrastNotifier.value = value;
                  },
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF2A2831)
                    : AppColors.oyster,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.language,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : AppColors.truffle,
                size: 18,
              ),
            ),
            title: Text(localizations.language),
            trailing: const LanguageSwitcher(),
          ),
        ),
        const SizedBox(height: 12),
        _SettingsTile(
          icon: FontAwesomeIcons.bell,
          title: localizations.notifications,
          hasSwitch: true,
        ),
        const SizedBox(height: 12),
        _SettingsTile(
          icon: FontAwesomeIcons.shieldHalved,
          title: localizations.privacySecurity,
        ),
        const SizedBox(height: 12),
        _SettingsTile(
          icon: FontAwesomeIcons.circleQuestion,
          title: localizations.helpSupport,
        ),
      ],
    );
  }
}

class _SettingsTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool isLink;
  final bool hasSwitch;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.isLink = false,
    this.hasSwitch = false,
    this.onTap,
  });

  @override
  State<_SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<_SettingsTile> {
  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF2A2831)
                : AppColors.oyster,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            widget.icon,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : AppColors.truffle,
            size: 18,
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: widget.subtitle != null ? Text(widget.subtitle!) : null,
        trailing: widget.hasSwitch
            ? Switch.adaptive(
                value: _switchValue,
                onChanged: (v) {
                  setState(() {
                    _switchValue = v;
                  });
                },
              )
            : Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!.call();
            return;
          }
          if (widget.hasSwitch) {
            setState(() {
              _switchValue = !_switchValue;
            });
          }
        },
      ),
    );
  }
}

class _ActionButtons extends ConsumerWidget {
  final AppLocalizations localizations;
  final UserModel user;
  const _ActionButtons({required this.localizations, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              // 1. Show Confirmation Dialog
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(localizations.logout),
                  content: const Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text(
                        'إلغاء',
                      ), // localizations.cancel is missing, using hardcoded Arabic
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: Text(localizations.logout),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                // 2. Perform Logout
                await AuthRepository.instance.logout();

                // 3. Refresh Provider - This will trigger AuthGuard in main.dart
                ref.read(currentUserNotifierProvider.notifier).refresh();

                // Note: AuthGuard will handle the redirection automatically
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.terracotta,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
            ),
            icon: const Icon(FontAwesomeIcons.arrowRightFromBracket, size: 18),
            label: Text(localizations.logout),
          ),
        ),
      ],
    );
  }
}
