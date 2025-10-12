// Lightweight cross-platform userAgent getter.
// On Web, uses dart:html; on other platforms returns empty string.

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

String platformUserAgent() {
  try {
    return html.window.navigator.userAgent.toLowerCase();
  } catch (_) {
    return '';
  }
}
