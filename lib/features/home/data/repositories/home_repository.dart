import 'package:chemistry_initiative/features/home/data/models/home_card_model.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';

class HomeRepository {
  List<HomeCardModel> getNatureCards(AppLocalizations localizations) {
    return [
      HomeCardModel(
        image: 'assets/images/burning_gas.jpg',
        title: localizations.burningGas,
      ),
      HomeCardModel(
        image: 'assets/images/ancient_forest.jpg',
        title: localizations.forests,
      ),
      HomeCardModel(
        image: 'assets/images/bowl_of_coal.jpg',
        title: localizations.coalBurning,
      ),
      HomeCardModel(
        image: 'assets/images/elephant_mountain.jpg',
        title: localizations.rocks,
      ),
    ];
  }

  List<HomeCardModel> getWaterCards(AppLocalizations localizations) {
    return [
      HomeCardModel(
        image: 'assets/images/enchanting_nature.jpg',
        title: localizations.solutionAbsorption,
      ),
      HomeCardModel(
        image: 'assets/images/nature_rain.jpg',
        title: localizations.rainDrops,
      ),
      HomeCardModel(
        image: 'assets/images/contaminacion.jpg',
        title: localizations.factorySmoke,
      ),
      HomeCardModel(
        image:
            'assets/images/vacation_spots.jpg',
        title: localizations.crystal,
      ),
    ];
  }

  List<HomeCardModel> getDailyCards(AppLocalizations localizations) {
    return [
      HomeCardModel(
        image: 'assets/images/bread_vcg.jpg',
        title: localizations.breadFermentation,
      ),
      HomeCardModel(
        image: 'assets/images/carbon_quantum_dots.jpg',
        title: localizations.medicalLabs,
      ),
      HomeCardModel(
        image: 'assets/images/handmade.jpg',
        title: localizations.medicines,
      ),
      HomeCardModel(
        image: 'assets/images/combustion_unsplash.jpg',
        title: localizations.combustion,
      ),
    ];
  }
}
