import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void configureAppUrlStrategy() {
  setUrlStrategy(const HashUrlStrategy());
}
