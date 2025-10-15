// ignore_for_file: constant_identifier_names

import 'language_models.dart';

class AppConstants {
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en',
      appLang: 'App Language',
    ),
    LanguageModel(
      languageName: 'العربية',
      countryCode: '',
      languageCode: 'ar',
      appLang: 'لغة التطبيق',
    ),
    LanguageModel(
      languageName: 'বাংলা',
      countryCode: '',
      languageCode: 'be',
      appLang: 'অ্যাপের ভাষা',
    ),
    LanguageModel(
      languageName: 'Español',
      countryCode: 'ES',
      languageCode: 'es',
      appLang: 'Idioma de la aplicación',
    ),
    LanguageModel(
      languageName: 'اردو',
      countryCode: 'PK',
      languageCode: 'ur',
      appLang: 'ایپ کی زبان',
    ),
    LanguageModel(
      languageName: 'Filipino',
      countryCode: 'PH',
      languageCode: 'tl',
      appLang: 'Wika ng App',
    ),
    LanguageModel(
      languageName: 'Bahasa Indonesia',
      countryCode: 'ID',
      languageCode: 'id',
      appLang: 'Bahasa Aplikasi',
    ),
    LanguageModel(
      languageName: 'Türkçe',
      countryCode: 'TR',
      languageCode: 'tr',
      appLang: 'Uygulama Dili',
    ),
    LanguageModel(
      languageName: 'کوردی',
      countryCode: 'IQ',
      languageCode: 'ku',
      appLang: 'زمانی ئەپ',
    ),
    LanguageModel(
      languageName: 'Soomaali',
      countryCode: 'SO',
      languageCode: 'so',
      appLang: 'Luuqadda App-ka',
    ),
  ];
}
