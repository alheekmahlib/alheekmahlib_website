import 'package:go_router/go_router.dart';

import 'navigation_keys.dart';

void updateBrowserUrl(String pathWithQuery, {bool replace = true}) {
  final ctx = rootNavigatorKey.currentContext;
  if (ctx == null) return;
  final router = GoRouter.of(ctx);
  if (replace) {
    router.replace(pathWithQuery);
  } else {
    router.go(pathWithQuery);
  }
}
