import 'package:shared_preferences/shared_preferences.dart';


class SettingsHelpers {

  SharedPreferences? prefs;

  static final SettingsHelpers instance = SettingsHelpers._internal();
  SettingsHelpers._internal(){
    _init();
  }

  factory SettingsHelpers() => instance;

  void _init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void fontSizeArabic(double fontSize) async {
    await prefs!.setString('fontSizeArabic', fontSize.toString());
  }

  static const double minFontSizeArabic = 20;

  double? get getFontSizeArabic {
    String fontSizeString = prefs!.getString('fontSizeArabic')!;
    return double.tryParse(fontSizeString ?? minFontSizeArabic.toString());
  }
}

