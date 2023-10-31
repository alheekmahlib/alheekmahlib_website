import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:seo_renderer/helpers/renderer_state.dart';
import 'package:seo_renderer/helpers/robot_detector_vm.dart';
import 'package:theme_provider/theme_provider.dart';

import 'core/services/controllers/pageNavigation_controller.dart';
import 'core/utils/app_themes.dart';
import 'core/utils/helpers/languages/app_constants.dart';
import 'core/utils/helpers/languages/language_controller.dart';
import 'core/utils/helpers/languages/messages.dart';
import 'services_locator.dart';

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      defaultThemeId: 'brown',
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
            controller.setTheme('brown');
          }
          controller.forgetSavedTheme();
        }
      },
      themes: AppThemes.list,
      child: ThemeConsumer(
        child: Builder(builder: (themeContext) {
          return GetBuilder<LocalizationController>(
              builder: (localizationController) {
            return RobotDetector(
              debug: false,
              child: GetMaterialApp(
                title: 'AlheekmahLib Website',
                debugShowCheckedModeBanner: false,
                locale: localizationController.locale,
                translations: Messages(languages: languages),
                fallbackLocale: Locale(AppConstants.languages[1].languageCode,
                    AppConstants.languages[1].countryCode),
                builder: BotToastInit(),
                navigatorObservers: [
                  BotToastNavigatorObserver(),
                  seoRouteObserver
                ],
                home: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeProvider.themeOf(themeContext).data,
                  routerConfig: sl<PageNavigationController>().router,
                ),
              ),
            );
          });
        }),
      ),
    );
  }
}
