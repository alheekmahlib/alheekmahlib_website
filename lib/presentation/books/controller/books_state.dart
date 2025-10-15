part of '../books.dart';

class BooksState {
  /// -------- [Variables] ----------
  final box = GetStorage();
  var booksList = <Book>[].obs;
  var isLoading = true.obs;
  var downloading = <int, bool>{}.obs;
  var downloaded = <int, bool>{}.obs;
  var downloadProgress = <int, double>{}.obs;
  var searchResults = <PageContent>[].obs;
  RxBool isDownloaded = false.obs;
  final TextEditingController searchController = TextEditingController();
  PageController bookPageController = PageController();
  final FocusNode bookRLFocusNode = FocusNode();
  // final FocusNode bookUDFocusNode = FocusNode();
  // final ScrollController ScrollUpDownBook = ScrollController();
  RxInt currentPageNumber = 0.obs;
  var lastReadPage = <int, int>{}.obs;
  Map<int, int> bookTotalPages = {};
  RxBool isTashkil = true.obs;
  var collapsedHeightMap = <int, RxBool>{}.obs;
  RxBool isShowControl = false.obs;
  // RxInt backgroundPickerColor = 0xfffaf7f3.obs;
  // RxInt temporaryBackgroundColor = 0xfffaf7f3.obs;

  // كاش لحفظ جدول المحتويات - Cache for table of contents
  Map<int, List<TocItem>> tocCache = {};
  RxBool isSearch = false.obs;
  RxString searchQuery = ''.obs; // نص البحث - Search query text
  late Directory dir;

  // تحميل تدريجي لقوائم الكتب - Infinite scroll state
  int batchSize = 60;
  RxInt visibleCountAll = 60.obs;
  RxInt visibleCountHadiths = 60.obs;
  RxInt visibleCountTafsir = 60.obs;
  RxInt visibleCountDownloaded = 60.obs;

  RxBool pagingBusyAll = false.obs;
  RxBool pagingBusyHadiths = false.obs;
  RxBool pagingBusyTafsir = false.obs;
  RxBool pagingBusyDownloaded = false.obs;

  // آخر إجمالي عناصر لكل نوع قائمة
  Map<String, int> lastListTotals = {};
}
