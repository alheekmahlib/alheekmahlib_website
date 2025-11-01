import 'package:flutter/material.dart';
import 'package:quran_library/quran.dart';

import 'core/services/services_locator.dart';
import 'core/utils/helpers/languages/dependency_inj.dart' as dep;
import 'core/utils/web_url_strategy_stub.dart'
    if (dart.library.html) 'core/utils/web_url_strategy_web.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Configure hash-based URL strategy for web so links like #/download/quran work
  configureAppUrlStrategy();
  Map<String, Map<String, String>> languages = await dep.init();
  await QuranLibrary.init();
  QuranLibrary().setFontsSelected = 1;
  await ServicesLocator().init();
  runApp(MyApp(languages: languages));
}
