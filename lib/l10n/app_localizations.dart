import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('zh'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Chemistry Initiative'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @bookmark.
  ///
  /// In en, this message translates to:
  /// **'Bookmark'**
  String get bookmark;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @welcomeUser.
  ///
  /// In en, this message translates to:
  /// **'Welcome {name}'**
  String welcomeUser(String name);

  /// No description provided for @auroraTitle.
  ///
  /// In en, this message translates to:
  /// **'Aurora Borealis'**
  String get auroraTitle;

  /// No description provided for @exploreMore.
  ///
  /// In en, this message translates to:
  /// **'Explore More'**
  String get exploreMore;

  /// No description provided for @yourProgress.
  ///
  /// In en, this message translates to:
  /// **'Your Progress'**
  String get yourProgress;

  /// No description provided for @natureSection.
  ///
  /// In en, this message translates to:
  /// **'Nature'**
  String get natureSection;

  /// No description provided for @waterAirSection.
  ///
  /// In en, this message translates to:
  /// **'Water & Air'**
  String get waterAirSection;

  /// No description provided for @dailyLifeSection.
  ///
  /// In en, this message translates to:
  /// **'Daily Life'**
  String get dailyLifeSection;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Chemistry Wonders'**
  String get welcomeMessage;

  /// No description provided for @contactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact Info'**
  String get contactInfo;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @privacySecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacySecurity;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @burningGas.
  ///
  /// In en, this message translates to:
  /// **'Burning Gas'**
  String get burningGas;

  /// No description provided for @forests.
  ///
  /// In en, this message translates to:
  /// **'Forests'**
  String get forests;

  /// No description provided for @coalBurning.
  ///
  /// In en, this message translates to:
  /// **'Coal Burning'**
  String get coalBurning;

  /// No description provided for @rocks.
  ///
  /// In en, this message translates to:
  /// **'Rocks'**
  String get rocks;

  /// No description provided for @solutionAbsorption.
  ///
  /// In en, this message translates to:
  /// **'Solution Absorption'**
  String get solutionAbsorption;

  /// No description provided for @rainDrops.
  ///
  /// In en, this message translates to:
  /// **'Rain Drops'**
  String get rainDrops;

  /// No description provided for @factorySmoke.
  ///
  /// In en, this message translates to:
  /// **'Factory Smoke'**
  String get factorySmoke;

  /// No description provided for @crystal.
  ///
  /// In en, this message translates to:
  /// **'Crystal'**
  String get crystal;

  /// No description provided for @breadFermentation.
  ///
  /// In en, this message translates to:
  /// **'Bread Fermentation'**
  String get breadFermentation;

  /// No description provided for @medicalLabs.
  ///
  /// In en, this message translates to:
  /// **'Medical Labs'**
  String get medicalLabs;

  /// No description provided for @medicines.
  ///
  /// In en, this message translates to:
  /// **'Medicines'**
  String get medicines;

  /// No description provided for @combustion.
  ///
  /// In en, this message translates to:
  /// **'Combustion'**
  String get combustion;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @auroraBorealis.
  ///
  /// In en, this message translates to:
  /// **'Aurora Borealis'**
  String get auroraBorealis;

  /// No description provided for @nature.
  ///
  /// In en, this message translates to:
  /// **'Nature'**
  String get nature;

  /// No description provided for @waterAndAir.
  ///
  /// In en, this message translates to:
  /// **'Water & Air'**
  String get waterAndAir;

  /// No description provided for @dailyLife.
  ///
  /// In en, this message translates to:
  /// **'Daily Life'**
  String get dailyLife;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search for a topic...'**
  String get searchPlaceholder;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// No description provided for @noSavedTopics.
  ///
  /// In en, this message translates to:
  /// **'No saved topics'**
  String get noSavedTopics;

  /// No description provided for @saveYourFavorites.
  ///
  /// In en, this message translates to:
  /// **'Save your favorite topics'**
  String get saveYourFavorites;

  /// No description provided for @savedTopics.
  ///
  /// In en, this message translates to:
  /// **'Saved Topics'**
  String get savedTopics;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @bookmarks.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarks;

  /// No description provided for @topicDeleted.
  ///
  /// In en, this message translates to:
  /// **'Topic deleted'**
  String get topicDeleted;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @addToBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Add to Bookmarks'**
  String get addToBookmarks;

  /// No description provided for @addedToBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Added to Bookmarks'**
  String get addedToBookmarks;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @bio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bio;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile Updated Successfully'**
  String get profileUpdated;

  /// No description provided for @auroraQuestion.
  ///
  /// In en, this message translates to:
  /// **'Have you ever wondered why the sky sparkles with the colors of the Aurora Borealis?'**
  String get auroraQuestion;

  /// No description provided for @auroraDescription.
  ///
  /// In en, this message translates to:
  /// **'The Aurora Borealis occurs when charged particles from the sun collide with gases in the Earth\'s atmosphere, such as oxygen and nitrogen. These collisions excite atoms and molecules, giving them extra energy.\n• Oxygen at low altitude gives off green light\n• Oxygen at high altitude gives off red light\n• Nitrogen gives off blue and purple colors\n\nWhen these atoms return to their normal state, they release energy in the form of visible light. This process is the cause of the stunning colors of the aurora, a vivid example of a natural chemical and physical reaction observable in our daily lives.'**
  String get auroraDescription;

  /// No description provided for @wonders.
  ///
  /// In en, this message translates to:
  /// **'Wonders'**
  String get wonders;

  /// No description provided for @discoveryWorld.
  ///
  /// In en, this message translates to:
  /// **'A world of discoveries awaits you'**
  String get discoveryWorld;

  /// No description provided for @newAccount.
  ///
  /// In en, this message translates to:
  /// **'New Account'**
  String get newAccount;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get fillAllFields;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @accountCreated.
  ///
  /// In en, this message translates to:
  /// **'Account Created'**
  String get accountCreated;

  /// No description provided for @enterEmailPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter email and password'**
  String get enterEmailPassword;

  /// No description provided for @verifying.
  ///
  /// In en, this message translates to:
  /// **'Verifying...'**
  String get verifying;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get invalidCredentials;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @continueGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueGoogle;

  /// No description provided for @continueFacebook.
  ///
  /// In en, this message translates to:
  /// **'Continue with Facebook'**
  String get continueFacebook;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fa',
    'fr',
    'hi',
    'id',
    'it',
    'ja',
    'ko',
    'pt',
    'ru',
    'tr',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
