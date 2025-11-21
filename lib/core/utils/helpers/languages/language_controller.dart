import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app_constants.dart';
import 'language_models.dart';

class LocalizationController extends GetxController implements GetxService {
  LocalizationController() {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(AppConstants.languages[0].languageCode,
      AppConstants.languages[0].countryCode);

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  List<LanguageModel> _languages = [];
  Locale get locale => _locale;
  List<LanguageModel> get languages => _languages;

  void loadCurrentLanguage() {
    _locale = Locale(
        GetStorage().read(AppConstants.LANGUAGE_CODE) ??
            AppConstants.languages[1].languageCode,
        GetStorage().read(AppConstants.COUNTRY_CODE) ??
            AppConstants.languages[1].countryCode);

    for (int index = 0; index < AppConstants.languages.length; index++) {
      if (AppConstants.languages[index].languageCode == _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }
    _languages = [];
    _languages.addAll(AppConstants.languages);
    update();
  }

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    saveLanguage(_locale);
    update();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void saveLanguage(Locale locale) async {
    GetStorage().write(AppConstants.LANGUAGE_CODE, locale.languageCode);
    GetStorage().write(AppConstants.COUNTRY_CODE, locale.countryCode!);
  }
}
