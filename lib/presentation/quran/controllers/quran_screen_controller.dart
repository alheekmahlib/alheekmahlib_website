import 'package:alheekmahlib_website/core/utils/helpers/navigation_keys.dart';
import 'package:alheekmahlib_website/core/utils/helpers/url_updater.dart';
import 'package:get/get.dart';
import 'package:quran_library/quran.dart';

/// Controller لمزامنة رقم الصفحة الحالي مع رابط المتصفح (?page=...)
/// دون التأثير على أداء الواجهة.
class QuranScreenController extends GetxController {
  static QuranScreenController get instance =>
      GetInstance().putOrFind(() => QuranScreenController());

  Worker? _pageUrlSyncWorker;

  @override
  void onInit() {
    super.onInit();
    _pageUrlSyncWorker = debounce<int>(
      QuranCtrl.instance.state.currentPageNumber,
      onPageChanged,
      time: const Duration(milliseconds: 200),
    );
  }

  void onPageChanged(int page) {
    if (page <= 0) return;
    // استخدم rootNavigatorKey للحصول على سياق النافيجيتور ثم استخرج GoRouter مباشرة
    final ctx = rootNavigatorKey.currentContext;
    if (ctx == null) return;
    // استخلص الموقع الحالي بشكل متوافق مع الويب (يدعم Hash strategy)
    final uri = () {
      final frag = Uri.base.fragment; // مثال: '/quran?page=123'
      if (frag.isNotEmpty && frag.startsWith('/')) {
        return Uri.parse(frag);
      }
      // بدون hash
      return Uri(
          path: Uri.base.path, queryParameters: Uri.base.queryParameters);
    }();
    // حدّث الرابط فقط عندما نكون في مسار القرآن
    if (!uri.path.startsWith('/quran')) return;

    final currentPage = uri.queryParameters['page'];
    if (currentPage == '$page') return;

    final newUri = Uri(path: uri.path, queryParameters: {
      ...uri.queryParameters,
      'page': '$page',
    });
    // حدّث الرابط دون تحفيز إعادة بناء الملاح (على الويب)، أو عبر go_router في المنصات الأخرى
    updateBrowserUrl(newUri.toString(), replace: true);
  }

  @override
  void onClose() {
    _pageUrlSyncWorker?.dispose();
    super.onClose();
  }
}
