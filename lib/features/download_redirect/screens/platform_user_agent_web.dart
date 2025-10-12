// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

String platformUserAgent() {
  try {
    return html.window.navigator.userAgent.toLowerCase();
  } catch (_) {
    return '';
  }
}
