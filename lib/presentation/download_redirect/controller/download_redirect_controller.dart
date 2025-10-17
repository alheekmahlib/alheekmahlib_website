import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_huawei_availability/google_huawei_availability.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/services/services_locator.dart';
import '../../controllers/general_controller.dart';
import '../../our_apps/data/model/our_app_info_model.dart';
import '../screens/platform_user_agent_stub.dart'
    if (dart.library.html) '../screens/platform_user_agent_web.dart';

class DownloadRedirectController extends GetxController {
  DownloadRedirectController({required this.slug});

  final String slug;

  OurAppInfo? app;
  bool loading = true;
  String? error;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _start();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> _start() async {
    loading = true;
    error = null;
    update();
    try {
      final apps = await sl<GeneralController>().fetchApps();
      final normalizedSlug = slug.trim().toLowerCase();
      final matched = apps.where((a) {
        if (a.appName.trim().toLowerCase() == normalizedSlug) return true;
        final titleNorm = _normalize(a.appTitle);
        if (titleNorm == normalizedSlug || titleNorm.contains(normalizedSlug)) {
          return true;
        }
        final urls =
            '${a.urlAppStore}|${a.urlMacAppStore}|${a.urlPlayStore}|${a.urlAppGallery}'
                .toLowerCase();
        return a.id.toString() == normalizedSlug ||
            urls.contains(normalizedSlug);
      });
      app = matched.isNotEmpty ? matched.first : null;

      if (app == null) {
        loading = false;
        error = 'app_not_found'.tr;
        update();
        return;
      }

      loading = false;
      update();

      _timer = Timer(const Duration(milliseconds: 800), openStoreNow);
    } catch (e) {
      loading = false;
      error = e.toString();
      update();
    }
  }

  String _normalize(String text) {
    final s = text.trim().toLowerCase();
    final replaced = s.replaceAll(RegExp(r'[^a-z0-9]+'), '-');
    final collapsed = replaced.replaceAll(RegExp(r'-+'), '-');
    final trimmed =
        collapsed.replaceAll(RegExp(r'^-'), '').replaceAll(RegExp(r'-$'), '');
    return trimmed;
  }

  Future<void> openStoreNow() async {
    final a = app;
    if (a == null) return;
    final url = await _pickUrlForCurrentPlatform(a);
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    }
  }

  Future<String> _pickUrlForCurrentPlatform(OurAppInfo a) async {
    // Web: نفضّل المتجر بحسب userAgent إن أمكن
    if (kIsWeb) {
      bool? isHuawei = await GoogleHuaweiAvailability.isHuaweiServiceAvailable;

      final agent = platformUserAgent();
      // تفضيل هواوي على الويب إذا ظهر في userAgent
      final looksHuawei = agent.contains('huawei') ||
          agent.contains('huaweibrowser') ||
          agent.contains('hms') ||
          agent.contains('hmscore') ||
          agent.contains('build/huawei') ||
          agent.contains('build/honor') ||
          agent.contains(' hw-') ||
          agent.contains('harmony') ||
          agent.contains('honor') ||
          agent.contains('hisilicon') ||
          agent.contains('petal');
      if (looksHuawei || isHuawei == true) {
        return a.urlAppGallery.isNotEmpty
            ? a.urlAppGallery
            : (a.urlPlayStore.isNotEmpty
                ? a.urlPlayStore
                : (a.urlAppStore.isNotEmpty
                    ? a.urlAppStore
                    : a.urlMacAppStore));
      }
      if (agent.contains('iphone') ||
          agent.contains('ipad') ||
          agent.contains('mac os')) {
        return a.urlAppStore.isNotEmpty
            ? a.urlAppStore
            : (a.urlMacAppStore.isNotEmpty ? a.urlMacAppStore : a.urlPlayStore);
      }
      if (agent.contains('android')) {
        // على الويب، لا نتمكن من استخدام حزمة هواوي؛ fallback ذكي
        return a.urlPlayStore.isNotEmpty ? a.urlPlayStore : a.urlAppGallery;
      }
      return a.urlPlayStore.isNotEmpty
          ? a.urlPlayStore
          : (a.urlAppStore.isNotEmpty ? a.urlAppStore : a.urlAppGallery);
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return a.urlAppStore.isNotEmpty ? a.urlAppStore : a.urlPlayStore;
      case TargetPlatform.android:
        // استخدم كشف هواوي/جوجل على أجهزة أندرويد فقط
        try {
          final isHuawei =
              await GoogleHuaweiAvailability.isHuaweiServiceAvailable;
          final isGoogle =
              await GoogleHuaweiAvailability.isGoogleServiceAvailable;
          if (isHuawei == true) {
            return a.urlAppGallery.isNotEmpty
                ? a.urlAppGallery
                : (a.urlPlayStore.isNotEmpty ? a.urlPlayStore : a.urlAppStore);
          }
          if (isGoogle == true) {
            return a.urlPlayStore.isNotEmpty ? a.urlPlayStore : a.urlAppGallery;
          }
        } catch (_) {
          // تجاهل الأخطاء واستخدم fallback
        }
        // في حال عدم القدرة على تحديد هواوي/جوجل، نفضّل AppGallery أولًا على أجهزة أندرويد
        return a.urlAppGallery.isNotEmpty ? a.urlAppGallery : a.urlPlayStore;
      case TargetPlatform.macOS:
        return a.urlMacAppStore.isNotEmpty ? a.urlMacAppStore : a.urlAppStore;
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        return a.urlPlayStore.isNotEmpty
            ? a.urlPlayStore
            : (a.urlAppStore.isNotEmpty ? a.urlAppStore : a.urlAppGallery);
    }
  }
}
