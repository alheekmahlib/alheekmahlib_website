import 'dart:developer' show log;

import 'package:flutter/widgets.dart' show ScrollController, WidgetsBinding;
import 'package:get/get.dart';

import '../books.dart';

/// تحكم في الفصول مع السكرول المحسن / Chapters controller with improved scrolling
/// يستخدم animateTo بدلاً من إعادة إنشاء ScrollController لضمان الدقة
/// Uses animateTo instead of recreating ScrollController for accuracy
class ChaptersController extends GetxController {
  static ChaptersController get instance =>
      GetInstance().putOrFind(() => ChaptersController());
  final booksCtrl = BooksController.instance;
  List<TocItem> chapters = [];
  List<Volume> volumes = [];
  bool isLoading = false;
  ScrollController itemsScrollController = ScrollController();
  TocItem? currentChapterItem;
  String? currentChapterName;

  // ارتفاع كل عنصر فصل في القائمة / Height of each chapter item in the list
  // يجب أن يتطابق مع ارتفاع العنصر في الـ Widget
  static const double _itemHeight = 40.0;

  /// حساب الموضع الصحيح للسكرول / Calculate correct scroll position
  double _calculateScrollOffset(int index) {
    if (index < 0) return 0.0;

    // حساب الموضع الأساسي / Calculate base position
    final baseOffset = index * _itemHeight;

    // التأكد من أن الموضع في النطاق المسموح / Ensure position is within allowed range
    if (itemsScrollController.hasClients) {
      final maxOffset = itemsScrollController.position.maxScrollExtent;
      if (maxOffset > 0) {
        return baseOffset.clamp(0.0, maxOffset);
      }
    }

    // إذا لم يكن هناك حد أقصى، استخدم طول القائمة / If no max limit, use list length
    final maxOffsetFallback = (chapters.length * _itemHeight) - _itemHeight;
    return baseOffset.clamp(0.0, maxOffsetFallback);
  }

