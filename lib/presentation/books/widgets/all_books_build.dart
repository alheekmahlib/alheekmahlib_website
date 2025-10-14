part of '../books.dart';

class AllBooksBuild extends StatelessWidget {
  final bool? isDownloadedBooks;
  final bool? isHadithsBooks;
  final bool? isTafsirBooks;
  final String title;
  AllBooksBuild({
    super.key,
    this.isDownloadedBooks = false,
    required this.title,
    this.isHadithsBooks = false,
    this.isTafsirBooks = false,
  });

  final booksCtrl = BooksController.instance;

  String get _listKey => isDownloadedBooks == true
      ? 'downloaded'
      : (isHadithsBooks == true
          ? 'hadiths'
          : (isTafsirBooks == true ? 'tafsir' : 'all'));

  int _visibleForKey() {
    switch (_listKey) {
      case 'downloaded':
        return booksCtrl.state.visibleCountDownloaded.value;
      case 'hadiths':
        return booksCtrl.state.visibleCountHadiths.value;
      case 'tafsir':
        return booksCtrl.state.visibleCountTafsir.value;
      default:
        return booksCtrl.state.visibleCountAll.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (booksCtrl.state.isSearch.value) return false;
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 400) {
          // احسب إجمالي القائمة الحالية لتمريره للكنترولر
          final allBooks = booksCtrl.getFilteredBooks(
            booksCtrl.state.booksList,
            isDownloadedBooks: isDownloadedBooks!,
            isHadithsBooks: isHadithsBooks!,
            isTafsirBooks: isTafsirBooks!,
            title: title,
          );
          booksCtrl.loadMore(listKey: _listKey, total: allBooks.length);
        }
        return false;
      },
      child: ListView(
        children: [
          Hero(
            tag: 'lastReadBooks',
            child: BooksLastRead(
              horizontalMargin: 32.0,
              horizontalPadding: 0.0,
              verticalMargin: 16.0,
            ),
          ),
          FutureBuilder<void>(
            future: booksCtrl.state.booksList.isEmpty
                ? booksCtrl.fetchBooks()
                : Future.value(),
            builder: (context, snapshot) {
              return const SizedBox.shrink();
            },
          ),
          Obx(() {
            if (booksCtrl.state.isLoading.value) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            final allBooks = booksCtrl.getFilteredBooks(
              booksCtrl.state.booksList,
              isDownloadedBooks: isDownloadedBooks!,
              isHadithsBooks: isHadithsBooks!,
              isTafsirBooks: isTafsirBooks!,
              title: title,
            );

            return Container(
              width: MediaQuery.sizeOf(context).width,
              margin: const EdgeInsets.symmetric(horizontal: 32.0),
              decoration: BoxDecoration(
                color: context.theme.colorScheme.primary.withValues(alpha: .2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: context.theme.colorScheme.primary,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.sizeOf(context).width,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.primary
                          .withValues(alpha: .5),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title.tr,
                          style: TextStyle(
                            color: context.theme.colorScheme.onPrimary,
                            fontFamily: 'cairo',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        _searchBuild(context),
                      ],
                    ),
                  ),
                  const Gap(4),
                  allBooks.isEmpty
                      ? Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Gap(64),
                            const SizedBox().customSvg(
                              isDownloadedBooks!
                                  ? SvgPath.svgBooksIconMyLibraryIcon
                                  : isHadithsBooks!
                                      ? SvgPath.svgBooksIconHadithIcon
                                      : isTafsirBooks!
                                          ? SvgPath.svgBooksIconTafsirIcon
                                          : SvgPath.svgBooksIconAllBooksIcon,
                              height: 50,
                            ),
                            const Gap(16),
                            Text(
                              booksCtrl.state.searchQuery.value.isNotEmpty
                                  ? 'noBooksFoundForSearch'.tr
                                  : _getEmptyStateMessage(),
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'cairo',
                                color: context.theme.canvasColor,
                              ),
                            ),
                            const Gap(64),
                          ],
                        )
                      : Column(
                          children: [
                            if (isHadithsBooks == true) ...[
                              _buildSixthBooksSection(context, allBooks, true),
                              const Gap(8),
                              _buildSixthBooksSection(context, allBooks, false),
                              const Gap(8),
                            ],
                            _buildRegularBooksSection(allBooks),
                          ],
                        ),
                ],
              ),
            );
          }),
          const Gap(64),
        ],
      ),
    );
  }

  String _getEmptyStateMessage() {
    if (isDownloadedBooks == true) {
      return 'noBooksDownloaded'.tr;
    } else if (isHadithsBooks == true) {
      return 'noHadithBooks'.tr;
    } else if (isTafsirBooks == true) {
      return 'noTafsirBooks'.tr;
    } else {
      return 'noBooks'.tr;
    }
  }

  SizedBox _searchBuild(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.sizeOf(context).width * .6,
      child: AnimatedSearchBar(
        height: 40,
        textInputAction: TextInputAction.search,
        closeIcon: const SizedBox().customSvgWithColor(
          SvgPath.svgClose,
          color: context.theme.colorScheme.onPrimary,
          width: 25,
          height: 25,
        ),
        searchIcon: const SizedBox().customSvgWithColor(
          SvgPath.svgSearchIcon,
          color: context.theme.colorScheme.onPrimary,
          width: 35,
          height: 35,
        ),
        searchDecoration: InputDecoration(
          hintText: 'search'.tr,
          hintStyle: TextStyle(
            color: context.theme.colorScheme.onPrimary.withValues(alpha: .5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: context.theme.colorScheme.onPrimary.withValues(alpha: .5),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: context.theme.colorScheme.onPrimary.withValues(alpha: .5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: context.theme.colorScheme.onPrimary.withValues(alpha: .5),
            ),
          ),
          constraints: const BoxConstraints(maxHeight: 40.0),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        ),
        searchStyle: TextStyle(
          color: context.theme.colorScheme.onPrimary,
          fontSize: 16.0,
          fontFamily: 'naskh',
        ),
        onClose: () {
          booksCtrl.state.isSearch.value = false;
          booksCtrl.state.searchQuery.value = '';
          booksCtrl.resetPaging(listKey: _listKey);
        },
        onChanged: (value) {
          booksCtrl.searchBookNames(value);
        },
      ),
    );
  }

  Widget _buildSixthBooksSection(
    BuildContext context,
    List<Book> allBooks,
    bool isSixthBooks,
  ) {
    final priorityBooks = booksCtrl.getCustomBookNumber(
      allBooks,
      isSixthBooks ? booksCtrl.sixthBooksNumbers : booksCtrl.ninthBooksNumbers,
    );
    if (priorityBooks.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              const SizedBox().customSvgWithColor(
                SvgPath.svgSliderIc2,
                color: context.theme.dividerColor,
                width: 20,
                height: 20,
              ),
              const Gap(8),
              Text(
                isSixthBooks ? 'sixthBooks'.tr : 'ninthBooks'.tr,
                style: TextStyle(
                  color: context.theme.dividerColor,
                  fontFamily: 'cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const Gap(8),
        _buildBooksGrid(
          priorityBooks,
          isSixthBooks: isSixthBooks,
          isNinthBooks: !isSixthBooks,
          heroPrefix: isSixthBooks ? 'sixthBookCover' : 'ninthBookCover',
        ),
        const Gap(8),
        context.hDivider(
          color: context.theme.dividerColor.withValues(alpha: .5),
          height: 1,
          width: MediaQuery.sizeOf(context).width * .7,
        ),
      ],
    );
  }

  Widget _buildRegularBooksSection(List<Book> allBooks) {
    final regularBooks = isHadithsBooks == true
        ? allBooks
            .where((book) =>
                !booksCtrl.sixthBooksNumbers.contains(book.bookNumber))
            .toList()
        : allBooks;
    if (regularBooks.isEmpty) return const SizedBox.shrink();
    final isSearch = booksCtrl.state.isSearch.value;
    final cap = _visibleForKey().clamp(0, regularBooks.length);
    final displayBooks =
        isSearch ? regularBooks : regularBooks.take(cap).toList();

    return _buildBooksGrid(displayBooks);
  }

  Widget _buildBooksGrid(
    List<Book> books, {
    bool isSixthBooks = false,
    bool isNinthBooks = false,
    String heroPrefix = 'bookCover',
  }) {
    final width =
        Get.context != null ? MediaQuery.sizeOf(Get.context!).width : 1200.0;
    final maxTileWidth = width >= 1200
        ? 220.0
        : width >= 900
            ? 200.0
            : 180.0;

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: books.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: maxTileWidth,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, index) {
        final book = books[index];
        return Hero(
          tag: '$heroPrefix-${book.bookName}',
          child: BookCoverWidget(
            book: book,
            bookNumber: book.bookNumber,
            isSixthBooks: isSixthBooks,
            isNinthBooks: isNinthBooks,
          ),
        );
      },
    );
  }
}
