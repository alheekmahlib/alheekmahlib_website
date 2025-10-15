part of '../books.dart';

class BooksController extends GetxController {
  static BooksController get instance =>
      GetInstance().putOrFind(() => BooksController());

  BooksState state = BooksState();

  @override
  void onInit() {
    super.onInit();
    fetchBooks().then((_) {
      loadLastRead();
    });
    loadFromGetStorage();

    // مراقبة تغيير نص البحث - Monitor search text changes
    ever(state.searchQuery, (searchQuery) {
      if (searchQuery.isEmpty) {
        state.isSearch.value = false;
      } else {
        state.isSearch.value = true;
      }
    });
  }

  @override
  void onClose() {
    state.bookPageController.dispose();
    // state.ScrollUpDownBook.dispose();
    state.bookRLFocusNode.dispose();
    // state.bookUDFocusNode.dispose();
    state.searchController
        .dispose(); // تنظيف مُتحكم البحث - Clean up search controller
    super.onClose();
  }

  /// -------- [Methods] ----------

  Future<void> fetchBooks() async {
    try {
      state.isLoading(true);
      String jsonString =
          await rootBundle.loadString('assets/json/collections.json');
      var booksJson = json.decode(jsonString) as List;
      state.booksList.value =
          booksJson.map((book) => Book.fromJson(book)).toList();
      log('Books loaded: ${state.booksList.length}', name: 'BooksController');
      loadDownloadedBooks();
    } catch (e) {
      log('Error fetching books: $e', name: 'BooksController');
    } finally {
      state.isLoading(false);
    }
  }

  /// ----- تحميل تدريجي لشبكات الكتب (infinite scroll) -----
  void resetPaging({required String listKey}) {
    switch (listKey) {
      case 'all':
        state.visibleCountAll.value = state.batchSize;
        break;
      case 'hadiths':
        state.visibleCountHadiths.value = state.batchSize;
        break;
      case 'tafsir':
        state.visibleCountTafsir.value = state.batchSize;
        break;
      case 'downloaded':
        state.visibleCountDownloaded.value = state.batchSize;
        break;
    }
  }

  void loadMore({required String listKey, required int total}) {
    // لا نحمّل أكثر أثناء البحث
    if (state.isSearch.value) return;

    final int step = state.batchSize;
    switch (listKey) {
      case 'all':
        if (state.pagingBusyAll.value) return;
        if (state.visibleCountAll.value >= total) return;
        state.pagingBusyAll.value = true;
        Future.microtask(() {
          state.visibleCountAll.value =
              (state.visibleCountAll.value + step).clamp(0, total);
          state.pagingBusyAll.value = false;
        });
        break;
      case 'hadiths':
        if (state.pagingBusyHadiths.value) return;
        if (state.visibleCountHadiths.value >= total) return;
        state.pagingBusyHadiths.value = true;
        Future.microtask(() {
          state.visibleCountHadiths.value =
              (state.visibleCountHadiths.value + step).clamp(0, total);
          state.pagingBusyHadiths.value = false;
        });
        break;
      case 'tafsir':
        if (state.pagingBusyTafsir.value) return;
        if (state.visibleCountTafsir.value >= total) return;
        state.pagingBusyTafsir.value = true;
        Future.microtask(() {
          state.visibleCountTafsir.value =
              (state.visibleCountTafsir.value + step).clamp(0, total);
          state.pagingBusyTafsir.value = false;
        });
        break;
      case 'downloaded':
        if (state.pagingBusyDownloaded.value) return;
        if (state.visibleCountDownloaded.value >= total) return;
        state.pagingBusyDownloaded.value = true;
        Future.microtask(() {
          state.visibleCountDownloaded.value =
              (state.visibleCountDownloaded.value + step).clamp(0, total);
          state.pagingBusyDownloaded.value = false;
        });
        break;
    }
  }

  // التحقق من تحميل الكتاب - Check if book is downloaded
  bool isBookDownloaded(int bookNumber) =>
      kIsWeb ? true : (state.downloaded[bookNumber] ?? false);

