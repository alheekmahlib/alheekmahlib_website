import 'package:flutter/material.dart';

import 'core/utils/helpers/languages/dependency_inj.dart' as dep;
import 'my_app.dart';
import 'services_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Map<String, String>> languages = await dep.init();
  await ServicesLocator().init();
  runApp(MyApp(languages: languages));
}
