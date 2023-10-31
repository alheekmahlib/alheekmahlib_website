import 'dart:ui';

import 'package:get/get.dart';

import '../../../services_locator.dart';
import '../shared_pref_services.dart';

class SettingsController extends GetxController {
  Locale? initialLang;
  RxString languageName = 'العربية'.obs;
  RxString languageFont = 'naskh'.obs;
  // RxString languageFont2 = 'kufi'.obs;
  RxBool settingsSelected = false.obs;

  @override
  void onInit() {
    loadLang();
    super.onInit();
  }

  void setLocale(Locale value) {
    initialLang = value;
    update();
  }

  Future<void> loadLang() async {
    String? langCode = await sl<SharedPrefServices>().getString("lang");
    String? langName = await sl<SharedPrefServices>()
        .getString("langName", defaultValue: 'العربية');
    String? langFont = await sl<SharedPrefServices>().getString("languageFont");
    String? langFont2 =
        await sl<SharedPrefServices>().getString("languageFont2");

    print(
        'Lang code: $langCode'); // Add this line to debug the value of langCode

    if (langCode.isEmpty) {
      initialLang = const Locale('ar', 'AE');
    } else {
      initialLang = Locale(
          langCode, ''); // Make sure langCode is not null or invalid here
    }

    languageName.value = langName;
    languageFont.value = langFont;
    // languageFont2.value = langFont2;

    print('get lang $initialLang');
  }

  List languageList = [
    {
      'lang': 'ar',
      'appLang': 'لغة التطبيق',
      'name': 'العربية',
      'font': 'naskh',
      'font2': 'kufi'
    },
    {
      'lang': 'en',
      'appLang': 'App Language',
      'name': 'English',
      'font': 'naskh',
      'font2': 'naskh'
    },
    {
      'lang': 'be',
      'appLang': "অ্যাপের ভাষা",
      'name': 'বাংলা',
      'font': 'be',
      'font2': 'be'
    }
  ];
}
