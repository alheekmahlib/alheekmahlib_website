import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData brown = _buildLightTheme();
  static final ThemeData dark = _buildDarkTheme();

  static ThemeData _buildLightTheme() {
    const seed = Color(0xff344C36); // deep brown accent
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
      surface: const Color(0xffFFFFFF),
    );
    return ThemeData(
      useMaterial3: false,
      colorScheme: scheme.copyWith(
        primary: const Color(0xffFAAD1A),
        onPrimary: const Color(0xff344C36),
        secondary: const Color(0xffFFFFFE),
        surface: const Color(0xffFFFFFF),
        inversePrimary: const Color(0xff000000),
      ),
      primaryColor: const Color(0xffE6DAC8),
      primaryColorLight: const Color(0xffFFFFFE),
      primaryColorDark: const Color(0xff344C36),
      scaffoldBackgroundColor: const Color(0xffF7F1EC),
      dividerColor: const Color(0xffFAAD1A),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: const CardThemeData(
        elevation: 1,
        color: Color(0xffFFFFFF),
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      chipTheme: ChipThemeData(
        labelStyle: const TextStyle(fontFamily: 'cairo', height: 1.3),
        selectedColor: seed.withValues(alpha: .16),
        side: BorderSide(color: seed.withValues(alpha: 0.2)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: seed.withValues(alpha: 0.2),
        selectionHandleColor: seed,
      ),
      cupertinoOverrideTheme: const CupertinoThemeData(primaryColor: seed),
    );
  }

  static ThemeData _buildDarkTheme() {
    const seed = Color(0xffE6DAC8); // light tan accent on dark
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
      surface: const Color(0xff232324),
    );
    return ThemeData(
      useMaterial3: false,
      colorScheme: scheme.copyWith(
        primary: const Color(0xffFAAD1A),
        surface: const Color(0xff232324),
        onPrimary: const Color(0xff344C36),
        secondary: const Color(0xffFFFFFE),
        inversePrimary: const Color(0xffFFFFFF),
        // surface: const Color(0xffFFFFFF),
      ),
      primaryColor: const Color(0xff3F3F3F),
      primaryColorLight: const Color(0xff4d4d4d),
      primaryColorDark: const Color(0xff010101),
      scaffoldBackgroundColor: const Color(0xff252526),
      dividerColor: const Color(0xffE6DAC8),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: const CardThemeData(
        elevation: 1,
        color: Color(0xff232324),
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      chipTheme: ChipThemeData(
        labelStyle: const TextStyle(fontFamily: 'cairo', height: 1.3),
        selectedColor: const Color(0xffE6DAC8).withValues(alpha: 0.12),
        side: BorderSide(color: const Color(0xffE6DAC8).withValues(alpha: 0.2)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: const Color(0xffE6DAC8).withValues(alpha: 0.2),
        selectionHandleColor: const Color(0xffE6DAC8),
      ),
      cupertinoOverrideTheme:
          const CupertinoThemeData(primaryColor: Color(0xff3C2A21)),
    );
  }
}
