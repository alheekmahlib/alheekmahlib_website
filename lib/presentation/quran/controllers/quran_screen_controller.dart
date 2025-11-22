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
  int? _initialTargetPage; // الصفحة المطلوبة من رابط الدخول
  bool _initialApplied = false;
  int _attempts = 0;
  static const int _maxAttempts = 20;

  @override
  void onInit() {
    super.onInit();
    _readInitialPageFromUrl();
    _pageUrlSyncWorker = debounce<int>(
      QuranCtrl.instance.state.currentPageNumber,
      onPageChanged,
      time: const Duration(milliseconds: 200),
    );
    // محاولات متكررة خفيفة لتطبيق الصفحة المطلوبة بعد البناء
    _scheduleRetryApply();
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

  void _readInitialPageFromUrl() {
    final frag = Uri.base.fragment; // مع استراتيجية الهاش
    final full = frag.isNotEmpty ? Uri.parse(frag) : Uri.base;
    final raw = full.queryParameters['page'];
    final parsed = int.tryParse(raw ?? '');
    if (parsed != null && parsed > 0) {
      _initialTargetPage = parsed.clamp(1, 700); // حد أعلى احتياطي
    }
  }

  void _scheduleRetryApply() {
    if (_initialTargetPage == null || _initialApplied) return;
    // إذا كانت الصفحة الحالية بالفعل الهدف اعتبرها مطبقة
    if (QuranCtrl.instance.state.currentPageNumber.value ==
        _initialTargetPage) {
      _initialApplied = true;
      return;
    }
    // جرّب القفز ثم أعد المحاولة لاحقًا حتى تنجح أو تنتهي المحاولات
    Future.delayed(const Duration(milliseconds: 250), () {
      if (_initialApplied) return;
      _attempts++;
      try {
        if (_initialTargetPage != null) {
          QuranLibrary().jumpToPage(_initialTargetPage!);
        }
        // تحقق إن تم التغيير فعلاً
        if (QuranCtrl.instance.state.currentPageNumber.value ==
            _initialTargetPage) {
          _initialApplied = true;
        }
      } catch (_) {}
      if (!_initialApplied && _attempts < _maxAttempts) {
        _scheduleRetryApply();
      }
    });
  }

  @override
  void onClose() {
    _pageUrlSyncWorker?.dispose();
    super.onClose();
  }
}
