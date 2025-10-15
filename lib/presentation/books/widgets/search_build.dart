part of '../books.dart';

class SearchBuild extends StatelessWidget {
  SearchBuild({super.key});

  final booksCtrl = BooksController.instance;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Obx(() {
        if (booksCtrl.state.isLoading.value) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        final downloadedBooks = kIsWeb
            ? booksCtrl.state.booksList
            : booksCtrl.state.booksList
                .where((book) => booksCtrl.isBookDownloaded(book.bookNumber))
                .toList();
        if (booksCtrl.state.searchResults.isNotEmpty) {
          return ListView.builder(
            itemCount: booksCtrl.state.searchResults.length,
            itemBuilder: (context, index) {
              final result = booksCtrl.state.searchResults[index];

              // محاولة الحصول على اسم الفصل - Try to get chapter name
              String? chapterName;

              // أولاً: تحميل جدول المحتويات إذا لم يكن محملاً - First: Load TOC if not loaded
              if (!booksCtrl.state.tocCache.containsKey(result.bookNumber)) {
                // تحميل جدول المحتويات بشكل غير متزامن - Load TOC asynchronously
                booksCtrl.getTocs(result.bookNumber).then((tocList) {
                  // لا نحتاج لفعل شيء هنا، البيانات ستُحفظ في الكاش
                  // No need to do anything here, data will be saved in cache
                });
                chapterName = 'downloading...'.tr; // Loading...
              } else {
                // الحصول على اسم الفصل من الكاش - Get chapter name from cache
                chapterName = booksCtrl.getCurrentChapterByPage(
                  result.bookNumber,
                  result.pageNumber,
                );
              }

              return Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final ctx = rootNavigatorKey.currentContext;
                      if (ctx != null) {
                        if (Get.currentRoute == '/ReadViewScreen') {
                          await booksCtrl.moveToPage(chapterName!,
                              result.bookNumber, result.pageNumber);
                        } else {
                          ctx.pop();
                          await booksCtrl.moveToBookPageByNumber(
                              result.pageNumber - 1,
                              result.bookNumber,
                              chapterName);
                        }
                      }

                      booksCtrl.state.searchResults.clear();
                      booksCtrl.state.searchController.clear();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: context.theme.colorScheme.primary
                            .withValues(alpha: .1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        children: [
                          _textResultBuild(result, context),
                          // معلومات البحث: اسم الكتاب، الفصل، رقم الصفحة - Search info: book name, chapter, page number
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                // اسم الكتاب - Book name
                                _bookNameBuild(context, result),
                                const Gap(4),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // اسم الفصل - Chapter name
                                    _chapterNameBuild(context, chapterName),
                                    const Gap(4),
                                    // رقم الصفحة - Page number
                                    _pageNumberBuild(context, result),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  context.hDivider(width: MediaQuery.sizeOf(context).width)
                ],
              );
            },
          );
        } else {
          return !(Get.currentRoute == '/ReadViewScreen')
              ? Center(
                  child: downloadedBooks.isEmpty
                      ? Column(
                          children: [
                            const Gap(64),
                            customSvg(
                              SvgPath.svgBooksIconIslamicLibraryIcon,
                              height: 100,
                            ),
                            const Gap(16),
                            Text(
                              'noBooksDownloaded'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: context.theme.colorScheme.surface,
                                  fontFamily: 'cairo',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            const Gap(64),
                          ],
                        )
                      : notFound(),
                )
              : const SizedBox.shrink();
        }
      }),
    );
  }

  Expanded _pageNumberBuild(BuildContext context, PageContent result) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.surface.withValues(alpha: .5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          '${'page'.tr} ${result.pageNumber}',
          style: TextStyle(
            fontFamily: "cairo",
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: context.theme.colorScheme.inversePrimary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Expanded _chapterNameBuild(BuildContext context, String? chapterName) {
    return Expanded(
      flex: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.onPrimary.withValues(alpha: .3),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          chapterName ?? 'غير محدد',
          style: TextStyle(
            fontFamily: "cairo",
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: context.theme.colorScheme.inversePrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _bookNameBuild(BuildContext context, PageContent result) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primary.withValues(alpha: .3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        booksCtrl.state.booksList[result.bookNumber - 1].bookName,
        style: TextStyle(
          fontFamily: "cairo",
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: context.theme.colorScheme.inversePrimary,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }

  Padding _textResultBuild(PageContent result, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text.rich(
        TextSpan(
          children: result.text
              .buildTextSpans(context.theme.colorScheme.inversePrimary)
              .highlightSearchText(booksCtrl.state.searchController.text),
          style: TextStyle(
            fontFamily: "naskh",
            fontWeight: FontWeight.normal,
            fontSize: 22,
            color: context.theme.colorScheme.inversePrimary,
          ),
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
