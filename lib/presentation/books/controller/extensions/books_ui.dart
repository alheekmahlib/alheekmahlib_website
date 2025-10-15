part of '../../books.dart';

extension BooksUi on BooksController {
  /// -------- [onTap] --------
  Future<void> moveToBookPage(String chapterName, int bookNumber) async {
    if (kIsWeb || isBookDownloaded(bookNumber)) {
      int initialPage = await getTocItemStartPage(bookNumber, chapterName);
      log('Initial page for $chapterName in book $bookNumber: $initialPage');
      state.currentPageNumber.value = initialPage + 1;
      // بعد اختيار فصل، افتح شاشة القراءة
      final ctx = rootNavigatorKey.currentContext;
      if (ctx != null) {
        // استخدم ?page= للتمرير كصفحة 1-based لسهولة المشاركة
        final sharePage = (initialPage + 1).clamp(1, 1 << 20);
        ctx.go('/books/read/$bookNumber?page=$sharePage');
      }
    } else {
      rootNavigatorKey.currentContext
          ?.showCustomErrorSnackBar('downloadBookFirst'.tr);
    }
  }

  Future<void> moveToPage(String chapterName, int bookNumber,
      [int? pageNumber]) async {
    if (pageNumber == null) {
      final initialPage = await getTocItemStartPage(bookNumber, chapterName);
      state.currentPageNumber.value = initialPage - 1;
      state.bookPageController.jumpToPage(initialPage - 1);
    } else {
      state.currentPageNumber.value = pageNumber - 1;
      state.bookPageController.jumpToPage(pageNumber - 1);
    }
    ChaptersController.instance.loadChapters(chapterName, bookNumber);
    // if (isBookDownloaded(bookNumber)) {
    // } else {
    //   Get.context!.showCustomErrorSnackBar('downloadBookFirst'.tr);
    // }
  }

  // التنقل إلى صفحة محددة بالرقم - Navigate to specific page by number
  Future<void> moveToBookPageByNumber(int pageNumber, int bookNumber,
      [String? chapterName]) async {
    if (kIsWeb || isBookDownloaded(bookNumber)) {
      state.currentPageNumber.value = pageNumber;
      await ChaptersController.instance.loadChapters(
          chapterName ?? (await getChapterNameByPage(bookNumber, pageNumber))!,
          bookNumber,
          loadChapters: false);
      // افتح شاشة القراءة عند التنقل لصفحة برقم
      final ctx = rootNavigatorKey.currentContext;
      if (ctx != null) {
        final sharePage = (pageNumber + 1).clamp(1, 1 << 20);
        ctx.go('/books/read/$bookNumber?page=$sharePage');
      }
    } else {
      rootNavigatorKey.currentContext
          ?.showCustomErrorSnackBar('downloadBookFirst'.tr);
    }
  }

  Future<void> moveToPageByNumber(int pageNumber, int bookNumber) async {
    if (kIsWeb || isBookDownloaded(bookNumber)) {
      state.currentPageNumber.value = pageNumber;
      state.bookPageController.animateToPage(pageNumber,
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      rootNavigatorKey.currentContext
          ?.showCustomErrorSnackBar('downloadBookFirst'.tr);
    }
  }

  void isTashkilOnTap() {
    state.isTashkil.value = !state.isTashkil.value;
    state.box.write(IS_TASHKIL, state.isTashkil.value);
  }

  KeyEventResult controlRLByKeyboard(FocusNode node, KeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      state.bookPageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      return KeyEventResult.handled;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      state.bookPageController.previousPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  List<Book> getCustomBookNumber(List<Book> allBooks, List<int> bookType) {
    // فلترة وترتيب كتب الأحاديث المهمة حسب ترتيب sixthBooksNumbers - Filter and sort priority hadith books according to sixthBooksNumbers order
    final priorityBooks = <Book>[];

    // ترتيب الكتب حسب نفس ترتيب الأرقام في sixthBooksNumbers - Sort books according to the same order as numbers in sixthBooksNumbers
    for (int bookNumber in bookType) {
      final book =
          allBooks.firstWhereOrNull((book) => book.bookNumber == bookNumber);
      if (book != null) {
        priorityBooks.add(book);
      }
    }
    return priorityBooks;
  }

  // KeyEventResult controlUDByKeyboard(FocusNode node, KeyEvent event) {
  //   if (state.ScrollUpDownBook.hasClients) {
  //     if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
  //       state.ScrollUpDownBook.animateTo(
  //         state.ScrollUpDownBook.offset - 100,
  //         duration: const Duration(milliseconds: 600),
  //         curve: Curves.easeInOut,
  //       );
  //       return KeyEventResult.handled;
  //     } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
  //       state.ScrollUpDownBook.animateTo(
  //         state.ScrollUpDownBook.offset + 100,
  //         duration: const Duration(milliseconds: 600),
  //         curve: Curves.easeInOut,
  //       );
  //       return KeyEventResult.handled;
  //     }
  //   }
  //   return KeyEventResult.ignored;
  // }
}
