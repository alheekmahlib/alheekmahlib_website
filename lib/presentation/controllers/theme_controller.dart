import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// Simple theme controller using GetX that replaces `theme_provider`.
///
/// - Persists the selected theme id ('brown' for light, 'dark' for dark).
/// - Defaults to system brightness on first run.
class ThemeController extends GetxController {
  static ThemeController get instance =>
      GetInstance().putOrFind(() => ThemeController());

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
    // قراءة آمنة للقيمة المخزّنة (قد تكون null في أول تشغيل)
    final String? saved = GetStorage().read<String>(_prefKey);
    if (saved != null && saved.isNotEmpty) {
      // نتحقق أيضاً من صحة القيمة قبل اعتمادها
      if (saved == 'dark' || saved == 'brown') {
        themeId.value = saved;
      }
    }
    if (saved == null ||
        saved.isEmpty ||
        (saved != 'dark' && saved != 'brown')) {
      // fallback إلى تفضيل النظام عند عدم وجود قيمة صالحة
      final platformBrightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      themeId.value = platformBrightness == Brightness.dark ? 'dark' : 'brown';
    }
    update();
  }

  Future<void> setTheme(String id) async {
    if (id != 'brown' && id != 'dark') return;
    themeId.value = id;
    await GetStorage().write(_prefKey, id);
    update();
  }

  bool get isDarkMode => themeId.value == 'dark';
}
