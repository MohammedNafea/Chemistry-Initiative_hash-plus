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
  /// **'Chemistry Wonders'**
  String get appTitle;

  /// No description provided for @leaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboard;

  /// No description provided for @periodicTable.
  ///
  /// In en, this message translates to:
  /// **'Interactive Periodic Table'**
  String get periodicTable;

  /// No description provided for @dailyQuiz.
  ///
  /// In en, this message translates to:
  /// **'Daily Quiz'**
  String get dailyQuiz;

  /// No description provided for @whatsInThis.
  ///
  /// In en, this message translates to:
  /// **'What\'s in this?'**
  String get whatsInThis;

  /// No description provided for @safetyGuide.
  ///
  /// In en, this message translates to:
  /// **'Safety Guide'**
  String get safetyGuide;

  /// No description provided for @flammable.
  ///
  /// In en, this message translates to:
  /// **'Flammable'**
  String get flammable;

  /// No description provided for @flammableDesc.
  ///
  /// In en, this message translates to:
  /// **'Catches fire easily. Keep away from heat and flames.'**
  String get flammableDesc;

  /// No description provided for @oxidizer.
  ///
  /// In en, this message translates to:
  /// **'Oxidizer'**
  String get oxidizer;

  /// No description provided for @oxidizerDesc.
  ///
  /// In en, this message translates to:
  /// **'Can cause or intensify fire. Keep away from combustibles.'**
  String get oxidizerDesc;

  /// No description provided for @toxic.
  ///
  /// In en, this message translates to:
  /// **'Toxic'**
  String get toxic;

  /// No description provided for @toxicDesc.
  ///
  /// In en, this message translates to:
  /// **'Can cause death or serious illness if swallowed, inhaled, or touches skin.'**
  String get toxicDesc;

  /// No description provided for @corrosive.
  ///
  /// In en, this message translates to:
  /// **'Corrosive'**
  String get corrosive;

  /// No description provided for @corrosiveDesc.
  ///
  /// In en, this message translates to:
  /// **'Can switch skin burns and eye damage. Also damages metals.'**
  String get corrosiveDesc;

  /// No description provided for @explosive.
  ///
  /// In en, this message translates to:
  /// **'Explosive'**
  String get explosive;

  /// No description provided for @explosiveDesc.
  ///
  /// In en, this message translates to:
  /// **'May explode if heated or knocked.'**
  String get explosiveDesc;

  /// No description provided for @irritant.
  ///
  /// In en, this message translates to:
  /// **'Irritant'**
  String get irritant;

  /// No description provided for @irritantDesc.
  ///
  /// In en, this message translates to:
  /// **'May cause irritation to skin, eyes, or respiratory system.'**
  String get irritantDesc;

  /// No description provided for @healthHazard.
  ///
  /// In en, this message translates to:
  /// **'Health Hazard'**
  String get healthHazard;

  /// No description provided for @healthHazardDesc.
  ///
  /// In en, this message translates to:
  /// **'May cause serious long-term health effects (e.g. cancer).'**
  String get healthHazardDesc;

  /// No description provided for @environment.
  ///
  /// In en, this message translates to:
  /// **'Environmental Hazard'**
  String get environment;

  /// No description provided for @environmentDesc.
  ///
  /// In en, this message translates to:
  /// **'Harmful to aquatic life with long-lasting effects.'**
  String get environmentDesc;

  /// No description provided for @virtualLab.
  ///
  /// In en, this message translates to:
  /// **'Virtual Lab'**
  String get virtualLab;

  /// No description provided for @volcanoExp.
  ///
  /// In en, this message translates to:
  /// **'Baking Soda Volcano'**
  String get volcanoExp;

  /// No description provided for @volcanoDesc.
  ///
  /// In en, this message translates to:
  /// **'Create a classic volcanic eruption using kitchen ingredients.'**
  String get volcanoDesc;

  /// No description provided for @volcanoExplanation.
  ///
  /// In en, this message translates to:
  /// **'The reaction between baking soda (base) and vinegar (acid) produces carbon dioxide gas, which creates the bubbles and eruption.'**
  String get volcanoExplanation;

  /// No description provided for @cabbageExp.
  ///
  /// In en, this message translates to:
  /// **'Red Cabbage Indicator'**
  String get cabbageExp;

  /// No description provided for @cabbageDesc.
  ///
  /// In en, this message translates to:
  /// **'Test acidity of household liquids with a natural pH indicator.'**
  String get cabbageDesc;

  /// No description provided for @cabbageExplanation.
  ///
  /// In en, this message translates to:
  /// **'Red cabbage contains anthocyanin, a pigment that changes color depending on pH. Acide turn it red/pink, bases turn it blue/green.'**
  String get cabbageExplanation;

  /// No description provided for @invisibleInkExp.
  ///
  /// In en, this message translates to:
  /// **'Invisible Ink'**
  String get invisibleInkExp;

  /// No description provided for @invisibleInkDesc.
  ///
  /// In en, this message translates to:
  /// **'Write secret messages revealed by heat.'**
  String get invisibleInkDesc;

  /// No description provided for @inkExplanation.
  ///
  /// In en, this message translates to:
  /// **'Lemon juice is organic. When heated, it oxidizes and turns brown faster than the paper, revealing the message.'**
  String get inkExplanation;

  /// No description provided for @easy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get easy;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @hard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get hard;

  /// No description provided for @ingredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredients;

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get steps;

  /// No description provided for @scientificExplanation.
  ///
  /// In en, this message translates to:
  /// **'Scientific Explanation'**
  String get scientificExplanation;

  /// No description provided for @generalSafety.
  ///
  /// In en, this message translates to:
  /// **'Always perform with adult supervision.'**
  String get generalSafety;

  /// No description provided for @hotWaterSafety.
  ///
  /// In en, this message translates to:
  /// **'Be careful with hot water.'**
  String get hotWaterSafety;

  /// No description provided for @heatSafety.
  ///
  /// In en, this message translates to:
  /// **'Be careful when using heat sources.'**
  String get heatSafety;

  /// No description provided for @bakingSoda.
  ///
  /// In en, this message translates to:
  /// **'Baking Soda'**
  String get bakingSoda;

  /// No description provided for @vinegar.
  ///
  /// In en, this message translates to:
  /// **'Vinegar'**
  String get vinegar;

  /// No description provided for @foodColoring.
  ///
  /// In en, this message translates to:
  /// **'Food Coloring'**
  String get foodColoring;

  /// No description provided for @dishSoap.
  ///
  /// In en, this message translates to:
  /// **'Dish Soap'**
  String get dishSoap;

  /// No description provided for @container.
  ///
  /// In en, this message translates to:
  /// **'Container/Bottle'**
  String get container;

  /// No description provided for @redCabbage.
  ///
  /// In en, this message translates to:
  /// **'Red Cabbage'**
  String get redCabbage;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @lemonJuice.
  ///
  /// In en, this message translates to:
  /// **'Lemon Juice'**
  String get lemonJuice;

  /// No description provided for @cups.
  ///
  /// In en, this message translates to:
  /// **'Clear Cups'**
  String get cups;

  /// No description provided for @cottonSwab.
  ///
  /// In en, this message translates to:
  /// **'Cotton Swab'**
  String get cottonSwab;

  /// No description provided for @whitePaper.
  ///
  /// In en, this message translates to:
  /// **'White Paper'**
  String get whitePaper;

  /// No description provided for @heatSource.
  ///
  /// In en, this message translates to:
  /// **'Heat Source (Lamp/Iron)'**
  String get heatSource;

  /// No description provided for @hydrogenPeroxide.
  ///
  /// In en, this message translates to:
  /// **'Hydrogen Peroxide'**
  String get hydrogenPeroxide;

  /// No description provided for @yeast.
  ///
  /// In en, this message translates to:
  /// **'Yeast'**
  String get yeast;

  /// No description provided for @warmWater.
  ///
  /// In en, this message translates to:
  /// **'Warm Water'**
  String get warmWater;

  /// No description provided for @sugar.
  ///
  /// In en, this message translates to:
  /// **'Sugar'**
  String get sugar;

  /// No description provided for @boilingWater.
  ///
  /// In en, this message translates to:
  /// **'Boiling Water'**
  String get boilingWater;

  /// No description provided for @string.
  ///
  /// In en, this message translates to:
  /// **'String'**
  String get string;

  /// No description provided for @jar.
  ///
  /// In en, this message translates to:
  /// **'Jar'**
  String get jar;

  /// No description provided for @milk.
  ///
  /// In en, this message translates to:
  /// **'Milk'**
  String get milk;

  /// No description provided for @oil.
  ///
  /// In en, this message translates to:
  /// **'Oil'**
  String get oil;

  /// No description provided for @egg.
  ///
  /// In en, this message translates to:
  /// **'Egg'**
  String get egg;

  /// No description provided for @effervescentTablet.
  ///
  /// In en, this message translates to:
  /// **'Effervescent Tablet'**
  String get effervescentTablet;

  /// No description provided for @eyeProtection.
  ///
  /// In en, this message translates to:
  /// **'Wear eye protection.'**
  String get eyeProtection;

  /// No description provided for @volcanoStep1.
  ///
  /// In en, this message translates to:
  /// **'Place the container on a tray.'**
  String get volcanoStep1;

  /// No description provided for @volcanoStep2.
  ///
  /// In en, this message translates to:
  /// **'Add 2 spoons of baking soda and a few drops of food coloring.'**
  String get volcanoStep2;

  /// No description provided for @volcanoStep3.
  ///
  /// In en, this message translates to:
  /// **'Add a squirt of dish soap.'**
  String get volcanoStep3;

  /// No description provided for @volcanoStep4.
  ///
  /// In en, this message translates to:
  /// **'Pour in vinegar and watch it erupt!'**
  String get volcanoStep4;

  /// No description provided for @cabbageStep1.
  ///
  /// In en, this message translates to:
  /// **'Chop cabbage and boil in water to extract purple liquid.'**
  String get cabbageStep1;

  /// No description provided for @cabbageStep2.
  ///
  /// In en, this message translates to:
  /// **'Pour purple liquid into cups.'**
  String get cabbageStep2;

  /// No description provided for @cabbageStep3.
  ///
  /// In en, this message translates to:
  /// **'Add different household liquids (lemon, soap, etc.) to each cup.'**
  String get cabbageStep3;

  /// No description provided for @cabbageStep4.
  ///
  /// In en, this message translates to:
  /// **'Observe the color changes!'**
  String get cabbageStep4;

  /// No description provided for @inkStep1.
  ///
  /// In en, this message translates to:
  /// **'Dip swab in lemon juice and write on paper.'**
  String get inkStep1;

  /// No description provided for @inkStep2.
  ///
  /// In en, this message translates to:
  /// **'Let it dry completely.'**
  String get inkStep2;

  /// No description provided for @inkStep3.
  ///
  /// In en, this message translates to:
  /// **'Heat the paper gently to reveal the message.'**
  String get inkStep3;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @badgeNewScientist.
  ///
  /// In en, this message translates to:
  /// **'New Scientist'**
  String get badgeNewScientist;

  /// No description provided for @badgeNewScientistDesc.
  ///
  /// In en, this message translates to:
  /// **'Logged in for the first time.'**
  String get badgeNewScientistDesc;

  /// No description provided for @badgeQuizMaster.
  ///
  /// In en, this message translates to:
  /// **'Quiz Master'**
  String get badgeQuizMaster;

  /// No description provided for @badgeQuizMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'Completed 5 Quizzes.'**
  String get badgeQuizMasterDesc;

  /// No description provided for @badgeSafetyExpert.
  ///
  /// In en, this message translates to:
  /// **'Safety Expert'**
  String get badgeSafetyExpert;

  /// No description provided for @badgeSafetyExpertDesc.
  ///
  /// In en, this message translates to:
  /// **'Read the Safety Guide.'**
  String get badgeSafetyExpertDesc;

  /// No description provided for @moleculeViewer.
  ///
  /// In en, this message translates to:
  /// **'3D Molecule Viewer'**
  String get moleculeViewer;

  /// No description provided for @molWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get molWater;

  /// No description provided for @factWater.
  ///
  /// In en, this message translates to:
  /// **'Life as we know it would not exist without this compound!'**
  String get factWater;

  /// No description provided for @molH2.
  ///
  /// In en, this message translates to:
  /// **'Hydrogen Gas'**
  String get molH2;

  /// No description provided for @factH2.
  ///
  /// In en, this message translates to:
  /// **'The simplest and most abundant element in the universe.'**
  String get factH2;

  /// No description provided for @molO2.
  ///
  /// In en, this message translates to:
  /// **'Oxygen Gas'**
  String get molO2;

  /// No description provided for @factO2.
  ///
  /// In en, this message translates to:
  /// **'Essential for human respiration and combustion.'**
  String get factO2;

  /// No description provided for @molN2.
  ///
  /// In en, this message translates to:
  /// **'Nitrogen Gas'**
  String get molN2;

  /// No description provided for @factN2.
  ///
  /// In en, this message translates to:
  /// **'Makes up about 78% of Earth\'s atmosphere.'**
  String get factN2;

  /// No description provided for @molCl2.
  ///
  /// In en, this message translates to:
  /// **'Chlorine Gas'**
  String get molCl2;

  /// No description provided for @factCl2.
  ///
  /// In en, this message translates to:
  /// **'A yellowish-green gas used as a disinfectant and bleach.'**
  String get factCl2;

  /// No description provided for @molCo2.
  ///
  /// In en, this message translates to:
  /// **'Carbon Dioxide'**
  String get molCo2;

  /// No description provided for @factCo2.
  ///
  /// In en, this message translates to:
  /// **'A colorless gas vital to life on Earth. Plants breathe this in to produce oxygen.'**
  String get factCo2;

  /// No description provided for @molMethane.
  ///
  /// In en, this message translates to:
  /// **'Methane'**
  String get molMethane;

  /// No description provided for @factMethane.
  ///
  /// In en, this message translates to:
  /// **'A potent greenhouse gas and the main component of natural gas.'**
  String get factMethane;

  /// No description provided for @molSalt.
  ///
  /// In en, this message translates to:
  /// **'Sodium Chloride (Salt)'**
  String get molSalt;

  /// No description provided for @factSalt.
  ///
  /// In en, this message translates to:
  /// **'Common table salt. Essential for many biological processes.'**
  String get factSalt;

  /// No description provided for @molAmmonia.
  ///
  /// In en, this message translates to:
  /// **'Ammonia'**
  String get molAmmonia;

  /// No description provided for @factAmmonia.
  ///
  /// In en, this message translates to:
  /// **'Widely used in fertilizers and cleaning products.'**
  String get factAmmonia;

  /// No description provided for @molHcl.
  ///
  /// In en, this message translates to:
  /// **'Hydrochloric Acid'**
  String get molHcl;

  /// No description provided for @factHcl.
  ///
  /// In en, this message translates to:
  /// **'A strong acid found in your stomach that helps digest food.'**
  String get factHcl;

  /// No description provided for @molH2so4.
  ///
  /// In en, this message translates to:
  /// **'Sulfuric Acid'**
  String get molH2so4;

  /// No description provided for @factH2so4.
  ///
  /// In en, this message translates to:
  /// **'A highly corrosive acid used in batteries and mineral processing.'**
  String get factH2so4;

  /// No description provided for @molNaoh.
  ///
  /// In en, this message translates to:
  /// **'Sodium Hydroxide (Lye)'**
  String get molNaoh;

  /// No description provided for @factNaoh.
  ///
  /// In en, this message translates to:
  /// **'A strong base used in soap making and drain cleaning.'**
  String get factNaoh;

  /// No description provided for @molTio2.
  ///
  /// In en, this message translates to:
  /// **'Titanium Dioxide'**
  String get molTio2;

  /// No description provided for @factTio2.
  ///
  /// In en, this message translates to:
  /// **'A white pigment used in paints, sunscreens, and food coloring.'**
  String get factTio2;

  /// No description provided for @molPto2.
  ///
  /// In en, this message translates to:
  /// **'Platinum Dioxide'**
  String get molPto2;

  /// No description provided for @factPto2.
  ///
  /// In en, this message translates to:
  /// **'Also known as Adams\' catalyst; used in organic chemistry reactions.'**
  String get factPto2;

  /// No description provided for @molCro3.
  ///
  /// In en, this message translates to:
  /// **'Chromium Trioxide'**
  String get molCro3;

  /// No description provided for @factCro3.
  ///
  /// In en, this message translates to:
  /// **'A powerful oxidizing agent used in metal plating.'**
  String get factCro3;

  /// No description provided for @molH2o2.
  ///
  /// In en, this message translates to:
  /// **'Hydrogen Peroxide'**
  String get molH2o2;

  /// No description provided for @factH2o2.
  ///
  /// In en, this message translates to:
  /// **'A common antiseptic and oxidizing agent used in bleaching.'**
  String get factH2o2;

  /// No description provided for @molFe2o3.
  ///
  /// In en, this message translates to:
  /// **'Iron(III) Oxide (Rust)'**
  String get molFe2o3;

  /// No description provided for @factFe2o3.
  ///
  /// In en, this message translates to:
  /// **'Formed when iron reacts with oxygen in the presence of water.'**
  String get factFe2o3;

  /// No description provided for @molEthanol.
  ///
  /// In en, this message translates to:
  /// **'Ethanol'**
  String get molEthanol;

  /// No description provided for @factEthanol.
  ///
  /// In en, this message translates to:
  /// **'A clear, colorless liquid; the principal type of alcohol in beverages.'**
  String get factEthanol;

  /// No description provided for @molGlucose.
  ///
  /// In en, this message translates to:
  /// **'Glucose'**
  String get molGlucose;

  /// No description provided for @factGlucose.
  ///
  /// In en, this message translates to:
  /// **'A simple sugar that is an important energy source in living organisms.'**
  String get factGlucose;

  /// No description provided for @molSio2.
  ///
  /// In en, this message translates to:
  /// **'Silicon Dioxide (Sand)'**
  String get molSio2;

  /// No description provided for @factSio2.
  ///
  /// In en, this message translates to:
  /// **'The major constituent of sand and glass.'**
  String get factSio2;

  /// No description provided for @molCaco3.
  ///
  /// In en, this message translates to:
  /// **'Calcium Carbonate (Chalk)'**
  String get molCaco3;

  /// No description provided for @factCaco3.
  ///
  /// In en, this message translates to:
  /// **'Main component of pearls, shells, and chalk.'**
  String get factCaco3;

  /// No description provided for @molAl2o3.
  ///
  /// In en, this message translates to:
  /// **'Aluminum Oxide (Sapphire)'**
  String get molAl2o3;

  /// No description provided for @factAl2o3.
  ///
  /// In en, this message translates to:
  /// **'A hard mineral used as an abrasive and in gemstones.'**
  String get factAl2o3;

  /// No description provided for @journal.
  ///
  /// In en, this message translates to:
  /// **'Discovery Journal'**
  String get journal;

  /// No description provided for @dictionary.
  ///
  /// In en, this message translates to:
  /// **'Chemical Dictionary'**
  String get dictionary;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data found.'**
  String get noData;

  /// No description provided for @molAucl3.
  ///
  /// In en, this message translates to:
  /// **'Gold(III) Chloride'**
  String get molAucl3;

  /// No description provided for @factAucl3.
  ///
  /// In en, this message translates to:
  /// **'A red crystalline solid formed by dissolving gold in aqua regia.'**
  String get factAucl3;

  /// No description provided for @molAceticAcid.
  ///
  /// In en, this message translates to:
  /// **'Acetic Acid (Vinegar)'**
  String get molAceticAcid;

  /// No description provided for @factAceticAcid.
  ///
  /// In en, this message translates to:
  /// **'A weak acid responsible for the sour taste of vinegar.'**
  String get factAceticAcid;

  /// No description provided for @molSodiumBicarbonate.
  ///
  /// In en, this message translates to:
  /// **'Sodium Bicarbonate (Baking Soda)'**
  String get molSodiumBicarbonate;

  /// No description provided for @factSodiumBicarbonate.
  ///
  /// In en, this message translates to:
  /// **'A salt used in baking to help dough rise.'**
  String get factSodiumBicarbonate;

  /// No description provided for @molSoap.
  ///
  /// In en, this message translates to:
  /// **'Soap (Sodium Stearate)'**
  String get molSoap;

  /// No description provided for @factSoap.
  ///
  /// In en, this message translates to:
  /// **'Used for cleaning; created by reacting fats with lye.'**
  String get factSoap;

  /// No description provided for @molVolcano.
  ///
  /// In en, this message translates to:
  /// **'Volcanic Eruption!'**
  String get molVolcano;

  /// No description provided for @factVolcano.
  ///
  /// In en, this message translates to:
  /// **'A classic reaction releasing carbon dioxide gas rapidly.'**
  String get factVolcano;

  /// No description provided for @compounds.
  ///
  /// In en, this message translates to:
  /// **'Compounds'**
  String get compounds;

  /// No description provided for @labManual.
  ///
  /// In en, this message translates to:
  /// **'Lab Manual'**
  String get labManual;

  /// No description provided for @catalystPanel.
  ///
  /// In en, this message translates to:
  /// **'Catalyst Panel'**
  String get catalystPanel;

  /// No description provided for @recipes.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get recipes;

  /// No description provided for @discovered.
  ///
  /// In en, this message translates to:
  /// **'Discovered'**
  String get discovered;

  /// No description provided for @undiscovered.
  ///
  /// In en, this message translates to:
  /// **'Undiscovered'**
  String get undiscovered;

  /// No description provided for @chemicalOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'Chemical of the Day'**
  String get chemicalOfTheDay;

  /// No description provided for @didYouKnow.
  ///
  /// In en, this message translates to:
  /// **'Did you know?'**
  String get didYouKnow;

  /// No description provided for @dailyUse.
  ///
  /// In en, this message translates to:
  /// **'Daily Use:'**
  String get dailyUse;

  /// No description provided for @chemOxygen.
  ///
  /// In en, this message translates to:
  /// **'Oxygen'**
  String get chemOxygen;

  /// No description provided for @chemOxygenUse.
  ///
  /// In en, this message translates to:
  /// **'Essential for breathing and steel production.'**
  String get chemOxygenUse;

  /// No description provided for @chemGold.
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get chemGold;

  /// No description provided for @chemGoldUse.
  ///
  /// In en, this message translates to:
  /// **'Used in electronics and jewelry due to its conductivity.'**
  String get chemGoldUse;

  /// No description provided for @chemCarbon.
  ///
  /// In en, this message translates to:
  /// **'Carbon'**
  String get chemCarbon;

  /// No description provided for @chemCarbonUse.
  ///
  /// In en, this message translates to:
  /// **'The basis of all known life forms.'**
  String get chemCarbonUse;

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

  /// No description provided for @atomicNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Atomic Number'**
  String get atomicNumberLabel;

  /// No description provided for @dailyLifeUseLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily Life Use'**
  String get dailyLifeUseLabel;

  /// No description provided for @scientificSummaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Scientific Summary'**
  String get scientificSummaryLabel;

  /// No description provided for @massLabel.
  ///
  /// In en, this message translates to:
  /// **'Mass'**
  String get massLabel;

  /// No description provided for @categoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryLabel;

  /// No description provided for @catNonmetal.
  ///
  /// In en, this message translates to:
  /// **'Nonmetal'**
  String get catNonmetal;

  /// No description provided for @compoundPlayground.
  ///
  /// In en, this message translates to:
  /// **'Compound Playground'**
  String get compoundPlayground;

  /// No description provided for @selectElementsMix.
  ///
  /// In en, this message translates to:
  /// **'Select elements to mix'**
  String get selectElementsMix;

  /// No description provided for @elementsRepository.
  ///
  /// In en, this message translates to:
  /// **'Elements Repository'**
  String get elementsRepository;

  /// No description provided for @mixElements.
  ///
  /// In en, this message translates to:
  /// **'Mix Elements'**
  String get mixElements;

  /// No description provided for @catNobleGas.
  ///
  /// In en, this message translates to:
  /// **'Noble Gas'**
  String get catNobleGas;

  /// No description provided for @catAlkaliMetal.
  ///
  /// In en, this message translates to:
  /// **'Alkali Metal'**
  String get catAlkaliMetal;

  /// No description provided for @catAlkalineEarth.
  ///
  /// In en, this message translates to:
  /// **'Alkaline Earth Metal'**
  String get catAlkalineEarth;

  /// No description provided for @catMetalloid.
  ///
  /// In en, this message translates to:
  /// **'Metalloid'**
  String get catMetalloid;

  /// No description provided for @catHalogen.
  ///
  /// In en, this message translates to:
  /// **'Halogen'**
  String get catHalogen;

  /// No description provided for @catPostTransition.
  ///
  /// In en, this message translates to:
  /// **'Post-transition Metal'**
  String get catPostTransition;

  /// No description provided for @catTransition.
  ///
  /// In en, this message translates to:
  /// **'Transition Metal'**
  String get catTransition;

  /// No description provided for @catLanthanide.
  ///
  /// In en, this message translates to:
  /// **'Lanthanide'**
  String get catLanthanide;

  /// No description provided for @catActinide.
  ///
  /// In en, this message translates to:
  /// **'Actinide'**
  String get catActinide;

  /// No description provided for @elemHName.
  ///
  /// In en, this message translates to:
  /// **'Hydrogen'**
  String get elemHName;

  /// No description provided for @elemHSummary.
  ///
  /// In en, this message translates to:
  /// **'Hydrogen is the lightest element and the most abundant chemical substance in the universe.'**
  String get elemHSummary;

  /// No description provided for @elemHUse.
  ///
  /// In en, this message translates to:
  /// **'Found in Water (H2O), rocket fuel, and stars.'**
  String get elemHUse;

  /// No description provided for @elemHeName.
  ///
  /// In en, this message translates to:
  /// **'Helium'**
  String get elemHeName;

  /// No description provided for @elemHeSummary.
  ///
  /// In en, this message translates to:
  /// **'Helium is a colorless, odorless, tasteless, non-toxic, inert, monatomic gas.'**
  String get elemHeSummary;

  /// No description provided for @elemHeUse.
  ///
  /// In en, this message translates to:
  /// **'Used in party balloons, MRI machines, and deep-sea diving.'**
  String get elemHeUse;

  /// No description provided for @elemLiName.
  ///
  /// In en, this message translates to:
  /// **'Lithium'**
  String get elemLiName;

  /// No description provided for @elemLiSummary.
  ///
  /// In en, this message translates to:
  /// **'Lithium is a soft, silvery-white alkali metal. It is the lightest metal.'**
  String get elemLiSummary;

  /// No description provided for @elemLiUse.
  ///
  /// In en, this message translates to:
  /// **'Essential for rechargeable batteries in phones and laptops.'**
  String get elemLiUse;

  /// No description provided for @elemBeName.
  ///
  /// In en, this message translates to:
  /// **'Beryllium'**
  String get elemBeName;

  /// No description provided for @elemBeSummary.
  ///
  /// In en, this message translates to:
  /// **'Beryllium is a steel-gray, strong, lightweight and brittle alkaline earth metal.'**
  String get elemBeSummary;

  /// No description provided for @elemBeUse.
  ///
  /// In en, this message translates to:
  /// **'Used in aerospace material and X-ray windows.'**
  String get elemBeUse;

  /// No description provided for @elemBName.
  ///
  /// In en, this message translates to:
  /// **'Boron'**
  String get elemBName;

  /// No description provided for @elemBSummary.
  ///
  /// In en, this message translates to:
  /// **'Boron is a metalloid found in Earth\'s crust. It is essential for plant cell walls.'**
  String get elemBSummary;

  /// No description provided for @elemBUse.
  ///
  /// In en, this message translates to:
  /// **'Used in fiberglass, pyrotechnics, and eye drops.'**
  String get elemBUse;

  /// No description provided for @elemCName.
  ///
  /// In en, this message translates to:
  /// **'Carbon'**
  String get elemCName;

  /// No description provided for @elemCSummary.
  ///
  /// In en, this message translates to:
  /// **'Carbon is the basis of all known life and can exist as diamond or graphite.'**
  String get elemCSummary;

  /// No description provided for @elemCUse.
  ///
  /// In en, this message translates to:
  /// **'Found in pencils, diamonds, and all living organisms.'**
  String get elemCUse;

  /// No description provided for @elemNName.
  ///
  /// In en, this message translates to:
  /// **'Nitrogen'**
  String get elemNName;

  /// No description provided for @elemNSummary.
  ///
  /// In en, this message translates to:
  /// **'Nitrogen makes up 78% of Earth\'s atmosphere. It is essential for life.'**
  String get elemNSummary;

  /// No description provided for @elemNUse.
  ///
  /// In en, this message translates to:
  /// **'Used in fertilizers, food packaging, and liquid nitrogen.'**
  String get elemNUse;

  /// No description provided for @elemOName.
  ///
  /// In en, this message translates to:
  /// **'Oxygen'**
  String get elemOName;

  /// No description provided for @elemOSummary.
  ///
  /// In en, this message translates to:
  /// **'Oxygen is a highly reactive nonmetal and essential for respiration.'**
  String get elemOSummary;

  /// No description provided for @elemOUse.
  ///
  /// In en, this message translates to:
  /// **'Essential for breathing, combustion, and water.'**
  String get elemOUse;

  /// No description provided for @elemFName.
  ///
  /// In en, this message translates to:
  /// **'Fluorine'**
  String get elemFName;

  /// No description provided for @elemFSummary.
  ///
  /// In en, this message translates to:
  /// **'Fluorine is the most electronegative element and extremely reactive.'**
  String get elemFSummary;

  /// No description provided for @elemFUse.
  ///
  /// In en, this message translates to:
  /// **'Used in toothpaste and refrigeration (Freon).'**
  String get elemFUse;

  /// No description provided for @elemNeName.
  ///
  /// In en, this message translates to:
  /// **'Neon'**
  String get elemNeName;

  /// No description provided for @elemNeSummary.
  ///
  /// In en, this message translates to:
  /// **'Neon is a noble gas that gives off a bright orange-red glow in lamps.'**
  String get elemNeSummary;

  /// No description provided for @elemNeUse.
  ///
  /// In en, this message translates to:
  /// **'Used in advertising signs and laser technology.'**
  String get elemNeUse;

  /// No description provided for @elemNaName.
  ///
  /// In en, this message translates to:
  /// **'Sodium'**
  String get elemNaName;

  /// No description provided for @elemNaSummary.
  ///
  /// In en, this message translates to:
  /// **'Sodium is a soft, silvery-white, highly reactive alkali metal.'**
  String get elemNaSummary;

  /// No description provided for @elemNaUse.
  ///
  /// In en, this message translates to:
  /// **'Main component of table salt (NaCl) and street lights.'**
  String get elemNaUse;

  /// No description provided for @elemMgName.
  ///
  /// In en, this message translates to:
  /// **'Magnesium'**
  String get elemMgName;

  /// No description provided for @elemMgSummary.
  ///
  /// In en, this message translates to:
  /// **'Magnesium is a shiny gray solid alkaline earth metal.'**
  String get elemMgSummary;

  /// No description provided for @elemMgUse.
  ///
  /// In en, this message translates to:
  /// **'Used in flares, laptops, and human muscle function.'**
  String get elemMgUse;

  /// No description provided for @elemAlName.
  ///
  /// In en, this message translates to:
  /// **'Aluminum'**
  String get elemAlName;

  /// No description provided for @elemAlSummary.
  ///
  /// In en, this message translates to:
  /// **'Aluminum is a lightweight, silvery-white, non-magnetic metal.'**
  String get elemAlSummary;

  /// No description provided for @elemAlUse.
  ///
  /// In en, this message translates to:
  /// **'Used in soda cans, foil, airplanes, and window frames.'**
  String get elemAlUse;

  /// No description provided for @elemSiName.
  ///
  /// In en, this message translates to:
  /// **'Silicon'**
  String get elemSiName;

  /// No description provided for @elemSiSummary.
  ///
  /// In en, this message translates to:
  /// **'Silicon is a hard, brittle crystalline metalloid widely used in electronics.'**
  String get elemSiSummary;

  /// No description provided for @elemSiUse.
  ///
  /// In en, this message translates to:
  /// **'The heart of computer chips and glass production.'**
  String get elemSiUse;

  /// No description provided for @elemPName.
  ///
  /// In en, this message translates to:
  /// **'Phosphorus'**
  String get elemPName;

  /// No description provided for @elemPSummary.
  ///
  /// In en, this message translates to:
  /// **'Phosphorus is a reactive nonmetal. It is vital for DNA and cell energy.'**
  String get elemPSummary;

  /// No description provided for @elemPUse.
  ///
  /// In en, this message translates to:
  /// **'Used in fertilizers, match heads, and cleaning agents.'**
  String get elemPUse;

  /// No description provided for @elemSName.
  ///
  /// In en, this message translates to:
  /// **'Sulfur'**
  String get elemSName;

  /// No description provided for @elemSSummary.
  ///
  /// In en, this message translates to:
  /// **'Sulfur is a bright yellow, brittle nonmetal at room temperature.'**
  String get elemSSummary;

  /// No description provided for @elemSUse.
  ///
  /// In en, this message translates to:
  /// **'Used in gunpowder, batteries, and vulcanizing rubber.'**
  String get elemSUse;

  /// No description provided for @elemClName.
  ///
  /// In en, this message translates to:
  /// **'Chlorine'**
  String get elemClName;

  /// No description provided for @elemClSummary.
  ///
  /// In en, this message translates to:
  /// **'Chlorine is a yellow-green gas with a strong, bleaching odor.'**
  String get elemClSummary;

  /// No description provided for @elemClUse.
  ///
  /// In en, this message translates to:
  /// **'Used to disinfect swimming pools and in bleach.'**
  String get elemClUse;

  /// No description provided for @elemArName.
  ///
  /// In en, this message translates to:
  /// **'Argon'**
  String get elemArName;

  /// No description provided for @elemArSummary.
  ///
  /// In en, this message translates to:
  /// **'Argon is the most common noble gas in Earth\'s atmosphere.'**
  String get elemArSummary;

  /// No description provided for @elemArUse.
  ///
  /// In en, this message translates to:
  /// **'Used in light bulbs and high-temperature welding.'**
  String get elemArUse;

  /// No description provided for @elemKName.
  ///
  /// In en, this message translates to:
  /// **'Potassium'**
  String get elemKName;

  /// No description provided for @elemKSummary.
  ///
  /// In en, this message translates to:
  /// **'Potassium is a soft, silvery alkali metal that reacts violently with water.'**
  String get elemKSummary;

  /// No description provided for @elemKUse.
  ///
  /// In en, this message translates to:
  /// **'Found in bananas and essential for heart function.'**
  String get elemKUse;

  /// No description provided for @elemCaName.
  ///
  /// In en, this message translates to:
  /// **'Calcium'**
  String get elemCaName;

  /// No description provided for @elemCaSummary.
  ///
  /// In en, this message translates to:
  /// **'Calcium is a grey alkaline earth metal, the most abundant metal in humans.'**
  String get elemCaSummary;

  /// No description provided for @elemCaUse.
  ///
  /// In en, this message translates to:
  /// **'Found in milk, bones, teeth, and cement.'**
  String get elemCaUse;

  /// No description provided for @elemFeName.
  ///
  /// In en, this message translates to:
  /// **'Iron'**
  String get elemFeName;

  /// No description provided for @elemFeSummary.
  ///
  /// In en, this message translates to:
  /// **'Iron is the most common element on Earth by mass, forming much of the core.'**
  String get elemFeSummary;

  /// No description provided for @elemFeUse.
  ///
  /// In en, this message translates to:
  /// **'Used in steel construction and found in red blood cells.'**
  String get elemFeUse;

  /// No description provided for @elemCuName.
  ///
  /// In en, this message translates to:
  /// **'Copper'**
  String get elemCuName;

  /// No description provided for @elemCuSummary.
  ///
  /// In en, this message translates to:
  /// **'Copper is a soft, malleable, and ductile metal with very high conductivity.'**
  String get elemCuSummary;

  /// No description provided for @elemCuUse.
  ///
  /// In en, this message translates to:
  /// **'Used in electrical wiring and plumbing pipes.'**
  String get elemCuUse;

  /// No description provided for @elemZnName.
  ///
  /// In en, this message translates to:
  /// **'Zinc'**
  String get elemZnName;

  /// No description provided for @elemZnSummary.
  ///
  /// In en, this message translates to:
  /// **'Zinc is a slightly brittle metal at room temperature.'**
  String get elemZnSummary;

  /// No description provided for @elemZnUse.
  ///
  /// In en, this message translates to:
  /// **'Used to galvanize steel and in sunscreen.'**
  String get elemZnUse;

  /// No description provided for @elemAgName.
  ///
  /// In en, this message translates to:
  /// **'Silver'**
  String get elemAgName;

  /// No description provided for @elemAgSummary.
  ///
  /// In en, this message translates to:
  /// **'Silver has the highest electrical and thermal conductivity of any metal.'**
  String get elemAgSummary;

  /// No description provided for @elemAgUse.
  ///
  /// In en, this message translates to:
  /// **'Used in jewelry, coins, and high-end electronics.'**
  String get elemAgUse;

  /// No description provided for @elemSnName.
  ///
  /// In en, this message translates to:
  /// **'Tin'**
  String get elemSnName;

  /// No description provided for @elemSnSummary.
  ///
  /// In en, this message translates to:
  /// **'Tin is a silvery, malleable post-transition metal.'**
  String get elemSnSummary;

  /// No description provided for @elemSnUse.
  ///
  /// In en, this message translates to:
  /// **'Used to coat other metals and in solder.'**
  String get elemSnUse;

  /// No description provided for @elemIName.
  ///
  /// In en, this message translates to:
  /// **'Iodine'**
  String get elemIName;

  /// No description provided for @elemISummary.
  ///
  /// In en, this message translates to:
  /// **'Iodine is a nonmetal that appears as a bluish-black solid.'**
  String get elemISummary;

  /// No description provided for @elemIUse.
  ///
  /// In en, this message translates to:
  /// **'Used as an antiseptic and vital for thyroid health.'**
  String get elemIUse;

  /// No description provided for @elemAuName.
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get elemAuName;

  /// No description provided for @elemAuSummary.
  ///
  /// In en, this message translates to:
  /// **'Gold is a noble metal that does not tarnish and is highly valuable.'**
  String get elemAuSummary;

  /// No description provided for @elemAuUse.
  ///
  /// In en, this message translates to:
  /// **'Used in jewelry, investment, and space tech.'**
  String get elemAuUse;

  /// No description provided for @elemHgName.
  ///
  /// In en, this message translates to:
  /// **'Mercury'**
  String get elemHgName;

  /// No description provided for @elemHgSummary.
  ///
  /// In en, this message translates to:
  /// **'Mercury is the only metal that is liquid at standard temperature.'**
  String get elemHgSummary;

  /// No description provided for @elemHgUse.
  ///
  /// In en, this message translates to:
  /// **'Used in thermometers and fluorescent lights.'**
  String get elemHgUse;

  /// No description provided for @elemPbName.
  ///
  /// In en, this message translates to:
  /// **'Lead'**
  String get elemPbName;

  /// No description provided for @elemPbSummary.
  ///
  /// In en, this message translates to:
  /// **'Lead is a heavy, dense metal that is toxic if ingested.'**
  String get elemPbSummary;

  /// No description provided for @elemPbUse.
  ///
  /// In en, this message translates to:
  /// **'Used in car batteries and radiation shielding.'**
  String get elemPbUse;

  /// No description provided for @elemUName.
  ///
  /// In en, this message translates to:
  /// **'Uranium'**
  String get elemUName;

  /// No description provided for @elemUSummary.
  ///
  /// In en, this message translates to:
  /// **'Uranium is a heavy, silvery-white, radioactive metal.'**
  String get elemUSummary;

  /// No description provided for @elemUUse.
  ///
  /// In en, this message translates to:
  /// **'Used as fuel in nuclear power plants.'**
  String get elemUUse;

  /// No description provided for @elemTiName.
  ///
  /// In en, this message translates to:
  /// **'Titanium'**
  String get elemTiName;

  /// No description provided for @elemTiSummary.
  ///
  /// In en, this message translates to:
  /// **'Titanium is a strong, lightweight metal with a high melting point and excellent corrosion resistance.'**
  String get elemTiSummary;

  /// No description provided for @elemTiUse.
  ///
  /// In en, this message translates to:
  /// **'Used in aircraft, dental implants, and high-end watches.'**
  String get elemTiUse;

  /// No description provided for @elemCrName.
  ///
  /// In en, this message translates to:
  /// **'Chromium'**
  String get elemCrName;

  /// No description provided for @elemCrSummary.
  ///
  /// In en, this message translates to:
  /// **'Chromium is a hard, shiny metal that is highly resistant to tarnishing.'**
  String get elemCrSummary;

  /// No description provided for @elemCrUse.
  ///
  /// In en, this message translates to:
  /// **'Used in stainless steel and chrome plating.'**
  String get elemCrUse;

  /// No description provided for @elemPtName.
  ///
  /// In en, this message translates to:
  /// **'Platinum'**
  String get elemPtName;

  /// No description provided for @elemPtSummary.
  ///
  /// In en, this message translates to:
  /// **'Platinum is a dense, stable, and rare precious metal used in jewelry and catalytic converters.'**
  String get elemPtSummary;

  /// No description provided for @elemPtUse.
  ///
  /// In en, this message translates to:
  /// **'Used in vehicle catalysts and high-end electronics.'**
  String get elemPtUse;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @labAssistant.
  ///
  /// In en, this message translates to:
  /// **'Lab Assistant'**
  String get labAssistant;

  /// No description provided for @researcherRank.
  ///
  /// In en, this message translates to:
  /// **'Researcher Rank'**
  String get researcherRank;

  /// No description provided for @researchJournal.
  ///
  /// In en, this message translates to:
  /// **'Research Journal'**
  String get researchJournal;

  /// No description provided for @discoveries.
  ///
  /// In en, this message translates to:
  /// **'Discoveries'**
  String get discoveries;

  /// No description provided for @novice.
  ///
  /// In en, this message translates to:
  /// **'Novice'**
  String get novice;

  /// No description provided for @seniorChemist.
  ///
  /// In en, this message translates to:
  /// **'Senior Chemist'**
  String get seniorChemist;

  /// No description provided for @alchemist.
  ///
  /// In en, this message translates to:
  /// **'Alchemist'**
  String get alchemist;

  /// No description provided for @discoveryLabel.
  ///
  /// In en, this message translates to:
  /// **'Discovery'**
  String get discoveryLabel;

  /// No description provided for @increaseHeatCatalyst.
  ///
  /// In en, this message translates to:
  /// **'Discovery requires more heat! Use the Bunsen burner.'**
  String get increaseHeatCatalyst;

  /// No description provided for @multiplayerQuiz.
  ///
  /// In en, this message translates to:
  /// **'Multiplayer Quiz'**
  String get multiplayerQuiz;

  /// No description provided for @aiTutor.
  ///
  /// In en, this message translates to:
  /// **'AI Tutor'**
  String get aiTutor;

  /// No description provided for @viewIn3D.
  ///
  /// In en, this message translates to:
  /// **'View in 3D'**
  String get viewIn3D;

  /// No description provided for @searchCompounds.
  ///
  /// In en, this message translates to:
  /// **'Search compounds...'**
  String get searchCompounds;

  /// No description provided for @scientificInsight.
  ///
  /// In en, this message translates to:
  /// **'Scientific Insight'**
  String get scientificInsight;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it!'**
  String get gotIt;

  /// No description provided for @challengingPlayers.
  ///
  /// In en, this message translates to:
  /// **'Looking for nearby challengers...'**
  String get challengingPlayers;

  /// No description provided for @inviteHost.
  ///
  /// In en, this message translates to:
  /// **'Invite (Host)'**
  String get inviteHost;

  /// No description provided for @connectedTo.
  ///
  /// In en, this message translates to:
  /// **'Connected to'**
  String get connectedTo;

  /// No description provided for @hostScore.
  ///
  /// In en, this message translates to:
  /// **'Host Score'**
  String get hostScore;

  /// No description provided for @guestScore.
  ///
  /// In en, this message translates to:
  /// **'Guest Score'**
  String get guestScore;

  /// No description provided for @aiTutorGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello Young Scientist! I am your AI Chemistry Tutor 🧪. How can I help you today?'**
  String get aiTutorGreeting;

  /// No description provided for @aiTutorHint.
  ///
  /// In en, this message translates to:
  /// **'Ask about any chemical reaction...'**
  String get aiTutorHint;

  /// No description provided for @aiTutorSystemInstruction.
  ///
  /// In en, this message translates to:
  /// **'You are an expert, friendly AI Chemistry Tutor. You explain chemistry concepts clearly and simply. IMPORTANT: You must respond in the following language: {language}.'**
  String aiTutorSystemInstruction(String language);

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @hhVinegar.
  ///
  /// In en, this message translates to:
  /// **'Vinegar'**
  String get hhVinegar;

  /// No description provided for @hhVinegarChem.
  ///
  /// In en, this message translates to:
  /// **'Acetic Acid'**
  String get hhVinegarChem;

  /// No description provided for @hhVinegarDesc.
  ///
  /// In en, this message translates to:
  /// **'Commonly used in cooking and cleaning.'**
  String get hhVinegarDesc;

  /// No description provided for @hhVinegarWarn.
  ///
  /// In en, this message translates to:
  /// **'Safe for consumption in small amounts. Acidic.'**
  String get hhVinegarWarn;

  /// No description provided for @hhBakingSoda.
  ///
  /// In en, this message translates to:
  /// **'Baking Soda'**
  String get hhBakingSoda;

  /// No description provided for @hhBakingSodaChem.
  ///
  /// In en, this message translates to:
  /// **'Sodium Bicarbonate'**
  String get hhBakingSodaChem;

  /// No description provided for @hhBakingSodaDesc.
  ///
  /// In en, this message translates to:
  /// **'Used in baking and as a mild abrasive cleaner.'**
  String get hhBakingSodaDesc;

  /// No description provided for @hhBakingSodaWarn.
  ///
  /// In en, this message translates to:
  /// **'Safe. Produces gas when mixed with acid.'**
  String get hhBakingSodaWarn;

  /// No description provided for @hhBleach.
  ///
  /// In en, this message translates to:
  /// **'Bleach'**
  String get hhBleach;

  /// No description provided for @hhBleachChem.
  ///
  /// In en, this message translates to:
  /// **'Sodium Hypochlorite'**
  String get hhBleachChem;

  /// No description provided for @hhBleachDesc.
  ///
  /// In en, this message translates to:
  /// **'Strong disinfectant and whitener.'**
  String get hhBleachDesc;

  /// No description provided for @hhBleachWarn.
  ///
  /// In en, this message translates to:
  /// **'DANGER: Never mix with Vinegar or Ammonia! Produces toxic gas.'**
  String get hhBleachWarn;

  /// No description provided for @hhSalt.
  ///
  /// In en, this message translates to:
  /// **'Table Salt'**
  String get hhSalt;

  /// No description provided for @hhSaltChem.
  ///
  /// In en, this message translates to:
  /// **'Sodium Chloride'**
  String get hhSaltChem;

  /// No description provided for @hhSaltDesc.
  ///
  /// In en, this message translates to:
  /// **'Essential for life, used for seasoning.'**
  String get hhSaltDesc;

  /// No description provided for @hhSaltWarn.
  ///
  /// In en, this message translates to:
  /// **'Safe. Excessive intake can raise blood pressure.'**
  String get hhSaltWarn;

  /// No description provided for @hhAmmonia.
  ///
  /// In en, this message translates to:
  /// **'Ammonia'**
  String get hhAmmonia;

  /// No description provided for @hhAmmoniaChem.
  ///
  /// In en, this message translates to:
  /// **'Ammonium Hydroxide'**
  String get hhAmmoniaChem;

  /// No description provided for @hhAmmoniaDesc.
  ///
  /// In en, this message translates to:
  /// **'Common glass cleaner.'**
  String get hhAmmoniaDesc;

  /// No description provided for @hhAmmoniaWarn.
  ///
  /// In en, this message translates to:
  /// **'Irritating fumes. Do not mix with bleach.'**
  String get hhAmmoniaWarn;

  /// No description provided for @hhSugar.
  ///
  /// In en, this message translates to:
  /// **'Sugar'**
  String get hhSugar;

  /// No description provided for @hhSugarChem.
  ///
  /// In en, this message translates to:
  /// **'Sucrose'**
  String get hhSugarChem;

  /// No description provided for @hhSugarDesc.
  ///
  /// In en, this message translates to:
  /// **'Sweetener found in many foods.'**
  String get hhSugarDesc;

  /// No description provided for @hhSugarWarn.
  ///
  /// In en, this message translates to:
  /// **'Safe. High consumption leads to health issues.'**
  String get hhSugarWarn;

  /// No description provided for @hhNailPolish.
  ///
  /// In en, this message translates to:
  /// **'Nail Polish Remover'**
  String get hhNailPolish;

  /// No description provided for @hhNailPolishChem.
  ///
  /// In en, this message translates to:
  /// **'Acetone'**
  String get hhNailPolishChem;

  /// No description provided for @hhNailPolishDesc.
  ///
  /// In en, this message translates to:
  /// **'Solvent for removing nail polish and glue.'**
  String get hhNailPolishDesc;

  /// No description provided for @hhNailPolishWarn.
  ///
  /// In en, this message translates to:
  /// **'Flammable. Keep away from fire.'**
  String get hhNailPolishWarn;

  /// No description provided for @elephantExp.
  ///
  /// In en, this message translates to:
  /// **'Elephant Toothpaste'**
  String get elephantExp;

  /// No description provided for @elephantDesc.
  ///
  /// In en, this message translates to:
  /// **'A giant foamy reaction that releases oxygen.'**
  String get elephantDesc;

  /// No description provided for @elephantStep1.
  ///
  /// In en, this message translates to:
  /// **'Pour hydrogen peroxide into a flask.'**
  String get elephantStep1;

  /// No description provided for @elephantStep2.
  ///
  /// In en, this message translates to:
  /// **'Add dish soap and food coloring.'**
  String get elephantStep2;

  /// No description provided for @elephantStep3.
  ///
  /// In en, this message translates to:
  /// **'Add warm yeast solution and stand back!'**
  String get elephantStep3;

  /// No description provided for @elephantExplanation.
  ///
  /// In en, this message translates to:
  /// **'The catalyst (yeast) quickly breaks down hydrogen peroxide into water and oxygen gas.'**
  String get elephantExplanation;

  /// No description provided for @crystalExp.
  ///
  /// In en, this message translates to:
  /// **'Crystal Growing'**
  String get crystalExp;

  /// No description provided for @crystalDesc.
  ///
  /// In en, this message translates to:
  /// **'Use salt or sugar to grow beautiful crystals.'**
  String get crystalDesc;

  /// No description provided for @crystalStep1.
  ///
  /// In en, this message translates to:
  /// **'Dissolve sugar in boiling water until no more dissolves.'**
  String get crystalStep1;

  /// No description provided for @crystalStep2.
  ///
  /// In en, this message translates to:
  /// **'Suspend a string in the solution without touching the bottom.'**
  String get crystalStep2;

  /// No description provided for @crystalStep3.
  ///
  /// In en, this message translates to:
  /// **'Wait a few days for crystals to form.'**
  String get crystalStep3;

  /// No description provided for @crystalExplanation.
  ///
  /// In en, this message translates to:
  /// **'As water cools and evaporates, the excess sugar atoms gather on the string in a regular pattern.'**
  String get crystalExplanation;

  /// No description provided for @milkArtExp.
  ///
  /// In en, this message translates to:
  /// **'Magic Milk Art'**
  String get milkArtExp;

  /// No description provided for @milkArtDesc.
  ///
  /// In en, this message translates to:
  /// **'Use soap to create colorful patterns in milk.'**
  String get milkArtDesc;

  /// No description provided for @milkArtStep1.
  ///
  /// In en, this message translates to:
  /// **'Pour milk into a plate and add food coloring drops.'**
  String get milkArtStep1;

  /// No description provided for @milkArtStep2.
  ///
  /// In en, this message translates to:
  /// **'Dip a cotton swab in dish soap.'**
  String get milkArtStep2;

  /// No description provided for @milkArtStep3.
  ///
  /// In en, this message translates to:
  /// **'Touch the center of the milk and watch the colors explode.'**
  String get milkArtStep3;

  /// No description provided for @milkArtExplanation.
  ///
  /// In en, this message translates to:
  /// **'The soap reduces surface tension and reacts with fats, pushing the colors around.'**
  String get milkArtExplanation;

  /// No description provided for @oilWaterExp.
  ///
  /// In en, this message translates to:
  /// **'Oil & Water Volcano'**
  String get oilWaterExp;

  /// No description provided for @oilWaterDesc.
  ///
  /// In en, this message translates to:
  /// **'Explore density and polarity.'**
  String get oilWaterDesc;

  /// No description provided for @oilWaterStep1.
  ///
  /// In en, this message translates to:
  /// **'Fill 2/3 of a cup with oil and 1/3 with water.'**
  String get oilWaterStep1;

  /// No description provided for @oilWaterStep2.
  ///
  /// In en, this message translates to:
  /// **'Add food coloring drops.'**
  String get oilWaterStep2;

  /// No description provided for @oilWaterStep3.
  ///
  /// In en, this message translates to:
  /// **'Drop an effervescent tablet and watch bubbles rise.'**
  String get oilWaterStep3;

  /// No description provided for @oilWaterExplanation.
  ///
  /// In en, this message translates to:
  /// **'Oil is lighter than water and doesn\'t mix due to polarity. The tablet produces CO2 that carries colored water up.'**
  String get oilWaterExplanation;

  /// No description provided for @eggExp.
  ///
  /// In en, this message translates to:
  /// **'Bouncy Egg'**
  String get eggExp;

  /// No description provided for @eggDesc.
  ///
  /// In en, this message translates to:
  /// **'Remove an eggshell with vinegar.'**
  String get eggDesc;

  /// No description provided for @eggStep1.
  ///
  /// In en, this message translates to:
  /// **'Place an egg in a cup and cover it with vinegar.'**
  String get eggStep1;

  /// No description provided for @eggStep2.
  ///
  /// In en, this message translates to:
  /// **'Leave it for 24-48 hours.'**
  String get eggStep2;

  /// No description provided for @eggStep3.
  ///
  /// In en, this message translates to:
  /// **'Wash it with water and watch the shell disappear.'**
  String get eggStep3;

  /// No description provided for @eggExplanation.
  ///
  /// In en, this message translates to:
  /// **'Acetic acid reacts with calcium carbonate in the shell, dissolving it into CO2 and water.'**
  String get eggExplanation;

  /// No description provided for @chemicalScanner.
  ///
  /// In en, this message translates to:
  /// **'Chemical Scanner'**
  String get chemicalScanner;

  /// No description provided for @scanInstructions.
  ///
  /// In en, this message translates to:
  /// **'Point camera at a chemical product label'**
  String get scanInstructions;

  /// No description provided for @identifying.
  ///
  /// In en, this message translates to:
  /// **'Identifying compound...'**
  String get identifying;

  /// No description provided for @identifiedElements.
  ///
  /// In en, this message translates to:
  /// **'Elements in this compound:'**
  String get identifiedElements;

  /// No description provided for @noCompoundFound.
  ///
  /// In en, this message translates to:
  /// **'Could not identify compound. Try again.'**
  String get noCompoundFound;
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
