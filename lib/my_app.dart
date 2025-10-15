import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seo_renderer/helpers/renderer_state.dart';
import 'package:seo_renderer/helpers/robot_detector_vm.dart';

import 'core/services/services_locator.dart';
import 'core/utils/app_themes.dart';
import 'core/utils/helpers/app_router.dart';
import 'core/utils/helpers/languages/app_constants.dart';
import 'core/utils/helpers/languages/language_controller.dart';
import 'core/utils/helpers/languages/messages.dart';
import 'presentation/controllers/theme_controller.dart';

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    // Bind theming to GetX ThemeController instead of theme_provider
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return GetBuilder<ThemeController>(builder: (themeController) {
            return GetBuilder<LocalizationController>(
                builder: (localizationController) {
              return RobotDetector(
                debug: false,
                child: GetMaterialApp.router(
                  title: 'AlheekmahLib Website',
                  debugShowCheckedModeBanner: false,
                  locale: localizationController.locale,
                  translations: Messages(languages: languages),
                  fallbackLocale: Locale(AppConstants.languages[1].languageCode,
                      AppConstants.languages[1].countryCode),
                  builder: (context, child) {
                    final code = localizationController.locale.languageCode;
                    const rtlLangs = ['ar', 'fa', 'he', 'ur', 'ps'];
                    final isRtl = rtlLangs.contains(code);
                    final botToast = BotToastInit();
                    return Directionality(
                      textDirection:
                          isRtl ? TextDirection.rtl : TextDirection.ltr,
                      child: botToast(context, child),
                    );
                  },
                  navigatorObservers: [
                    BotToastNavigatorObserver(),
                    seoRouteObserver
                  ],
                  theme: AppThemes.brown,
                  darkTheme: AppThemes.dark,
                  themeMode: themeController.themeMode,
                  routerDelegate: sl<AppRouter>().router.routerDelegate,
                  routeInformationParser:
                      sl<AppRouter>().router.routeInformationParser,
                  routeInformationProvider:
                      sl<AppRouter>().router.routeInformationProvider,
                ),
              );
            });
          });
        });
  }
}
