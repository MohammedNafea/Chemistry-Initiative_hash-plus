import 'package:chemistry_initiative/core/database/app_database.dart';
import 'package:chemistry_initiative/features/periodic_table/data/models/element_model.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';

class PeriodicTableRepository {
  static const String _cacheKey = 'cached_periodic_elements';

  static Future<List<ElementModel>> getElements(
    AppLocalizations localizations,
  ) async {
    final cacheBox = AppDatabase.instance.cache;

    // Check if we have cached data
    if (cacheBox.containsKey(_cacheKey)) {
      final cachedList = cacheBox.get(_cacheKey) as List;
      return cachedList.cast<ElementModel>();
    }

    // If no cache, load default data and save to cache
    final defaultElements = _getDefaultElements(localizations);
    await cacheBox.put(_cacheKey, defaultElements);
    return defaultElements;
  }

  static List<ElementModel> _getDefaultElements(
    AppLocalizations localizations,
  ) {
    return [
      ElementModel(
        atomicNumber: 1, symbol: 'H', name: localizations.elemHName,
        category: localizations.catNonmetal, categoryType: ElementCategoryType.nonmetal,
        atomicMass: '1.008', summary: localizations.elemHSummary, dailyLifeUse: localizations.elemHUse, discoveredBy: 'Henry Cavendish',
      ),
      ElementModel(
        atomicNumber: 2, symbol: 'He', name: localizations.elemHeName,
        category: localizations.catNobleGas, categoryType: ElementCategoryType.nobleGas,
        atomicMass: '4.0026', summary: localizations.elemHeSummary, dailyLifeUse: localizations.elemHeUse, discoveredBy: 'Pierre Janssen',
      ),
      ElementModel(
        atomicNumber: 3, symbol: 'Li', name: localizations.elemLiName,
        category: localizations.catAlkaliMetal, categoryType: ElementCategoryType.alkaliMetal,
        atomicMass: '6.94', summary: localizations.elemLiSummary, dailyLifeUse: localizations.elemLiUse, discoveredBy: 'Johan August Arfwedson',
      ),
      ElementModel(
        atomicNumber: 4, symbol: 'Be', name: localizations.elemBeName,
        category: localizations.catAlkalineEarth, categoryType: ElementCategoryType.alkalineEarth,
        atomicMass: '9.0122', summary: localizations.elemBeSummary, dailyLifeUse: localizations.elemBeUse, discoveredBy: 'Louis-Nicolas Vauquelin',
      ),
      ElementModel(
        atomicNumber: 5, symbol: 'B', name: localizations.elemBName,
        category: localizations.catMetalloid, categoryType: ElementCategoryType.metalloid,
        atomicMass: '10.81', summary: localizations.elemBSummary, dailyLifeUse: localizations.elemBUse, discoveredBy: 'Joseph Louis Gay-Lussac',
      ),
      ElementModel(
        atomicNumber: 6, symbol: 'C', name: localizations.elemCName,
        category: localizations.catNonmetal, categoryType: ElementCategoryType.nonmetal,
        atomicMass: '12.011', summary: localizations.elemCSummary, dailyLifeUse: localizations.elemCUse, discoveredBy: 'Known since antiquity',
      ),
      ElementModel(
        atomicNumber: 7, symbol: 'N', name: localizations.elemNName,
        category: localizations.catNonmetal, categoryType: ElementCategoryType.nonmetal,
        atomicMass: '14.007', summary: localizations.elemNSummary, dailyLifeUse: localizations.elemNUse, discoveredBy: 'Daniel Rutherford',
      ),
      ElementModel(
        atomicNumber: 8, symbol: 'O', name: localizations.elemOName,
        category: localizations.catNonmetal, categoryType: ElementCategoryType.nonmetal,
        atomicMass: '15.999', summary: localizations.elemOSummary, dailyLifeUse: localizations.elemOUse, discoveredBy: 'Carl Wilhelm Scheele',
      ),
      ElementModel(
        atomicNumber: 9, symbol: 'F', name: localizations.elemFName,
        category: localizations.catHalogen, categoryType: ElementCategoryType.halogen,
        atomicMass: '18.998', summary: localizations.elemFSummary, dailyLifeUse: localizations.elemFUse, discoveredBy: 'Henri Moissan',
      ),
      ElementModel(
        atomicNumber: 10, symbol: 'Ne', name: localizations.elemNeName,
        category: localizations.catNobleGas, categoryType: ElementCategoryType.nobleGas,
        atomicMass: '20.180', summary: localizations.elemNeSummary, dailyLifeUse: localizations.elemNeUse, discoveredBy: 'Sir William Ramsay',
      ),
      ElementModel(
        atomicNumber: 11, symbol: 'Na', name: localizations.elemNaName,
        category: localizations.catAlkaliMetal, categoryType: ElementCategoryType.alkaliMetal,
        atomicMass: '22.990', summary: localizations.elemNaSummary, dailyLifeUse: localizations.elemNaUse, discoveredBy: 'Humphry Davy',
      ),
      ElementModel(
        atomicNumber: 12, symbol: 'Mg', name: localizations.elemMgName,
        category: localizations.catAlkalineEarth, categoryType: ElementCategoryType.alkalineEarth,
        atomicMass: '24.305', summary: localizations.elemMgSummary, dailyLifeUse: localizations.elemMgUse, discoveredBy: 'Joseph Black',
      ),
      ElementModel(
        atomicNumber: 13, symbol: 'Al', name: localizations.elemAlName,
        category: localizations.catPostTransition, categoryType: ElementCategoryType.postTransitionMetal,
        atomicMass: '26.982', summary: localizations.elemAlSummary, dailyLifeUse: localizations.elemAlUse, discoveredBy: 'Hans Christian Ørsted',
      ),
      ElementModel(
        atomicNumber: 14, symbol: 'Si', name: localizations.elemSiName,
        category: localizations.catMetalloid, categoryType: ElementCategoryType.metalloid,
        atomicMass: '28.085', summary: localizations.elemSiSummary, dailyLifeUse: localizations.elemSiUse, discoveredBy: 'Jöns Jacob Berzelius',
      ),
      ElementModel(
        atomicNumber: 15, symbol: 'P', name: localizations.elemPName,
        category: localizations.catNonmetal, categoryType: ElementCategoryType.nonmetal,
        atomicMass: '30.974', summary: localizations.elemPSummary, dailyLifeUse: localizations.elemPUse, discoveredBy: 'Hennig Brand',
      ),
      ElementModel(
        atomicNumber: 16, symbol: 'S', name: localizations.elemSName,
        category: localizations.catNonmetal, categoryType: ElementCategoryType.nonmetal,
        atomicMass: '32.06', summary: localizations.elemSSummary, dailyLifeUse: localizations.elemSUse, discoveredBy: 'Known since antiquity',
      ),
      ElementModel(
        atomicNumber: 17, symbol: 'Cl', name: localizations.elemClName,
        category: localizations.catHalogen, categoryType: ElementCategoryType.halogen,
        atomicMass: '35.45', summary: localizations.elemClSummary, dailyLifeUse: localizations.elemClUse, discoveredBy: 'Carl Wilhelm Scheele',
      ),
      ElementModel(
        atomicNumber: 18, symbol: 'Ar', name: localizations.elemArName,
        category: localizations.catNobleGas, categoryType: ElementCategoryType.nobleGas,
        atomicMass: '39.948', summary: localizations.elemArSummary, dailyLifeUse: localizations.elemArUse, discoveredBy: 'Lord Rayleigh',
      ),
      ElementModel(
        atomicNumber: 19, symbol: 'K', name: localizations.elemKName,
        category: localizations.catAlkaliMetal, categoryType: ElementCategoryType.alkaliMetal,
        atomicMass: '39.098', summary: localizations.elemKSummary, dailyLifeUse: localizations.elemKUse, discoveredBy: 'Humphry Davy',
      ),
      ElementModel(
        atomicNumber: 20, symbol: 'Ca', name: localizations.elemCaName,
        category: localizations.catAlkalineEarth, categoryType: ElementCategoryType.alkalineEarth,
        atomicMass: '40.078', summary: localizations.elemCaSummary, dailyLifeUse: localizations.elemCaUse, discoveredBy: 'Humphry Davy',
      ),
      ElementModel(
        atomicNumber: 21, symbol: 'Sc', name: localizations.elemScName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '44.956', summary: localizations.elemScSummary, dailyLifeUse: localizations.elemScUse, discoveredBy: 'Lars Fredrik Nilson',
      ),
      ElementModel(
        atomicNumber: 22, symbol: 'Ti', name: localizations.elemTiName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '47.867', summary: localizations.elemTiSummary, dailyLifeUse: localizations.elemTiUse, discoveredBy: 'William Gregor',
      ),
      ElementModel(
        atomicNumber: 23, symbol: 'V', name: localizations.elemVName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '50.942', summary: localizations.elemVSummary, dailyLifeUse: localizations.elemVUse, discoveredBy: 'Andrés Manuel del Río',
      ),
      ElementModel(
        atomicNumber: 24, symbol: 'Cr', name: localizations.elemCrName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '51.996', summary: localizations.elemCrSummary, dailyLifeUse: localizations.elemCrUse, discoveredBy: 'Louis Nicolas Vauquelin',
      ),
      ElementModel(
        atomicNumber: 25, symbol: 'Mn', name: localizations.elemMnName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '54.938', summary: localizations.elemMnSummary, dailyLifeUse: localizations.elemMnUse, discoveredBy: 'Johan Gottlieb Gahn',
      ),
      ElementModel(
        atomicNumber: 26, symbol: 'Fe', name: localizations.elemFeName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '55.845', summary: localizations.elemFeSummary, dailyLifeUse: localizations.elemFeUse, discoveredBy: 'Known since antiquity',
      ),
      ElementModel(
        atomicNumber: 27, symbol: 'Co', name: localizations.elemCoName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '58.933', summary: localizations.elemCoSummary, dailyLifeUse: localizations.elemCoUse, discoveredBy: 'Georg Brandt',
      ),
      ElementModel(
        atomicNumber: 28, symbol: 'Ni', name: localizations.elemNiName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '58.693', summary: localizations.elemNiSummary, dailyLifeUse: localizations.elemNiUse, discoveredBy: 'Axel Fredrik Cronstedt',
      ),
      ElementModel(
        atomicNumber: 29, symbol: 'Cu', name: localizations.elemCuName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '63.546', summary: localizations.elemCuSummary, dailyLifeUse: localizations.elemCuUse, discoveredBy: 'Prehistoric',
      ),
      ElementModel(
        atomicNumber: 30, symbol: 'Zn', name: localizations.elemZnName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '65.38', summary: localizations.elemZnSummary, dailyLifeUse: localizations.elemZnUse, discoveredBy: 'Known since antiquity',
      ),
      ElementModel(
        atomicNumber: 31, symbol: 'Ga', name: localizations.elemGaName,
        category: localizations.catPostTransition, categoryType: ElementCategoryType.postTransitionMetal,
        atomicMass: '69.723', summary: localizations.elemGaSummary, dailyLifeUse: localizations.elemGaUse, discoveredBy: 'Lecoq de Boisbaudran',
      ),
      ElementModel(
        atomicNumber: 32, symbol: 'Ge', name: localizations.elemGeName,
        category: localizations.catMetalloid, categoryType: ElementCategoryType.metalloid,
        atomicMass: '72.63', summary: localizations.elemGeSummary, dailyLifeUse: localizations.elemGeUse, discoveredBy: 'Clemens Winkler',
      ),
      ElementModel(
        atomicNumber: 33, symbol: 'As', name: localizations.elemAsName,
        category: localizations.catMetalloid, categoryType: ElementCategoryType.metalloid,
        atomicMass: '74.922', summary: localizations.elemAsSummary, dailyLifeUse: localizations.elemAsUse, discoveredBy: 'Albertus Magnus',
      ),
      ElementModel(
        atomicNumber: 34, symbol: 'Se', name: localizations.elemSeName,
        category: localizations.catNonmetal, categoryType: ElementCategoryType.nonmetal,
        atomicMass: '78.971', summary: localizations.elemSeSummary, dailyLifeUse: localizations.elemSeUse, discoveredBy: 'Jöns Jakob Berzelius',
      ),
      ElementModel(
        atomicNumber: 35, symbol: 'Br', name: localizations.elemBrName,
        category: localizations.catHalogen, categoryType: ElementCategoryType.halogen,
        atomicMass: '79.904', summary: localizations.elemBrSummary, dailyLifeUse: localizations.elemBrUse, discoveredBy: 'Antoine Jérôme Balard',
      ),
      ElementModel(
        atomicNumber: 36, symbol: 'Kr', name: localizations.elemKrName,
        category: localizations.catNobleGas, categoryType: ElementCategoryType.nobleGas,
        atomicMass: '83.798', summary: localizations.elemKrSummary, dailyLifeUse: localizations.elemKrUse, discoveredBy: 'William Ramsay',
      ),
      ElementModel(
        atomicNumber: 37, symbol: 'Rb', name: localizations.elemRbName,
        category: localizations.catAlkaliMetal, categoryType: ElementCategoryType.alkaliMetal,
        atomicMass: '85.468', summary: localizations.elemRbSummary, dailyLifeUse: localizations.elemRbUse, discoveredBy: 'Robert Bunsen',
      ),
      ElementModel(
        atomicNumber: 38, symbol: 'Sr', name: localizations.elemSrName,
        category: localizations.catAlkalineEarth, categoryType: ElementCategoryType.alkalineEarth,
        atomicMass: '87.62', summary: localizations.elemSrSummary, dailyLifeUse: localizations.elemSrUse, discoveredBy: 'Adair Crawford',
      ),
      ElementModel(
        atomicNumber: 39, symbol: 'Y', name: localizations.elemYName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '88.906', summary: localizations.elemYSummary, dailyLifeUse: localizations.elemYUse, discoveredBy: 'Johan Gadolin',
      ),
      ElementModel(
        atomicNumber: 40, symbol: 'Zr', name: localizations.elemZrName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '91.224', summary: localizations.elemZrSummary, dailyLifeUse: localizations.elemZrUse, discoveredBy: 'Martin Heinrich Klaproth',
      ),
      ElementModel(
        atomicNumber: 41, symbol: 'Nb', name: localizations.elemNbName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '92.906', summary: localizations.elemNbSummary, dailyLifeUse: localizations.elemNbUse, discoveredBy: 'Charles Hatchett',
      ),
      ElementModel(
        atomicNumber: 42, symbol: 'Mo', name: localizations.elemMoName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '95.95', summary: localizations.elemMoSummary, dailyLifeUse: localizations.elemMoUse, discoveredBy: 'Carl Wilhelm Scheele',
      ),
      ElementModel(
        atomicNumber: 43, symbol: 'Tc', name: localizations.elemTcName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '98', summary: localizations.elemTcSummary, dailyLifeUse: localizations.elemTcUse, discoveredBy: 'Emilio Segrè',
      ),
      ElementModel(
        atomicNumber: 44, symbol: 'Ru', name: localizations.elemRuName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '101.07', summary: localizations.elemRuSummary, dailyLifeUse: localizations.elemRuUse, discoveredBy: 'Karl Ernst Claus',
      ),
      ElementModel(
        atomicNumber: 45, symbol: 'Rh', name: localizations.elemRhName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '102.91', summary: localizations.elemRhSummary, dailyLifeUse: localizations.elemRhUse, discoveredBy: 'William Hyde Wollaston',
      ),
      ElementModel(
        atomicNumber: 46, symbol: 'Pd', name: localizations.elemPdName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '106.42', summary: localizations.elemPdSummary, dailyLifeUse: localizations.elemPdUse, discoveredBy: 'William Hyde Wollaston',
      ),
      ElementModel(
        atomicNumber: 47, symbol: 'Ag', name: localizations.elemAgName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '107.87', summary: localizations.elemAgSummary, dailyLifeUse: localizations.elemAgUse, discoveredBy: 'Prehistoric',
      ),
      ElementModel(
        atomicNumber: 48, symbol: 'Cd', name: localizations.elemCdName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '112.41', summary: localizations.elemCdSummary, dailyLifeUse: localizations.elemCdUse, discoveredBy: 'Karl Samuel Leberecht Hermann',
      ),
      ElementModel(
        atomicNumber: 49, symbol: 'In', name: localizations.elemInName,
        category: localizations.catPostTransition, categoryType: ElementCategoryType.postTransitionMetal,
        atomicMass: '114.82', summary: localizations.elemInSummary, dailyLifeUse: localizations.elemInUse, discoveredBy: 'Ferdinand Reich',
      ),
      ElementModel(
        atomicNumber: 50, symbol: 'Sn', name: localizations.elemSnName,
        category: localizations.catPostTransition, categoryType: ElementCategoryType.postTransitionMetal,
        atomicMass: '118.71', summary: localizations.elemSnSummary, dailyLifeUse: localizations.elemSnUse, discoveredBy: 'Known since antiquity',
      ),
      ElementModel(
        atomicNumber: 51, symbol: 'Sb', name: localizations.elemSbName,
        category: localizations.catMetalloid, categoryType: ElementCategoryType.metalloid,
        atomicMass: '121.76', summary: localizations.elemSbSummary, dailyLifeUse: localizations.elemSbUse, discoveredBy: 'Unknown',
      ),
      ElementModel(
        atomicNumber: 52, symbol: 'Te', name: localizations.elemTeName,
        category: localizations.catMetalloid, categoryType: ElementCategoryType.metalloid,
        atomicMass: '127.60', summary: localizations.elemTeSummary, dailyLifeUse: localizations.elemTeUse, discoveredBy: 'Franz-Joseph Müller von Reichenstein',
      ),
      ElementModel(
        atomicNumber: 53, symbol: 'I', name: localizations.elemIName,
        category: localizations.catHalogen, categoryType: ElementCategoryType.halogen,
        atomicMass: '126.90', summary: localizations.elemISummary, dailyLifeUse: localizations.elemIUse, discoveredBy: 'Bernard Courtois',
      ),
      ElementModel(
        atomicNumber: 54, symbol: 'Xe', name: localizations.elemXeName,
        category: localizations.catNobleGas, categoryType: ElementCategoryType.nobleGas,
        atomicMass: '131.29', summary: localizations.elemXeSummary, dailyLifeUse: localizations.elemXeUse, discoveredBy: 'William Ramsay',
      ),
      ElementModel(
        atomicNumber: 55, symbol: 'Cs', name: localizations.elemCsName,
        category: localizations.catAlkaliMetal, categoryType: ElementCategoryType.alkaliMetal,
        atomicMass: '132.91', summary: localizations.elemCsSummary, dailyLifeUse: localizations.elemCsUse, discoveredBy: 'Robert Bunsen',
      ),
      ElementModel(
        atomicNumber: 56, symbol: 'Ba', name: localizations.elemBaName,
        category: localizations.catAlkalineEarth, categoryType: ElementCategoryType.alkalineEarth,
        atomicMass: '137.33', summary: localizations.elemBaSummary, dailyLifeUse: localizations.elemBaUse, discoveredBy: 'Carl Wilhelm Scheele',
      ),
      ElementModel(
        atomicNumber: 57, symbol: 'La', name: localizations.elemLaName,
        category: localizations.catLanthanide, categoryType: ElementCategoryType.lanthanide,
        atomicMass: '138.9055', summary: localizations.elemLaSummary, dailyLifeUse: localizations.elemLaUse, discoveredBy: 'Carl Mosander',
      ),
      ElementModel(
        atomicNumber: 58, symbol: 'Ce', name: localizations.elemCeName,
        category: localizations.catLanthanide, categoryType: ElementCategoryType.lanthanide,
        atomicMass: '140.116', summary: localizations.elemCeSummary, dailyLifeUse: localizations.elemCeUse, discoveredBy: 'Martin Heinrich Klaproth',
      ),
      ElementModel(
        atomicNumber: 59, symbol: 'Pr', name: localizations.elemPrName,
        category: localizations.catLanthanide, categoryType: ElementCategoryType.lanthanide,
        atomicMass: '140.9077', summary: localizations.elemPrSummary, dailyLifeUse: localizations.elemPrUse, discoveredBy: 'Carl Auer von Welsbach',
      ),
      ElementModel(
        atomicNumber: 60, symbol: 'Nd', name: localizations.elemNdName,
        category: localizations.catLanthanide, categoryType: ElementCategoryType.lanthanide,
        atomicMass: '144.24', summary: localizations.elemNdSummary, dailyLifeUse: localizations.elemNdUse, discoveredBy: 'Carl Auer von Welsbach',
      ),
      ElementModel(
        atomicNumber: 61, symbol: 'Pm', name: localizations.elemPmName,
        category: localizations.catLanthanide, categoryType: ElementCategoryType.lanthanide,
        atomicMass: '(145)', summary: localizations.elemPmSummary, dailyLifeUse: localizations.elemPmUse, discoveredBy: 'Chien Shiung Wu',
      ),
      ElementModel(
        atomicNumber: 62, symbol: 'Sm', name: localizations.elemSmName,
        category: localizations.catLanthanide, categoryType: ElementCategoryType.lanthanide,
        atomicMass: '150.36', summary: localizations.elemSmSummary, dailyLifeUse: localizations.elemSmUse, discoveredBy: 'Paul-Émile Lecoq de Boisbaudran',
      ),
      ElementModel(
        atomicNumber: 63, symbol: 'Eu', name: localizations.elemEuName,
        category: localizations.catLanthanide, categoryType: ElementCategoryType.lanthanide,
        atomicMass: '151.964', summary: localizations.elemEuSummary, dailyLifeUse: localizations.elemEuUse, discoveredBy: 'Eugène-Anatole Demarçay',
      ),
      ElementModel(
        atomicNumber: 64, symbol: 'Gd', name: localizations.elemGdName,
        category: localizations.catLanthanide, categoryType: ElementCategoryType.lanthanide,
        atomicMass: '157.25', summary: localizations.elemGdSummary, dailyLifeUse: localizations.elemGdUse, discoveredBy: 'Jean Charles Galissard de Marignac',
      ),
      ElementModel(
        atomicNumber: 65, symbol: 'Tb', name: localizations.elemTbName,
        category: localizations.catLanthanide, categoryType: ElementCategoryType.lanthanide,
        atomicMass: '158.9253', summary: localizations.elemTbSummary, dailyLifeUse: localizations.elemTbUse, discoveredBy: 'Carl Mosander',
      ),
      ElementModel(
        atomicNumber: 66, symbol: 'Dy', name: localizations.elemDyName,
        category: localizations.catLanthanide, categoryType: ElementCategoryType.lanthanide,
        atomicMass: '162.50', summary: localizations.elemDySummary, dailyLifeUse: localizations.elemDyUse, discoveredBy: 'Paul-Émile Lecoq de Boisbaudran',
      ),
      ElementModel(
        atomicNumber: 67, symbol: 'Ho', name: localizations.elemHoName,
        category: localizations.catLanthanide, categoryType: ElementCategoryType.lanthanide,
        atomicMass: '164.9303', summary: localizations.elemHoSummary, dailyLifeUse: localizations.elemHoUse, discoveredBy: 'Marc Delafontaine',
      ),
      ElementModel(
        atomicNumber: 68, symbol: 'Er', name: localizations.elemErName,
        category: localizations.catLanthanide, categoryType: ElementCategoryType.lanthanide,
        atomicMass: '167.259', summary: localizations.elemErSummary, dailyLifeUse: localizations.elemErUse, discoveredBy: 'Carl Mosander',
      ),
      ElementModel(
        atomicNumber: 69, symbol: 'Tm', name: localizations.elemTmName,
        category: localizations.catLanthanide, categoryType: ElementCategoryType.lanthanide,
        atomicMass: '168.9342', summary: localizations.elemTmSummary, dailyLifeUse: localizations.elemTmUse, discoveredBy: 'Per Teodor Cleve',
      ),
      ElementModel(
        atomicNumber: 70, symbol: 'Yb', name: localizations.elemYbName,
        category: localizations.catLanthanide, categoryType: ElementCategoryType.lanthanide,
        atomicMass: '173.04', summary: localizations.elemYbSummary, dailyLifeUse: localizations.elemYbUse, discoveredBy: 'Jean Charles Galissard de Marignac',
      ),
      ElementModel(
        atomicNumber: 71, symbol: 'Lu', name: localizations.elemLuName,
        category: localizations.catLanthanide, categoryType: ElementCategoryType.lanthanide,
        atomicMass: '174.967', summary: localizations.elemLuSummary, dailyLifeUse: localizations.elemLuUse, discoveredBy: 'Georges Urbain',
      ),
      ElementModel(
        atomicNumber: 72, symbol: 'Hf', name: localizations.elemHfName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '178.49', summary: localizations.elemHfSummary, dailyLifeUse: localizations.elemHfUse, discoveredBy: 'Dirk Coster',
      ),
      ElementModel(
        atomicNumber: 73, symbol: 'Ta', name: localizations.elemTaName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '180.948', summary: localizations.elemTaSummary, dailyLifeUse: localizations.elemTaUse, discoveredBy: 'Anders Gustaf Ekeberg',
      ),
      ElementModel(
        atomicNumber: 74, symbol: 'W', name: localizations.elemWName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '183.84', summary: localizations.elemWSummary, dailyLifeUse: localizations.elemWUse, discoveredBy: 'Juan José Elhuyar',
      ),
      ElementModel(
        atomicNumber: 75, symbol: 'Re', name: localizations.elemReName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '186.207', summary: localizations.elemReSummary, dailyLifeUse: localizations.elemReUse, discoveredBy: 'Walter Noddack',
      ),
      ElementModel(
        atomicNumber: 76, symbol: 'Os', name: localizations.elemOsName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '190.23', summary: localizations.elemOsSummary, dailyLifeUse: localizations.elemOsUse, discoveredBy: 'Smithson Tennant',
      ),
      ElementModel(
        atomicNumber: 77, symbol: 'Ir', name: localizations.elemIrName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '192.217', summary: localizations.elemIrSummary, dailyLifeUse: localizations.elemIrUse, discoveredBy: 'Smithson Tennant',
      ),
      ElementModel(
        atomicNumber: 78, symbol: 'Pt', name: localizations.elemPtName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '195.084', summary: localizations.elemPtSummary, dailyLifeUse: localizations.elemPtUse, discoveredBy: 'Antonio de Ulloa',
      ),
      ElementModel(
        atomicNumber: 79, symbol: 'Au', name: localizations.elemAuName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '196.967', summary: localizations.elemAuSummary, dailyLifeUse: localizations.elemAuUse, discoveredBy: 'Prehistoric',
      ),
      ElementModel(
        atomicNumber: 80, symbol: 'Hg', name: localizations.elemHgName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '200.59', summary: localizations.elemHgSummary, dailyLifeUse: localizations.elemHgUse, discoveredBy: 'Known since antiquity',
      ),
      ElementModel(
        atomicNumber: 81, symbol: 'Tl', name: localizations.elemTlName,
        category: localizations.catPostTransition, categoryType: ElementCategoryType.postTransitionMetal,
        atomicMass: '204.38', summary: localizations.elemTlSummary, dailyLifeUse: localizations.elemTlUse, discoveredBy: 'William Crookes',
      ),
      ElementModel(
        atomicNumber: 82, symbol: 'Pb', name: localizations.elemPbName,
        category: localizations.catPostTransition, categoryType: ElementCategoryType.postTransitionMetal,
        atomicMass: '207.2', summary: localizations.elemPbSummary, dailyLifeUse: localizations.elemPbUse, discoveredBy: 'Known since antiquity',
      ),
      ElementModel(
        atomicNumber: 83, symbol: 'Bi', name: localizations.elemBiName,
        category: localizations.catPostTransition, categoryType: ElementCategoryType.postTransitionMetal,
        atomicMass: '208.980', summary: localizations.elemBiSummary, dailyLifeUse: localizations.elemBiUse, discoveredBy: 'Claude François Geoffroy',
      ),
      ElementModel(
        atomicNumber: 84, symbol: 'Po', name: localizations.elemPoName,
        category: localizations.catMetalloid, categoryType: ElementCategoryType.metalloid,
        atomicMass: '(209)', summary: localizations.elemPoSummary, dailyLifeUse: localizations.elemPoUse, discoveredBy: 'Marie Curie',
      ),
      ElementModel(
        atomicNumber: 85, symbol: 'At', name: localizations.elemAtName,
        category: localizations.catHalogen, categoryType: ElementCategoryType.halogen,
        atomicMass: '(210)', summary: localizations.elemAtSummary, dailyLifeUse: localizations.elemAtUse, discoveredBy: 'Dale R. Corson',
      ),
      ElementModel(
        atomicNumber: 86, symbol: 'Rn', name: localizations.elemRnName,
        category: localizations.catNobleGas, categoryType: ElementCategoryType.nobleGas,
        atomicMass: '(222)', summary: localizations.elemRnSummary, dailyLifeUse: localizations.elemRnUse, discoveredBy: 'Friedrich Ernst Dorn',
      ),
      ElementModel(
        atomicNumber: 87, symbol: 'Fr', name: localizations.elemFrName,
        category: localizations.catAlkaliMetal, categoryType: ElementCategoryType.alkaliMetal,
        atomicMass: '(223)', summary: localizations.elemFrSummary, dailyLifeUse: localizations.elemFrUse, discoveredBy: 'Marguerite Perey',
      ),
      ElementModel(
        atomicNumber: 88, symbol: 'Ra', name: localizations.elemRaName,
        category: localizations.catAlkalineEarth, categoryType: ElementCategoryType.alkalineEarth,
        atomicMass: '(226)', summary: localizations.elemRaSummary, dailyLifeUse: localizations.elemRaUse, discoveredBy: 'Pierre and Marie Curie',
      ),
      ElementModel(
        atomicNumber: 89, symbol: 'Ac', name: localizations.elemAcName,
        category: localizations.catActinide, categoryType: ElementCategoryType.actinide,
        atomicMass: '(227)', summary: localizations.elemAcSummary, dailyLifeUse: localizations.elemAcUse, discoveredBy: 'André-Louis Debierne',
      ),
      ElementModel(
        atomicNumber: 90, symbol: 'Th', name: localizations.elemThName,
        category: localizations.catActinide, categoryType: ElementCategoryType.actinide,
        atomicMass: '232.038', summary: localizations.elemThSummary, dailyLifeUse: localizations.elemThUse, discoveredBy: 'Jöns Jakob Berzelius',
      ),
      ElementModel(
        atomicNumber: 91, symbol: 'Pa', name: localizations.elemPaName,
        category: localizations.catActinide, categoryType: ElementCategoryType.actinide,
        atomicMass: '231.036', summary: localizations.elemPaSummary, dailyLifeUse: localizations.elemPaUse, discoveredBy: 'Otto Hahn',
      ),
      ElementModel(
        atomicNumber: 92, symbol: 'U', name: localizations.elemUName,
        category: localizations.catActinide, categoryType: ElementCategoryType.actinide,
        atomicMass: '238.0289', summary: localizations.elemUSummary, dailyLifeUse: localizations.elemUUse, discoveredBy: 'Martin Heinrich Klaproth',
      ),
      ElementModel(
        atomicNumber: 93, symbol: 'Np', name: localizations.elemNpName,
        category: localizations.catActinide, categoryType: ElementCategoryType.actinide,
        atomicMass: '(237)', summary: localizations.elemNpSummary, dailyLifeUse: localizations.elemNpUse, discoveredBy: 'Edwin McMillan',
      ),
      ElementModel(
        atomicNumber: 94, symbol: 'Pu', name: localizations.elemPuName,
        category: localizations.catActinide, categoryType: ElementCategoryType.actinide,
        atomicMass: '(244)', summary: localizations.elemPuSummary, dailyLifeUse: localizations.elemPuUse, discoveredBy: 'Glenn T. Seaborg',
      ),
      ElementModel(
        atomicNumber: 95, symbol: 'Am', name: localizations.elemAmName,
        category: localizations.catActinide, categoryType: ElementCategoryType.actinide,
        atomicMass: '(243)', summary: localizations.elemAmSummary, dailyLifeUse: localizations.elemAmUse, discoveredBy: 'Glenn T. Seaborg',
      ),
      ElementModel(
        atomicNumber: 96, symbol: 'Cm', name: localizations.elemCmName,
        category: localizations.catActinide, categoryType: ElementCategoryType.actinide,
        atomicMass: '(247)', summary: localizations.elemCmSummary, dailyLifeUse: localizations.elemCmUse, discoveredBy: 'Glenn T. Seaborg',
      ),
      ElementModel(
        atomicNumber: 97, symbol: 'Bk', name: localizations.elemBkName,
        category: localizations.catActinide, categoryType: ElementCategoryType.actinide,
        atomicMass: '(247)', summary: localizations.elemBkSummary, dailyLifeUse: localizations.elemBkUse, discoveredBy: 'Glenn T. Seaborg',
      ),
      ElementModel(
        atomicNumber: 98, symbol: 'Cf', name: localizations.elemCfName,
        category: localizations.catActinide, categoryType: ElementCategoryType.actinide,
        atomicMass: '(251)', summary: localizations.elemCfSummary, dailyLifeUse: localizations.elemCfUse, discoveredBy: 'Glenn T. Seaborg',
      ),
      ElementModel(
        atomicNumber: 99, symbol: 'Es', name: localizations.elemEsName,
        category: localizations.catActinide, categoryType: ElementCategoryType.actinide,
        atomicMass: '(252)', summary: localizations.elemEsSummary, dailyLifeUse: localizations.elemEsUse, discoveredBy: 'Albert Ghiorso',
      ),
      ElementModel(
        atomicNumber: 100, symbol: 'Fm', name: localizations.elemFmName,
        category: localizations.catActinide, categoryType: ElementCategoryType.actinide,
        atomicMass: '(257)', summary: localizations.elemFmSummary, dailyLifeUse: localizations.elemFmUse, discoveredBy: 'Albert Ghiorso',
      ),
      ElementModel(
        atomicNumber: 101, symbol: 'Md', name: localizations.elemMdName,
        category: localizations.catActinide, categoryType: ElementCategoryType.actinide,
        atomicMass: '(258)', summary: localizations.elemMdSummary, dailyLifeUse: localizations.elemMdUse, discoveredBy: 'Albert Ghiorso',
      ),
      ElementModel(
        atomicNumber: 102, symbol: 'No', name: localizations.elemNoName,
        category: localizations.catActinide, categoryType: ElementCategoryType.actinide,
        atomicMass: '(259)', summary: localizations.elemNoSummary, dailyLifeUse: localizations.elemNoUse, discoveredBy: 'Albert Ghiorso',
      ),
      ElementModel(
        atomicNumber: 103, symbol: 'Lr', name: localizations.elemLrName,
        category: localizations.catActinide, categoryType: ElementCategoryType.actinide,
        atomicMass: '(262)', summary: localizations.elemLrSummary, dailyLifeUse: localizations.elemLrUse, discoveredBy: 'Albert Ghiorso',
      ),
      ElementModel(
        atomicNumber: 104, symbol: 'Rf', name: localizations.elemRfName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '(267)', summary: localizations.elemRfSummary, dailyLifeUse: localizations.elemRfUse, discoveredBy: 'Albert Ghiorso',
      ),
      ElementModel(
        atomicNumber: 105, symbol: 'Db', name: localizations.elemDbName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '(270)', summary: localizations.elemDbSummary, dailyLifeUse: localizations.elemDbUse, discoveredBy: 'Albert Ghiorso',
      ),
      ElementModel(
        atomicNumber: 106, symbol: 'Sg', name: localizations.elemSgName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '(271)', summary: localizations.elemSgSummary, dailyLifeUse: localizations.elemSgUse, discoveredBy: 'Albert Ghiorso',
      ),
      ElementModel(
        atomicNumber: 107, symbol: 'Bh', name: localizations.elemBhName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '(270)', summary: localizations.elemBhSummary, dailyLifeUse: localizations.elemBhUse, discoveredBy: 'Peter Armbruster',
      ),
      ElementModel(
        atomicNumber: 108, symbol: 'Hs', name: localizations.elemHsName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '(277)', summary: localizations.elemHsSummary, dailyLifeUse: localizations.elemHsUse, discoveredBy: 'Peter Armbruster',
      ),
      ElementModel(
        atomicNumber: 109, symbol: 'Mt', name: localizations.elemMtName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '(278)', summary: localizations.elemMtSummary, dailyLifeUse: localizations.elemMtUse, discoveredBy: 'Peter Armbruster',
      ),
      ElementModel(
        atomicNumber: 110, symbol: 'Ds', name: localizations.elemDsName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '(281)', summary: localizations.elemDsSummary, dailyLifeUse: localizations.elemDsUse, discoveredBy: 'Sigurd Hofmann',
      ),
      ElementModel(
        atomicNumber: 111, symbol: 'Rg', name: localizations.elemRgName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '(282)', summary: localizations.elemRgSummary, dailyLifeUse: localizations.elemRgUse, discoveredBy: 'Sigurd Hofmann',
      ),
      ElementModel(
        atomicNumber: 112, symbol: 'Cn', name: localizations.elemCnName,
        category: localizations.catTransition, categoryType: ElementCategoryType.transitionMetal,
        atomicMass: '(285)', summary: localizations.elemCnSummary, dailyLifeUse: localizations.elemCnUse, discoveredBy: 'Sigurd Hofmann',
      ),
      ElementModel(
        atomicNumber: 113, symbol: 'Nh', name: localizations.elemNhName,
        category: localizations.catPostTransition, categoryType: ElementCategoryType.postTransitionMetal,
        atomicMass: '(286)', summary: localizations.elemNhSummary, dailyLifeUse: localizations.elemNhUse, discoveredBy: 'Kosuke Morita',
      ),
      ElementModel(
        atomicNumber: 114, symbol: 'Fl', name: localizations.elemFlName,
        category: localizations.catPostTransition, categoryType: ElementCategoryType.postTransitionMetal,
        atomicMass: '(289)', summary: localizations.elemFlSummary, dailyLifeUse: localizations.elemFlUse, discoveredBy: 'Yuri Oganessian',
      ),
      ElementModel(
        atomicNumber: 115, symbol: 'Mc', name: localizations.elemMcName,
        category: localizations.catPostTransition, categoryType: ElementCategoryType.postTransitionMetal,
        atomicMass: '(290)', summary: localizations.elemMcSummary, dailyLifeUse: localizations.elemMcUse, discoveredBy: 'Yuri Oganessian',
      ),
      ElementModel(
        atomicNumber: 116, symbol: 'Lv', name: localizations.elemLvName,
        category: localizations.catPostTransition, categoryType: ElementCategoryType.postTransitionMetal,
        atomicMass: '(293)', summary: localizations.elemLvSummary, dailyLifeUse: localizations.elemLvUse, discoveredBy: 'Yuri Oganessian',
      ),
      ElementModel(
        atomicNumber: 117, symbol: 'Ts', name: localizations.elemTsName,
        category: localizations.catHalogen, categoryType: ElementCategoryType.halogen,
        atomicMass: '(294)', summary: localizations.elemTsSummary, dailyLifeUse: localizations.elemTsUse, discoveredBy: 'Yuri Oganessian',
      ),
      ElementModel(
        atomicNumber: 118, symbol: 'Og', name: localizations.elemOgName,
        category: localizations.catNobleGas, categoryType: ElementCategoryType.nobleGas,
        atomicMass: '(294)', summary: localizations.elemOgSummary, dailyLifeUse: localizations.elemOgUse, discoveredBy: 'Yuri Oganessian',
      ),
    ];
  }
}
