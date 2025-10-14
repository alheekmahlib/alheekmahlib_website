import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  dynamic customOrientation(var n1, var n2) {
    Orientation orientation = MediaQuery.orientationOf(this);
    return orientation == Orientation.portrait ? n1 : n2;
  }

  dynamic definePlatform(var p1, var p2) {
    final isMobile = !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.fuchsia);
    return isMobile ? p1 : p2;
  }

  Widget vDivider({double? height, Color? color}) {
    return Container(
      height: height ?? 20,
      width: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      color: color ?? Theme.of(this).colorScheme.surface,
    );
  }

  Widget hDivider({double? width, double? height, Color? color}) {
    return Container(
      height: height ?? 2,
      width: width ?? MediaQuery.sizeOf(this).width,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      color: color ?? Theme.of(this).primaryColorLight,
    );
  }
}
