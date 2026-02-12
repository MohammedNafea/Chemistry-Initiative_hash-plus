import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:country_picker/country_picker.dart';

import 'package:chemistry_initiative/core/database/models/user_model.dart';
import 'package:chemistry_initiative/core/l10n/app_localizations.dart';
import 'package:chemistry_initiative/core/l10n/locale_provider.dart';
import 'package:chemistry_initiative/features/auth/data/current_user_provider.dart';
import 'package:chemistry_initiative/features/profile/data/profile_repository.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final ThemeMode currentThemeMode;
  const EditProfileScreen({super.key, required this.currentThemeMode});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

ImageProvider _avatarImageProvider(String imageUrl) {
  if (imageUrl.startsWith('assets/')) {
    return AssetImage(imageUrl);
  }
  if (imageUrl.startsWith('http')) {
    return AssetImage('assets/images/avatar.jpg'); // Network blocked; use local fallback
  }
  return FileImage(File(imageUrl));
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _locationController;

  String _fullPhoneNumber = '';
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final user = ref.read(currentUserNotifierProvider);
    _nameController = TextEditingController(text: user?.name ?? '');
    _bioController = TextEditingController(text: user?.bio ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _phoneController = TextEditingController();
    _fullPhoneNumber = user?.phone ?? '';
    _locationController = TextEditingController(text: user?.location ?? '');
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final user = ref.watch(currentUserNotifierProvider);
    final localizationAsync = ref.watch(localizationProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('يرجى تسجيل الدخول')),
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: localizationAsync.when(
          data: (localizations) => Text(
            localizations.editProfile,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          loading: () => const SizedBox(),
          error: (err, stack) => const SizedBox(),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final updated = user.copyWith(
                  name: _nameController.text.trim(),
                  bio: _bioController.text.trim(),
                  email: _emailController.text.trim(),
                  phone: _fullPhoneNumber,
                  location: _locationController.text.trim(),
                  imageUrl: _pickedImage?.path ?? user.imageUrl,
                );

                await ProfileRepository.instance.updateProfile(
                  updated,
                  previousEmail: user.email,
                );
                ref.read(currentUserNotifierProvider.notifier).refresh();

                final message = localizationAsync.maybeWhen(
                  data: (loc) => loc.profileUpdated,
                  orElse: () => 'Profile Updated!',
                );

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: colorScheme.primary,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  Navigator.pop(context);
                }
              }
            },
            child: localizationAsync.when(
              data: (localizations) => Text(
                localizations.save,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: colorScheme.primary,
                ),
              ),
              loading: () => const SizedBox(),
              error: (err, stack) => const SizedBox(),
            ),
          ),
        ],
      ),
      body: localizationAsync.when(
        data: (localizations) => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colorScheme.primary.withValues(alpha: 0.5),
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: colorScheme.surfaceContainerHighest,
                          backgroundImage: _pickedImage != null
                              ? FileImage(_pickedImage!) as ImageProvider
                              : _avatarImageProvider(user.imageUrl),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colorScheme.surface,
                                width: 3,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                _buildModernField(
                  controller: _nameController,
                  label: localizations.name,
                  icon: FontAwesomeIcons.user,
                  colorScheme: colorScheme,
                ),
                const SizedBox(height: 20),

                _buildModernField(
                  controller: _bioController,
                  label: localizations.bio,
                  icon: FontAwesomeIcons.idCard,
                  colorScheme: colorScheme,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),

                _buildModernField(
                  controller: _emailController,
                  label: localizations.email,
                  icon: FontAwesomeIcons.envelope,
                  colorScheme: colorScheme,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                _buildPhoneField(
                  colorScheme: colorScheme,
                  user: user,
                  localizations: localizations,
                ),
                const SizedBox(height: 20),

                _buildLocationField(
                  colorScheme: colorScheme,
                  localizations: localizations,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildModernField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required ColorScheme colorScheme,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: colorScheme.outline,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.1),
            ),
          ),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 15,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: colorScheme.primary.withValues(alpha: 0.7),
                size: 18,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              hintText: 'Enter $label',
              hintStyle: TextStyle(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField({
    required ColorScheme colorScheme,
    required UserModel user,
    required AppLocalizations localizations,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.phone.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: colorScheme.outline,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.1),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              _fullPhoneNumber = number.phoneNumber ?? '';
            },
            onInputValidated: (bool value) {},
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              setSelectorButtonAsPrefixIcon: true,
              leadingPadding: 10,
              trailingSpace: false,
              useEmoji: true,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: TextStyle(
              color: colorScheme.onSurface,
            ),
            initialValue: PhoneNumber(
              isoCode: 'SA',
              phoneNumber: user.phone,
            ),
            textFieldController: _phoneController,
            formatInput: true,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            inputDecoration: InputDecoration(
              border: InputBorder.none,
              hintText: localizations.phone,
              hintStyle: TextStyle(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
            textStyle: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 15,
            ),
            cursorColor: colorScheme.primary,
            searchBoxDecoration: InputDecoration(
              labelText: 'Search',
              labelStyle: TextStyle(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationField({
    required ColorScheme colorScheme,
    required AppLocalizations localizations,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.location.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: colorScheme.outline,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            showCountryPicker(
              context: context,
              showPhoneCode: false,
              onSelect: (Country country) {
                setState(() {
                  _locationController.text =
                      "${country.flagEmoji} ${country.name}";
                });
              },
              countryListTheme: CountryListThemeData(
                backgroundColor: colorScheme.surface,
                textStyle: TextStyle(color: colorScheme.onSurface),
                bottomSheetHeight: 500,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                inputDecoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'Start typing to search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorScheme.outline.withValues(alpha: 0.2),
                    ),
                  ),
                ),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.locationDot,
                  color: colorScheme.primary.withValues(alpha: 0.7),
                  size: 18,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _locationController.text.isNotEmpty
                        ? _locationController.text
                        : localizations.location,
                    style: TextStyle(
                      color: _locationController.text.isNotEmpty
                          ? colorScheme.onSurface
                          : colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                      fontSize: 15,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