  void onPageChanged(int pageIndex) {
    final pageNum = pageIndex + 1;
    final splittedChapters = <TocItem>[];
    for (final chptr in chapters) {
      if (chptr.page <= pageNum) {
        splittedChapters.add(chptr);
      }
    }
    log('Sp: ${splittedChapters.length}, ${splittedChapters.map((c) => c.text).join(',')}');
    final filtered = splittedChapters.splitBetween((f, sec) =>
        pageNum - f.page < pageNum - sec.page && f.page != sec.page);
    if (filtered.isEmpty) {
      filtered.assignAll([
        [chapters.first]
      ]);
    }
    splittedChapters.assignAll(filtered.first);
    splittedChapters.removeWhere((c) => c.page != filtered.first.last.page);

    final newChapterName =
        splittedChapters.map((chapter) => chapter.text).join(',');

    // تحديث الفصل الحالي إذا تغير / Update current chapter if changed
    if (currentChapterName != newChapterName) {
      currentChapterName = newChapterName;

      // تحديث الفصل الحالي والسكرول / Update current chapter and scroll
      final currentChapterIndex = chapters.indexWhere(
        (chapter) =>
            currentChapterName?.split(',').contains(chapter.text) == true,
      );

      if (currentChapterIndex >= 0) {
        currentChapterItem = chapters[currentChapterIndex];

        // تحديث السكرول فقط إذا كان متاحاً / Update scroll only if available
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (itemsScrollController.hasClients) {
            final targetOffset = _calculateScrollOffset(currentChapterIndex);

            // استخدام jumpTo للسكرول الفوري
            itemsScrollController.jumpTo(targetOffset);

            log('Auto-scrolled to chapter: $currentChapterName at index: $currentChapterIndex, offset: $targetOffset',
                name: 'ChaptersController');
          }
        });
      }
    }

    update(['ChapterName']);
    log('Chapter changed to: $currentChapterName', name: 'ChaptersController');
  }

  /// تحديث موضع السكرول للفصل المحدد / Update scroll position to specific chapter
  // void scrollToChapter(String chapterName) {
  //   final index = chapters.indexWhere((chapter) => chapter.text == chapterName);
  //   if (index >= 0) {
  //     // استخدام WidgetsBinding للتأكد من أن الـ Widget جاهز / Use WidgetsBinding to ensure widget is ready
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       if (itemsScrollController.hasClients) {
  //         final targetOffset = _calculateScrollOffset(index);

  //         // استخدام jumpTo للسكرول الفوري
  //         itemsScrollController.jumpTo(targetOffset);

  //         log('Scrolled to chapter: $chapterName at index: $index, offset: $targetOffset',
  //             name: 'ChaptersController');
  //       }
  //     });
  //   }
  // }

  /// التمرير إلى الفصل الحالي مع التأخير / Scroll to current chapter with delay
  // void scrollToCurrentChapterWithDelay() {
  //   if (currentChapterName != null) {
  //     final chapterNames = currentChapterName!.split(',');
  //     if (chapterNames.isNotEmpty) {
  //       scrollToChapter(chapterNames.first);
  //     }
  //   }
  // }

  /// إعادة تعيين السكرول في حالة الحاجة / Reset scroll if needed
  // void resetScrollController() {
  //   try {
  //     if (itemsScrollController.hasClients) {
  //       itemsScrollController.dispose();
  //     }
  //   } catch (e) {
  //     log('Error disposing old scroll controller: $e',
  //         name: 'ChaptersController');
  //   }

  //   itemsScrollController = ScrollController();
  //   log('ScrollController reset', name: 'ChaptersController');
  // }

  Future<void> loadChapters(String selectedChapterName, int bookNumber,
      {bool loadChapters = true}) async {
    try {
      isLoading = true;
      if (loadChapters) {
        final tocData = await booksCtrl.getTocs(bookNumber);
        if (chapters != tocData) {
          chapters = tocData
              .where((item) => item.text.isNotEmpty)
              .toList(); // تصفية الفصول الفارغة / Filter empty chapters
        }
      }

      // تحديد الفصل الحالي / Set current chapter
      currentChapterName = selectedChapterName;

      jumpToChapter();
    } catch (e) {
      log('Error loading chapters: $e', name: 'ChaptersController');
    } finally {
      isLoading = false;
      update(['ChapterName']);
    }
  }

  void jumpToChapter() {
    // العثور على الفصل الحالي في القائمة / Find current chapter in the list
    final currentChapterIndex = chapters.indexWhere(
      (chapter) => chapter.text == currentChapterName,
    );

    if (currentChapterIndex >= 0) {
      currentChapterItem = chapters[currentChapterIndex];
    }

    // تحديد الموضع الأولي للسكرول / Set initial scroll position
    final initialScrollOffset =
        currentChapterIndex >= 0 ? (currentChapterIndex * _itemHeight) : 0.0;

    // إنشاء ScrollController جديد مع الموضع الأولي فقط إذا لم يكن موجوداً / Create new ScrollController with initial position only if not exists
    if (!itemsScrollController.hasClients) {
      itemsScrollController = ScrollController(
        initialScrollOffset: initialScrollOffset,
      );
    } else {
      // إذا كان موجوداً، قم بالسكرول للموضع المطلوب / If exists, scroll to required position
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (itemsScrollController.hasClients && currentChapterIndex >= 0) {
          final targetOffset = _calculateScrollOffset(currentChapterIndex);
          itemsScrollController.jumpTo(targetOffset);
        }
      });
    }
    log('Chapters loaded: ${chapters.length}, current: $currentChapterName at index: $currentChapterIndex, initialOffset: $initialScrollOffset',
        name: 'ChaptersController');
  }

  @override
  void onClose() {
    // تنظيف الـ scroll controller / Clean up scroll controller
    try {
      itemsScrollController.dispose();
    } catch (e) {
      log('Error disposing scroll controller: $e', name: 'ChaptersController');
    }
    super.onClose();
  }
}

extension SplitBetweenExtension<T> on List<T> {
  List<List<T>> splitBetween(bool Function(T first, T second) condition) {
    if (isEmpty) return []; // إذا كانت القائمة فارغة، إرجاع قائمة فارغة.

    List<List<T>> result = []; // قائمة النتيجة التي ستحتوي على القوائم الفرعية.
    List<T> currentGroup = [first]; // المجموعة الحالية تبدأ بالعنصر الأول.

    for (int i = 1; i < length; i++) {
      if (condition(this[i - 1], this[i])) {
        // إذا تحقق الشرط، أضف المجموعة الحالية إلى النتيجة.
        result.add(currentGroup);
        currentGroup = []; // ابدأ مجموعة جديدة.
      }
      currentGroup.add(this[i]); // أضف العنصر الحالي إلى المجموعة.
    }

    if (currentGroup.isNotEmpty) {
      result.add(currentGroup); // أضف المجموعة الأخيرة.
    }

    return result;
  }
}
