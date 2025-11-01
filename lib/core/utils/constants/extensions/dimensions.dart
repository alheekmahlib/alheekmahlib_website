import 'package:flutter/material.dart';

extension Dimensions on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get textDarkColor => isDark
      ? Theme.of(this).colorScheme.secondary
      : Theme.of(this).primaryColorDark;

  Color get beigeDarkColor => isDark
      ? Theme.of(this).colorScheme.primary
      : Theme.of(this).colorScheme.primary.withValues(alpha: 0.25);

  Color get surfaceDarkColor => isDark
      ? Theme.of(this).colorScheme.surface
      : Theme.of(this).primaryColorDark;

  Color get iconsLightColor => isDark
      ? Theme.of(this).primaryColorDark
      : Theme.of(this).colorScheme.surface;

  Color get iconsDarkColor => isDark
      ? Theme.of(this).colorScheme.primary
      : Theme.of(this).colorScheme.onPrimary;
}
