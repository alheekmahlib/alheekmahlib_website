import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:theme_provider/theme_provider.dart';

void main() {
  runApp(MyApp(theme: ThemeData.light()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key,
    required this.theme,});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      defaultThemeId: 'green',
      saveThemesOnChange: true,
      loadThemeOnInit: false,
      onInitCallback: (controller, previouslySavedThemeFuture) async {
        String? savedTheme = await previouslySavedThemeFuture;
        if (savedTheme != null) {
          controller.setTheme(savedTheme);
        } else {
          Brightness platformBrightness =
              SchedulerBinding.instance.window.platformBrightness ??
                  Brightness.light;
          if (platformBrightness == Brightness.dark) {
            controller.setTheme('dark');
          } else {
            controller.setTheme('green');
          }
          controller.forgetSavedTheme();
        }
      },
      themes: <AppTheme>[
        AppTheme(
          id: 'green',
          description: "My Custom Theme",
          data: ThemeData(
            primaryColor: const Color(0xff232c13),
            primaryColorLight: const Color(0xff39412a),
            primaryColorDark: const Color(0xff161f07),
            bottomAppBarColor: const Color(0xff91a57d),
            backgroundColor: const Color(0xfff3efdf),
            dialogBackgroundColor: const Color(0xfff2f1da),
            dividerColor: const Color(0xffcdba72),
            highlightColor: const Color(0xff91a57d).withOpacity(0.3),
            indicatorColor: const Color(0xffcdba72),
            toggleableActiveColor: const Color(0xffcdba72),
            scaffoldBackgroundColor: const Color(0xff232c13),
            canvasColor: const Color(0xfff3efdf),
            hoverColor: const Color(0xfff2f1da).withOpacity(0.3),
            disabledColor: const Color(0Xffffffff),
            hintColor: const Color(0xff232c13),
            focusColor: const Color(0xff91a57d),
            secondaryHeaderColor: const Color(0xff39412a),
            cardColor: const Color(0xff232c13),
            textSelectionTheme: TextSelectionThemeData(
                selectionColor: const Color(0xff91a57d).withOpacity(0.3),
                selectionHandleColor: const Color(0xff91a57d)),
            cupertinoOverrideTheme: const CupertinoThemeData(
              primaryColor: Color(0xff606c38),
            ),
          ),
        ),
        AppTheme(
          id: 'blue',
          description: "My Custom Theme",
          data: ThemeData(
            primaryColor: const Color(0xffbc6c25),
            primaryColorLight: const Color(0xfffcbb76),
            primaryColorDark: const Color(0xff814714),
            bottomAppBarColor: const Color(0xff606c38),
            backgroundColor: const Color(0xfffefae0),
            dialogBackgroundColor: const Color(0xfffefae0),
            dividerColor: const Color(0xfffcbb76),
            highlightColor: const Color(0xfffcbb76).withOpacity(0.3),
            indicatorColor: const Color(0xfffcbb76),
            toggleableActiveColor: const Color(0xff606c38),
            scaffoldBackgroundColor: const Color(0xff814714),
            canvasColor: const Color(0xffF2E5D5),
            hoverColor: const Color(0xffF2E5D5).withOpacity(0.3),
            disabledColor: const Color(0Xffffffff),
            hintColor: const Color(0xff814714),
            focusColor: const Color(0xffbc6c25),
            secondaryHeaderColor: const Color(0xffbc6c25),
            cardColor: const Color(0xff814714),
            textSelectionTheme: TextSelectionThemeData(
                selectionColor: const Color(0xff606c38).withOpacity(0.3),
                selectionHandleColor: const Color(0xff606c38)),
            cupertinoOverrideTheme: const CupertinoThemeData(
              primaryColor: Color(0xff606c38),
            ),
          ),
        ),
        AppTheme(
          id: 'dark',
          description: "My Custom Theme",
          data: ThemeData(
            primaryColor: const Color(0xff3F3F3F),
            primaryColorLight: const Color(0xff4d4d4d),
            primaryColorDark: const Color(0xff2d2d2d),
            bottomAppBarColor: const Color(0xff91a57d),
            backgroundColor: const Color(0xff3F3F3F),
            dialogBackgroundColor: const Color(0xff3F3F3F),
            dividerColor: const Color(0xff91a57d),
            highlightColor: const Color(0xff91a57d).withOpacity(0.3),
            indicatorColor: const Color(0xff91a57d),
            toggleableActiveColor: const Color(0xff91a57d),
            scaffoldBackgroundColor: const Color(0xff2d2d2d),
            canvasColor: const Color(0xfff3efdf),
            hoverColor: const Color(0xfff2f1da).withOpacity(0.3),
            disabledColor: const Color(0Xffffffff),
            hintColor: const Color(0xff2d2d2d),
            focusColor: const Color(0xff91a57d),
            secondaryHeaderColor: const Color(0xff91a57d),
            cardColor: const Color(0xfff3efdf),
            textSelectionTheme: TextSelectionThemeData(
                selectionColor: const Color(0xff91a57d).withOpacity(0.3),
                selectionHandleColor: const Color(0xff91a57d)),
            cupertinoOverrideTheme: const CupertinoThemeData(
              primaryColor: Color(0xff606c38),
            ),
          ),
        ),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) {
            return MaterialApp(
              title: 'AlheekmahLib Website',
              debugShowCheckedModeBanner: false,
              theme: ThemeProvider.themeOf(themeContext).data,
              home: const MyHomePage(title: 'Flutter Demo Home Page'),
            );
          }
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}
