// Web implementation using the History API to update the URL without navigation.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

void replacePath(String path) {
  final base = html.window.location.href;
  // Support hash strategy: keep everything before '#', replace after.
  final hashIndex = base.indexOf('#');
  if (hashIndex >= 0) {
    final before = base.substring(0, hashIndex + 1);
    html.window.history.replaceState(null, '', '$before$path');
  } else {
    html.window.history.replaceState(null, '', path);
  }
}
