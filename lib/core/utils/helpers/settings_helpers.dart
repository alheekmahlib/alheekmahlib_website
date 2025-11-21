import 'package:get_storage/get_storage.dart';

class SettingsHelpers {
  static final SettingsHelpers instance = SettingsHelpers._internal();
  SettingsHelpers._internal();

  factory SettingsHelpers() => instance;

  void fontSizeArabic(double fontSize) async {
    GetStorage().write('fontSizeArabic', fontSize.toString());
  }

  static const double minFontSizeArabic = 20;

  double? get getFontSizeArabic {
    final fontSizeString = GetStorage().read('fontSizeArabic');
    if (fontSizeString == null || fontSizeString.isEmpty) {
      return minFontSizeArabic;
    }
    return double.tryParse(fontSizeString) ?? minFontSizeArabic;
  }
}
