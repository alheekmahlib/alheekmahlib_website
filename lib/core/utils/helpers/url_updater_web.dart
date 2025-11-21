// Web-specific URL updater that avoids triggering go_router rebuilds
// by using the browser History API directly.
import 'dart:html' as html;

void updateBrowserUrl(String pathWithQuery, {bool replace = true}) {
  // Detect hash strategy: if current app uses fragment routing like #/quran
  final usesHash = html.window.location.hash.isNotEmpty;
  final newUrl = usesHash ? '#$pathWithQuery' : pathWithQuery;
  if (replace) {
    html.window.history.replaceState(null, '', newUrl);
  } else {
    html.window.history.pushState(null, '', newUrl);
  }
}
