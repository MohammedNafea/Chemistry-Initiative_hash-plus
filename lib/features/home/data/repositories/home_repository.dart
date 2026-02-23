import 'package:chemistry_initiative/features/home/data/models/home_card_model.dart';
import 'package:chemistry_initiative/l10n/app_localizations.dart';

class HomeRepository {
  List<HomeCardModel> getNatureCards(AppLocalizations localizations) {
    return [
      HomeCardModel(
        image: 'assets/images/download (4).jpg',
        title: localizations.burningGas,
      ),
      HomeCardModel(
        image: 'assets/images/Ancient Forest.jpg',
        title: localizations.forests,
      ),
      HomeCardModel(
        image: 'assets/images/A bowl of coal.jpg',
        title: localizations.coalBurning,
      ),
      HomeCardModel(
        image: 'assets/images/جبل الفيل -  العلاء.jpg',
        title: localizations.rocks,
      ),
    ];
  }

  List<HomeCardModel> getWaterCards(AppLocalizations localizations) {
    return [
      HomeCardModel(
        image: 'assets/images/Enchanting Nature and Art.jpg',
        title: localizations.solutionAbsorption,
      ),
      HomeCardModel(
        image: 'assets/images/#nature #rain #aesthetics #overcast.jpg',
        title: localizations.rainDrops,
      ),
      HomeCardModel(
        image: 'assets/images/contaminación.jpg',
        title: localizations.factorySmoke,
      ),
      HomeCardModel(
        image:
            'assets/images/Discover Top Vacation Spots Across the Planet.jpg',
        title: localizations.crystal,
      ),
    ];
  }

  List<HomeCardModel> getDailyCards(AppLocalizations localizations) {
    return [
      HomeCardModel(
        image: 'assets/images/欧包 by vcg-ailsapan.jpg',
        title: localizations.breadFermentation,
      ),
      HomeCardModel(
        image: 'assets/images/Carbon Quantum Dots.jpg',
        title: localizations.medicalLabs,
      ),
      HomeCardModel(
        image: 'assets/images/Handmade.jpg',
        title: localizations.medicines,
      ),
      HomeCardModel(
        image: 'assets/images/michael-glazier-5q5K8Q3x6e4-unsplash.jpg',
        title: localizations.combustion,
      ),
    ];
  }
}
