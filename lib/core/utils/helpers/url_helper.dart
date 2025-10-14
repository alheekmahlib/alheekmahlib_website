// A small cross-platform URL helper. On web, updates the URL using History API
// without triggering navigation. On other platforms, it's a no-op.

import 'url_helper_stub.dart' if (dart.library.html) 'url_helper_web.dart'
    as impl;

class UrlHelper {
  /// Replace the browser URL path (supports hash strategy) without navigation.
  /// `path` should be like '/books/read/1?page=566'.
  static void replacePath(String path) => impl.replacePath(path);
}
