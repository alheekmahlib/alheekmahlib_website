import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../presentation/athkar_screen/controllers/athkar_controller.dart';
import '../../presentation/contact_us/controller/contact_controller.dart';
import '../../presentation/controllers/general_controller.dart';
import '../../presentation/controllers/settings_controller.dart';
import '../../presentation/controllers/theme_controller.dart';
import '../../presentation/controllers/translate_controller.dart';
import '../../presentation/our_apps/our_apps.dart';
import '../utils/helpers/app_router.dart';

final sl = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {
    // Controllers
    sl.registerLazySingleton<GeneralController>(
        () => Get.put<GeneralController>(GeneralController(), permanent: true));

    sl.registerLazySingleton<SettingsController>(() =>
        Get.put<SettingsController>(SettingsController(), permanent: true));

    sl.registerLazySingleton<AthkarController>(
        () => Get.put<AthkarController>(AthkarController(), permanent: true));

    sl.registerLazySingleton<AppsInfoController>(() =>
        Get.put<AppsInfoController>(AppsInfoController(), permanent: true));

    sl.registerLazySingleton<TranslateDataController>(() =>
        Get.put<TranslateDataController>(TranslateDataController(),
            permanent: true));

    sl.registerLazySingleton<AppRouter>(
        () => Get.put<AppRouter>(AppRouter(), permanent: true));

    // Eager registration to ensure availability for Get.find in widgets
    final ContactController contactController =
        Get.put<ContactController>(ContactController(), permanent: true);
    sl.registerSingleton<ContactController>(contactController);

    // Theme controller must be available before building MyApp (used by GetBuilder)
    final ThemeController themeController =
        Get.put<ThemeController>(ThemeController(), permanent: true);
    sl.registerSingleton<ThemeController>(themeController);
  }
}
