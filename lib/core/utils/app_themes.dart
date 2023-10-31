import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class AppThemes {
  static final AppTheme brown = AppTheme(
      id: 'brown',
      description: "My green Theme",
      data: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xffE6DAC8),
          onPrimary: Color(0xff3C2A21),
          secondary: Color(0xffFFFFFE),
          onSecondary: Color(0xffFFFFFE),
          error: Color(0xffE6DAC8),
          onError: Color(0xffE6DAC8),
          background: Color(0xffF7F1EC),
          onBackground: Color(0xffF7F1EC),
          surface: Color(0xffE6DAC8),
          onSurface: Color(0xffE6DAC8),
        ),
        primaryColor: const Color(0xffE6DAC8),
        primaryColorLight: const Color(0xffFFFFFE),
        primaryColorDark: const Color(0xff3C2A21),
        dialogBackgroundColor: const Color(0xfff2f1da),
        dividerColor: const Color(0xffcdba72),
        highlightColor: const Color(0xffE6DAC8).withOpacity(0.8),
        indicatorColor: const Color(0xffcdba72),
        scaffoldBackgroundColor: const Color(0xffE6DAC8),
        canvasColor: const Color(0xffF7F1EC),
        hoverColor: const Color(0xfff2f1da).withOpacity(0.3),
        disabledColor: const Color(0Xffffffff),
        hintColor: const Color(0xffE6DAC8),
        focusColor: const Color(0xffE6DAC8),
        secondaryHeaderColor: const Color(0xffFFFFFE),
        cardColor: const Color(0xffE6DAC8),
        dividerTheme: const DividerThemeData(
          color: Color(0xff3C2A21),
        ),
        textSelectionTheme: TextSelectionThemeData(
            selectionColor: const Color(0xff3C2A21).withOpacity(0.3),
            selectionHandleColor: const Color(0xff3C2A21)),
        cupertinoOverrideTheme: const CupertinoThemeData(
          primaryColor: Color(0xff3C2A21),
        ),
      ).copyWith());

  static final AppTheme dark = AppTheme(
    id: 'dark',
    description: "My dark Theme",
    data: ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff3F3F3F),
        onPrimary: Color(0xff252526),
        secondary: Color(0xff4d4d4d),
        onSecondary: Color(0xff4d4d4d),
        error: Color(0xffE6DAC8),
        onError: Color(0xffE6DAC8),
        background: Color(0xff19191a),
        onBackground: Color(0xff3F3F3F),
        surface: Color(0xffE6DAC8),
        onSurface: Color(0xffE6DAC8),
      ),
      primaryColor: const Color(0xff3F3F3F),
      primaryColorLight: const Color(0xff4d4d4d),
      primaryColorDark: const Color(0xff010101),
      dialogBackgroundColor: const Color(0xff3F3F3F),
      dividerColor: const Color(0xffE6DAC8),
      highlightColor: const Color(0xffE6DAC8).withOpacity(0.3),
      indicatorColor: const Color(0xffE6DAC8),
      scaffoldBackgroundColor: const Color(0xff252526),
      canvasColor: const Color(0xffF7F1EC),
      hoverColor: const Color(0xfff2f1da).withOpacity(0.3),
      disabledColor: const Color(0Xffffffff),
      hintColor: const Color(0xff252526),
      focusColor: const Color(0xffE6DAC8),
      secondaryHeaderColor: const Color(0xffE6DAC8),
      cardColor: const Color(0xffF7F1EC),
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: const Color(0xffE6DAC8).withOpacity(0.3),
          selectionHandleColor: const Color(0xffE6DAC8)),
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: Color(0xff3C2A21),
      ),
    ).copyWith(),
  );

  static List<AppTheme> get list => [AppThemes.brown, AppThemes.dark];
}
