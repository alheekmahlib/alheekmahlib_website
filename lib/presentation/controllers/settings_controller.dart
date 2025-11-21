import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  Locale? initialLang;
  RxString languageName = 'العربية'.obs;
  RxString languageFont = 'naskh'.obs;
  // RxString languageFont2 = 'cairo'.obs;
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
    String? langCode = GetStorage().read("lang") ?? 'ar';
    String? langName = GetStorage().read("langName") ?? 'العربية';
    String? langFont = GetStorage().read("languageFont") ?? 'naskh';
    // String? langFont2 = GetStorage().read("languageFont2");

    if (langCode.isEmpty) {
      initialLang = const Locale('ar', 'AE');
    } else {
      initialLang = Locale(langCode, '');
    }

    languageName.value = langName;
    languageFont.value = langFont;
    // languageFont2.value = langFont2;
    // log('get lang $initialLang');
  }
}
