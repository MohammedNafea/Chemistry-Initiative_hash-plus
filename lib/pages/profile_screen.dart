import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import 'edit_profile_screen.dart';
import 'l10n/locale_provider.dart';
import 'l10n/app_localizations.dart';

// Color system (Design tokens)
const Color kTruffle = Color(0xFF605F4B); // Primary
const Color kOyster = Color(0xFFF9F4EA); // Background
const Color kSand = Color(0xFFCDAD85); // Cards / highlights
const Color kSage = Color(0xFF9C9E80); // Borders / muted
const Color kTerracotta = Color(0xFFC47457); // Accent / CTA
const Color kCopper = Color(0xFFB68036); // Accent / progress

// -----------------------------------------------------------------------------
// MODELS & STATE MANAGEMENT
// -----------------------------------------------------------------------------

class UserProfile {
  final String name;
  // final String role;
  final String bio;
  final String email;
  final String phone;
  final String location;
  final String imageUrl;

  UserProfile({
    required this.name,
    //required this.role,
    required this.bio,
    required this.email,
    required this.phone,
    required this.location,
    required this.imageUrl,
  });

  UserProfile copyWith({
    String? name,
    //String? role,
    String? bio,
    String? email,
    String? phone,
    String? location,
    String? imageUrl,
  }) {
    return UserProfile(
      name: name ?? this.name,
      // role: role ?? this.role,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

final userProfileProvider = Provider<ValueNotifier<UserProfile>>((ref) {
  return ValueNotifier<UserProfile>(
    UserProfile(
      name: 'أحمد علي',
      bio:
          '  مستكشف/ة فضولي/ة ',
      email: 'ahmed.ali@example.com',
      phone: '+966 5 5555 5555',
      location: 'الرياض، المملكة العربية السعودية',
      imageUrl: 'https://i.pravatar.cc/300',
    ),
  );
});

// -----------------------------------------------------------------------------
// PROFILE SCREEN (Sliver Layout)
// -----------------------------------------------------------------------------
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileNotifier = ref.watch(userProfileProvider);
    final userProfile = userProfileNotifier.value;
    final localizationAsync = ref.watch(localizationProvider);

    return localizationAsync.when(
      data: (localizations) {
        // Force Arabic only for this page
        final localizationsAr = AppLocalizations(const Locale('ar'));
        return Directionality(
          textDirection: localizationsAr.textDirection,
          child: Scaffold(
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF1D1B20)
                : kOyster,
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _ProfileSliverAppBar(
                  userProfile: userProfile,
                  localizations: localizationsAr,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        _SectionHeader(title: localizationsAr.contactInfo),
                        const SizedBox(height: 10),
                        _ContactInfoSection(
                          userProfile: userProfile,
                          localizations: localizationsAr,
                        ),
                        const SizedBox(height: 30),
                        _SectionHeader(title: localizationsAr.settings),
                        const SizedBox(height: 10),
                        _SettingsSection(localizations: localizationsAr),
                        const SizedBox(height: 40),
                        _ActionButtons(localizations: localizationsAr),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}

// -----------------------------------------------------------------------------
// WIDGETS
// -----------------------------------------------------------------------------

class _ProfileSliverAppBar extends StatelessWidget {
  final UserProfile userProfile;
  final AppLocalizations localizations;
  const _ProfileSliverAppBar({
    required this.userProfile,
    required this.localizations,
  });

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
            // Gradient Background
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

            // Decorative shapes
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

            // Profile Content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                // Avatar with Glow
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: kTruffle.withAlpha(128),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: kTruffle.withAlpha(51),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: NetworkImage(
                      userProfile.imageUrl,
                    ), // Replace with asset if needed
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  userProfile.name,
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : kTruffle,
                  ),
                ),
                // Text(
                //   //userProfile.role,
                //   style: GoogleFonts.poppins(
                //     fontSize: 16,
                //     color: colorScheme.primary,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: kSand.withAlpha(128),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    userProfile.bio,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white70 : kTruffle.withAlpha(230),
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
        color: isDark ? Colors.grey[400] : kSage,
      ),
    );
  }
}

class _ContactInfoSection extends ConsumerWidget {
  final UserProfile userProfile;
  final AppLocalizations localizations;
  const _ContactInfoSection({
    required this.userProfile,
    required this.localizations,
  });

  Future<void> _showEditSheet(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String initialValue,
    required TextInputType keyboardType,
    required void Function(String) onSave,
  }) async {
    final _formKey = GlobalKey<FormState>();
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
                key: _formKey,
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
                        backgroundColor: kTerracotta,
                      ),
                      child: Text(localizations.save),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          onSave(controller.text.trim());
                          Navigator.pop(context);
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
          subtitle: userProfile.email,
          isLink: true,
          onTap: () {
            _showEditSheet(
              context,
              ref,
              title: localizations.email,
              initialValue: userProfile.email,
              keyboardType: TextInputType.emailAddress,
              onSave: (val) {
                final notifier = ref.read(userProfileProvider);
                notifier.value = notifier.value.copyWith(email: val);
              },
            );
          },
        ),
        const SizedBox(height: 12),
        _SettingsTile(
          icon: FontAwesomeIcons.phone,
          title: localizations.phone,
          subtitle: userProfile.phone,
          isLink: true,
          onTap: () {
            _showEditSheet(
              context,
              ref,
              title: localizations.phone,
              initialValue: userProfile.phone,
              keyboardType: TextInputType.phone,
              onSave: (val) {
                final notifier = ref.read(userProfileProvider);
                notifier.value = notifier.value.copyWith(phone: val);
              },
            );
          },
        ),
        const SizedBox(height: 12),
        _SettingsTile(
          icon: FontAwesomeIcons.locationDot,
          title: localizations.location,
          subtitle: userProfile.location,
          onTap: () {
            _showEditSheet(
              context,
              ref,
              title: localizations.location,
              initialValue: userProfile.location,
              keyboardType: TextInputType.text,
              onSave: (val) {
                final notifier = ref.read(userProfileProvider);
                notifier.value = notifier.value.copyWith(location: val);
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
        // Theme Switcher
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
                    color: isDark ? const Color(0xFF2A2831) : kSand,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isDark ? FontAwesomeIcons.moon : FontAwesomeIcons.sun,
                    color: isDark ? Colors.white : kTruffle,
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
  bool _switchValue = true; // Local state for interactive demo

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
                : kOyster,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            widget.icon,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : kTruffle,
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
          // Custom onTap if provided
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

class _ActionButtons extends StatelessWidget {
  final AppLocalizations localizations;
  const _ActionButtons({required this.localizations});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: kTerracotta,
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
