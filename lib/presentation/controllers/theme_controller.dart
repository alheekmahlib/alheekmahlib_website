import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../core/services/services_locator.dart';
import '../../core/services/shared_pref_services.dart';

/// Simple theme controller using GetX that replaces `theme_provider`.
///
/// - Persists the selected theme id ('brown' for light, 'dark' for dark).
/// - Defaults to system brightness on first run.
class ThemeController extends GetxController {
  static const _prefKey = 'app_theme_id';

  final RxString themeId = 'brown'.obs; // 'brown' or 'dark'

  ThemeMode get themeMode =>
      themeId.value == 'dark' ? ThemeMode.dark : ThemeMode.light;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final String saved = await sl<SharedPrefServices>().getString(_prefKey);
    if (saved.isNotEmpty) {
      themeId.value = saved;
    } else {
      // Fallback to system preference on first run
      final platformBrightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      themeId.value = platformBrightness == Brightness.dark ? 'dark' : 'brown';
    }
    update();
  }

  Future<void> setTheme(String id) async {
    if (id != 'brown' && id != 'dark') return;
    themeId.value = id;
    await sl<SharedPrefServices>().saveString(_prefKey, id);
    update();
  }
}