  // الحصول على أجزاء الكتاب - Get book volumes
  Future<List<Volume>> getVolumes(int bookNumber) async {
    try {
      if (kIsWeb) {
        // على الويب: جلب مباشر من GitHub لتفادي طلب الأصول
        final url =
            'https://raw.githubusercontent.com/alheekmahlib/zad_library/main/${bookNumber.toString().padLeft(3, '0')}.json';
        try {
          final response = await Dio().get(url);
          var bookJson = response.data is String
              ? json.decode(response.data)
              : response.data;
          if (bookJson is List && bookJson.isNotEmpty) {
            bookJson = bookJson.first;
          }
          if (bookJson is Map &&
              bookJson.containsKey('info') &&
              bookJson['info'].containsKey('volumes')) {
            Map<String, dynamic> volumesData = bookJson['info']['volumes'];
            var volumes = volumesData.entries
                .map((entry) =>
                    Volume.fromJson(entry.key, List<int>.from(entry.value)))
                .toList();
            return volumes;
          }
        } catch (_) {}
        return [];
      } else {
        // على المنصات الأخرى: جرّب الأصول ثم الملفات المحلية
        try {
          String jsonString =
              await rootBundle.loadString('assets/json/$bookNumber.json');
          var bookJson = json.decode(jsonString);
          if (bookJson is List && bookJson.isNotEmpty) {
            bookJson = bookJson.first;
          }
          if (bookJson.containsKey('info') &&
              bookJson['info'].containsKey('volumes')) {
            Map<String, dynamic> volumesData = bookJson['info']['volumes'];
            var volumes = volumesData.entries
                .map((entry) =>
                    Volume.fromJson(entry.key, List<int>.from(entry.value)))
                .toList();
            return volumes;
          }
        } catch (_) {
          final file = File('${state.dir.path}/$bookNumber.json');
          if (await file.exists()) {
            String jsonString = await file.readAsString();
            var bookJson = json.decode(jsonString);
            if (bookJson is List && bookJson.isNotEmpty) {
              bookJson = bookJson.first;
            }
            if (bookJson.containsKey('info') &&
                bookJson['info'].containsKey('volumes')) {
              Map<String, dynamic> volumesData = bookJson['info']['volumes'];
              var volumes = volumesData.entries
                  .map((entry) =>
                      Volume.fromJson(entry.key, List<int>.from(entry.value)))
                  .toList();
              return volumes;
            }
          }
        }
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // الحصول على جدول المحتويات - Get table of contents
  Future<List<TocItem>> getTocs(int bookNumber) async {
    try {
      // التحقق من الكاش أولاً - Check cache first
      if (state.tocCache.containsKey(bookNumber)) {
        return state.tocCache[bookNumber]!;
      }
      if (kIsWeb) {
        final url =
            'https://raw.githubusercontent.com/alheekmahlib/zad_library/main/${bookNumber.toString().padLeft(3, '0')}.json';
        try {
          final response = await Dio().get(url);
          var bookJson = response.data is String
              ? json.decode(response.data)
              : response.data;
          if (bookJson is List && bookJson.isNotEmpty) {
            bookJson = bookJson.first;
          }
          if (bookJson is Map &&
              bookJson.containsKey('info') &&
              bookJson['info'].containsKey('toc')) {
            var tocData = bookJson['info']['toc'];
            var flatToc = _flattenToc(tocData);
            state.tocCache[bookNumber] = flatToc;
            return flatToc;
          }
        } catch (_) {}
        return [];
      } else {
        try {
          String jsonString =
              await rootBundle.loadString('assets/json/$bookNumber.json');
          var bookJson = json.decode(jsonString);
          if (bookJson is List && bookJson.isNotEmpty) {
            bookJson = bookJson.first;
          }
          if (bookJson.containsKey('info') &&
              bookJson['info'].containsKey('toc')) {
            var tocData = bookJson['info']['toc'];
            var flatToc = _flattenToc(tocData);
            state.tocCache[bookNumber] = flatToc;
            return flatToc;
          }
        } catch (_) {
          final file = File('${state.dir.path}/$bookNumber.json');
          if (await file.exists()) {
            String jsonString = await file.readAsString();
            var bookJson = json.decode(jsonString);
            if (bookJson is List && bookJson.isNotEmpty) {
              bookJson = bookJson.first;
            }
            if (bookJson.containsKey('info') &&
                bookJson['info'].containsKey('toc')) {
              var tocData = bookJson['info']['toc'];
              var flatToc = _flattenToc(tocData);
              state.tocCache[bookNumber] = flatToc;
              return flatToc;
            }
          }
        }
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // دالة مساعدة لتسطيح جدول المحتويات المتداخل - Helper function to flatten nested TOC
  List<TocItem> _flattenToc(dynamic tocData) {
    List<TocItem> result = [];

    if (tocData is List) {
      for (var item in tocData) {
        if (item is Map<String, dynamic>) {
          // عنصر TOC مباشر - Direct TOC item
          if (item.containsKey('text') && item.containsKey('page')) {
            result.add(TocItem.fromJson(item));
          }
        } else if (item is List) {
          // قائمة متداخلة - Nested list
          result.addAll(_flattenToc(item));
        }
      }
    }

    return result;
  }

  // العثور على رقم الصفحة الأولى لعنصر في جدول المحتويات - Find start page for TOC item
  Future<int> getTocItemStartPage(int bookNumber, String itemText) async {
    try {
      if (kIsWeb) {
        final url =
            'https://raw.githubusercontent.com/alheekmahlib/zad_library/main/${bookNumber.toString().padLeft(3, '0')}.json';
        try {
          final response = await Dio().get(url);
          var bookJson = response.data is String
              ? json.decode(response.data)
              : response.data;
          if (bookJson is List && bookJson.isNotEmpty) {
            bookJson = bookJson.first;
          }
          if (bookJson is Map &&
              bookJson.containsKey('info') &&
              bookJson['info'].containsKey('toc')) {
            return _findPageInToc(bookJson['info']['toc'], itemText);
          }
        } catch (_) {}
      } else {
        try {
          String jsonString =
              await rootBundle.loadString('assets/json/$bookNumber.json');
          var bookJson = json.decode(jsonString);
          if (bookJson is List && bookJson.isNotEmpty) {
            bookJson = bookJson.first;
          }
          if (bookJson.containsKey('info') &&
              bookJson['info'].containsKey('toc')) {
            return _findPageInToc(bookJson['info']['toc'], itemText);
          }
        } catch (_) {
          final file = File('${state.dir.path}/$bookNumber.json');
          if (await file.exists()) {
            String jsonString = await file.readAsString();
            var bookJson = json.decode(jsonString);
            if (bookJson is List && bookJson.isNotEmpty) {
              bookJson = bookJson.first;
            }
            if (bookJson.containsKey('info') &&
                bookJson['info'].containsKey('toc')) {
              return _findPageInToc(bookJson['info']['toc'], itemText);
            }
          }
        }
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  // دالة مساعدة للبحث في جدول المحتويات - Helper function to search in TOC
  int _findPageInToc(dynamic toc, String searchText) {
    if (toc is List) {
      for (var item in toc) {
        if (item is Map<String, dynamic>) {
          String itemText = item['text'] ?? '';
          int itemPage = item['page'] ?? 0;

          // تنظيف النصوص من المسافات والأحرف الخاصة - Clean texts from spaces and special characters
          String normalizedItemText = _normalizeText(itemText);
          String normalizedSearchText = _normalizeText(searchText);

          // مقارنة النصوص المنظفة - Compare cleaned texts
          if (normalizedItemText == normalizedSearchText) {
            return itemPage;
          }

          // مقارنة جزئية للنصوص الطويلة - Partial comparison for long texts
          if (normalizedItemText.isNotEmpty &&
              normalizedSearchText.isNotEmpty) {
            if (normalizedItemText.contains(normalizedSearchText) ||
                normalizedSearchText.contains(normalizedItemText)) {
              return itemPage;
            }
          }
        } else if (item is List) {
          int result = _findPageInToc(item, searchText);
          if (result > 0) return result;
        }
      }
    }
    return 0;
  }

  // دالة مساعدة لتنظيف النص - Helper function to normalize text
  String _normalizeText(String text) {
    return text
        .trim() // إزالة المسافات من البداية والنهاية
        .replaceAll(RegExp(r'\s+'), ' ') // توحيد المسافات
        .replaceAll(
            RegExp(
                r'[^\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF\s\w\d:،.]'),
            '') // إزالة الأحرف الخاصة والاحتفاظ بالعربية والإنجليزية والأرقام
        .toLowerCase(); // تحويل للأحرف الصغيرة
  }

  Future<List<PageContent>> getPages(int bookNumber) async {
    try {
      if (kIsWeb) {
        final url =
            'https://raw.githubusercontent.com/alheekmahlib/zad_library/main/${bookNumber.toString().padLeft(3, '0')}.json';
        try {
          final response = await Dio().get(url);
          var bookJson = response.data is String
              ? json.decode(response.data)
              : response.data;
          if (bookJson is List && bookJson.isNotEmpty) {
            bookJson = bookJson.first;
          }
          String bookTitle = '';
          if (bookJson is Map &&
              bookJson.containsKey('info') &&
              bookJson['info'].containsKey('title')) {
            bookTitle = bookJson['info']['title'];
          }
          if (bookJson is Map && bookJson.containsKey('pages')) {
            var pages = bookJson['pages'] as List<dynamic>;
            return pages
                .map(
                    (page) => PageContent.fromJson(page, bookTitle, bookNumber))
                .toList();
          }
        } catch (_) {}
        return [];
      } else {
        try {
          String jsonString =
              await rootBundle.loadString('assets/json/$bookNumber.json');
          var bookJson = json.decode(jsonString);
          if (bookJson is List && bookJson.isNotEmpty) {
            bookJson = bookJson.first;
          }
          String bookTitle = '';
          if (bookJson.containsKey('info') &&
              bookJson['info'].containsKey('title')) {
            bookTitle = bookJson['info']['title'];
          }
          if (bookJson.containsKey('pages')) {
            var pages = bookJson['pages'] as List<dynamic>;
            return pages
                .map(
                    (page) => PageContent.fromJson(page, bookTitle, bookNumber))
                .toList();
          } else {
            return [];
          }
        } catch (_) {
          final file = File('${state.dir.path}/$bookNumber.json');
          if (await file.exists()) {
            String jsonString = await file.readAsString();
            var bookJson = json.decode(jsonString);
            if (bookJson is List && bookJson.isNotEmpty) {
              bookJson = bookJson.first;
            }
            String bookTitle = '';
            if (bookJson.containsKey('info') &&
                bookJson['info'].containsKey('title')) {
              bookTitle = bookJson['info']['title'];
            }
            if (bookJson.containsKey('pages')) {
              var pages = bookJson['pages'] as List<dynamic>;
              return pages
                  .map((page) =>
                      PageContent.fromJson(page, bookTitle, bookNumber))
                  .toList();
            } else {
              return [];
            }
          } else {
            return [];
          }
        }
      }
    } catch (e) {
      return [];
    }
  }

  // البحث في النص - Search in text
  // بحث بسيط ودقيق في الكتب المحملة
  void searchBooks(String query, {int? bookNumber}) async {
    // مسح النتائج السابقة - Clear previous results
    state.searchResults.clear();
    if (query.isEmpty || query.trim().length < 2) {
      return;
    }

    log('Starting search for: $query', name: 'BooksController_Search');

    // تنظيف النص المراد البحث عنه - Clean search query

    String cleanQuery = (query);
    // String cleanQuery = (query.searchRemoveDiacritics(query));
    cleanQuery = cleanQuery.trim().toLowerCase();
    cleanQuery = cleanQuery.searchRemoveDiacritics(cleanQuery);
    log(cleanQuery, name: 'CleanQuery');

    // تحديد الكتب التي سيتم البحث فيها - Determine books to search in
    List<Book> booksToSearch;
    if (bookNumber != null) {
      // البحث في كتاب محدد إذا كان محملاً - Search in specific book if downloaded
      booksToSearch = state.booksList
          .where((book) => book.bookNumber == bookNumber)
          .toList();
    } else {
      // البحث في جميع الكتب المحملة - Search in all downloaded books
      booksToSearch = kIsWeb
          ? state.booksList.toList()
          : state.booksList
              .where((book) => isBookDownloaded(book.bookNumber))
              .toList();
    }

    // التحقق من وجود كتب للبحث فيها - Check if there are books to search
    if (booksToSearch.isEmpty) {
      log('No downloaded books found for search', name: 'BooksController');
      return;
    }

    log('Searching in ${booksToSearch.length} books', name: 'BooksController');

    // البحث في كل كتاب - Search in each book
    for (var book in booksToSearch) {
      // تحميل جدول المحتويات مسبقاً إذا لم يكن محملاً - Load TOC beforehand if not loaded
      if (!state.tocCache.containsKey(book.bookNumber)) {
        await getTocs(book.bookNumber);
      }

      final pages = await getPages(book.bookNumber);
      for (var page in pages) {
        // تنظيف النص من HTML وإزالة التشكيل - Clean text from HTML and remove diacritics
        String cleanPageText = _cleanTextForSearch(page.text);

        // البحث البسيط: هل النص يحتوي على الكلمة المراد البحث عنها؟
        // Simple search: does the text contain the search query?
        if (cleanPageText.contains(cleanQuery)) {
          // إنشاء مقتطف من النص مع السياق - Create text snippet with context
          String snippet = _createSimpleTextSnippet(page.text, query);

          // إنشاء نسخة معدلة من الصفحة مع المقتطف - Create modified page with snippet
          PageContent snippetPage = PageContent(
            text: snippet,
            pageNumber: page.pageNumber,
            page: page.page,
            bookTitle: page.bookTitle,
            bookNumber: page.bookNumber,
          );

          state.searchResults.add(snippetPage);
        }
      }
    }

    log('Search completed. Total matches: ${state.searchResults.length}',
        name: 'BooksController_Search');
  }

  // دالة تنظيف النص للبحث - Clean text for search
  String _cleanTextForSearch(String text) {
    // إزالة HTML tags
    String cleanText = text.replaceAll(RegExp(r'<[^>]*>'), ' ');

    // إزالة التشكيل والأحرف الخاصة - Remove diacritics and special characters
    cleanText =
        cleanText.replaceAll(RegExp(r'[َُِّْٰٖٕٗٓۖۗۘۙۚۛۜ۝۞ًٌٍ۟۠ۡۢ]'), '');

    // توحيد المسافات - Normalize spaces
    cleanText = cleanText.replaceAll(RegExp(r'\s+'), ' ');

    // تحويل للأحرف الصغيرة - Convert to lowercase
    cleanText = cleanText.trim().toLowerCase();
    cleanText = cleanText.searchRemoveDiacritics(cleanText);
    return cleanText;
  }

  // دالة إنشاء مقتطف بسيط من النص - Create simple text snippet
  String _createSimpleTextSnippet(String text, String query) {
    // تنظيف النص - Clean text
    String cleanText = text.replaceAll(RegExp(r'<[^>]*>'), ' ');
    cleanText = cleanText.replaceAll(RegExp(r'\s+'), ' ').trim();
    // cleanText = cleanText.searchRemoveDiacritics(cleanText);

    // تقسيم النص إلى كلمات - Split text into words
    List<String> words = cleanText.split(' ');

    // البحث عن موقع أول ظهور للكلمة - Find first occurrence of the word
    String queryLower = query.toLowerCase();
    int matchIndex = -1;

    for (int i = 0; i < words.length; i++) {
      String wordLower = words[i].toLowerCase();
      // إزالة التشكيل من الكلمة للمقارنة - Remove diacritics from word for comparison
      String cleanWord =
          wordLower.replaceAll(RegExp(r'[َُِّْٰٖٕٗٓۖۗۘۙۚۛۜ۝۞ًٌٍ۟۠ۡۢ]'), '');

      if (cleanWord.contains(queryLower)) {
        matchIndex = i;
        break;
      }
    }

    // إذا لم نجد تطابق، أرجع أول 30 كلمة - If no match found, return first 30 words
    if (matchIndex == -1) {
      int endIndex = words.length > 30 ? 30 : words.length;
      return words.sublist(0, endIndex).join(' ') +
          (words.length > 30 ? '...' : '');
    }

    // تحديد نطاق الكلمات (15 قبل و15 بعد) - Define word range (15 before and 15 after)
    int startIndex = (matchIndex - 15).clamp(0, words.length);
    int endIndex = (matchIndex + 15).clamp(0, words.length);

    // إنشاء المقتطف - Create snippet
    String snippet = '';

    // إضافة نقاط إذا كان البداية ليست من أول النص - Add dots if not starting from beginning
    if (startIndex > 0) {
      snippet += '...';
    }

    // إضافة الكلمات المحددة - Add selected words
    snippet += words.sublist(startIndex, endIndex).join(' ');

    // إضافة نقاط إذا كان النهاية ليست آخر النص - Add dots if not ending at text end
    if (endIndex < words.length) {
      snippet += '...';
    }

    return snippet;
  }

  // البحث في أسماء الكتب - Search in book names
  void searchBookNames(String query) {
    state.searchQuery.value = query;
    log('Searching book names with query: $query', name: 'BooksController');
  }

  // فلترة الكتب حسب البحث والفئة - Filter books by search and category
  List<Book> getFilteredBooks(
    List<Book> booksList, {
    bool isDownloadedBooks = false,
    bool isHadithsBooks = false,
    bool isTafsirBooks = false,
    String title = '',
  }) {
    // تطبيق فلترة الفئة أولاً - Apply category filter first
    List<Book> filteredBooks = isDownloadedBooks
        ? (kIsWeb
            ? booksList.toList()
            : booksList
                .where((book) => state.downloaded[book.bookNumber] == true)
                .toList())
        : isHadithsBooks || isTafsirBooks
            ? booksList.where((book) => book.bookType == title).toList()
            : booksList;

    // تطبيق فلترة البحث - Apply search filter
    if (state.searchQuery.value.isNotEmpty) {
      String searchQueryLower = state.searchQuery.value.toLowerCase();
      filteredBooks = filteredBooks.where((book) {
        return book.bookName.toLowerCase().contains(searchQueryLower) ||
            book.bookFullName.toLowerCase().contains(searchQueryLower) ||
            book.author.toLowerCase().contains(searchQueryLower);
      }).toList();
    }

    // ترتيب كتب الأحاديث لجعل sixthBooksNumbers في البداية - Sort hadith books to put sixthBooksNumbers first
    if (isHadithsBooks) {
      List<Book> priorityBooks = [];
      List<Book> otherBooks = [];

      for (Book book in filteredBooks) {
        if (sixthBooksNumbers.contains(book.bookNumber)) {
          priorityBooks.add(book);
        } else {
          otherBooks.add(book);
        }
      }

      filteredBooks = [...priorityBooks, ...otherBooks];
    }

    return filteredBooks;
  }

  // الحصول على حالة ارتفاع النص المطوي - Get collapsed height state
  RxBool collapsedHeight(int bookNumber) {
    if (!state.collapsedHeightMap.containsKey(bookNumber)) {
      state.collapsedHeightMap[bookNumber] = false.obs;
    }
    return state.collapsedHeightMap[bookNumber]!;
  }
}
