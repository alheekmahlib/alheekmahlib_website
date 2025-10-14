part of '../books.dart';

class ReadViewScreen extends StatelessWidget {
  final int bookNumber;
  const ReadViewScreen({super.key, required this.bookNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReadViewBody(bookNumber: bookNumber),
    );
  }
}

/// Widget: الجسم الرئيسي لقراءة الكتاب (بديل دوال البناء)
class ReadViewBody extends StatelessWidget {
  final int bookNumber;
  ReadViewBody({super.key, required this.bookNumber});

  final booksCtrl = BooksController.instance;

  Future<List<PageContent>> _loadPages() {
    return Future.delayed(const Duration(milliseconds: 600)).then((_) async {
      final pages = await booksCtrl.getPages(bookNumber);
      // تهيئة المتحكم مرة واحدة بناءً على الصفحة الحالية/أخر قراءة
      final initial = booksCtrl.state.currentPageNumber.value;
      final existing = booksCtrl.state.bookPageController;
      // إذا كان existing جديد ولم يُستخدم بعد (position not attached)، أعِد إنشاءه بالإعدادات الصحيحة
      if (!existing.hasClients) {
        booksCtrl.state.bookPageController = PageController(
          initialPage: initial.clamp(0, (pages.length - 1).clamp(0, 1 << 31)),
          keepPage: true,
        );
      } else {
        // لو لدى المتحكم عملاء، نقفز مباشرة للموضع المناسب
        try {
          existing.jumpToPage(initial.clamp(0, pages.length - 1));
        } catch (_) {}
      }

      // عند الدخول مباشرة عبر رابط يحتوي ?page= تأكّد من تحميل الفصول وتحديد الفصل الحالي
      try {
        final chaptersCtrl = ChaptersController.instance;
        final hasChapters = chaptersCtrl.chapters.isNotEmpty;
        final currentSelected = chaptersCtrl.currentChapterName;
        if (!hasChapters ||
            currentSelected == null ||
            currentSelected.isEmpty) {
          final page1Based = (initial + 1).clamp(1, pages.length);
          final chapterName =
              await booksCtrl.getChapterNameByPage(bookNumber, page1Based);
          if (chapterName != null && chapterName.isNotEmpty) {
            await chaptersCtrl.loadChapters(chapterName, bookNumber);
          }
        }
      } catch (_) {}
      return pages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: FutureBuilder<List<PageContent>>(
          future: _loadPages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ShimmerEffectBuild();
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final pages = snapshot.data;
            if (pages == null || pages.isEmpty) {
              return const Center(
                child: Text('لم يتم العثور على صفحات لهذا الكتاب.'),
              );
            }
            return ReadPagesView(bookNumber: bookNumber, pages: pages);
          },
        ),
      ),
    );
  }
}

/// Widget: عارض الصفحات مع PageView والعنوان العلوي
class ReadPagesView extends StatelessWidget {
  final int bookNumber;
  final List<PageContent> pages;
  ReadPagesView({super.key, required this.bookNumber, required this.pages});

  final booksCtrl = BooksController.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MediaQuery.of(context).size.width >= 770
              ? Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ChaptersListWidget(
                        bookNumber: bookNumber,
                        pageIndex: booksCtrl.state.currentPageNumber.value,
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Focus(
                        focusNode: booksCtrl.state.bookRLFocusNode,
                        onKeyEvent: (node, event) =>
                            booksCtrl.controlRLByKeyboard(node, event),
                        child: PageView.builder(
                          controller: booksCtrl.state.bookPageController,
                          itemCount: pages.length,
                          onPageChanged: (i) {
                            booksCtrl.state.currentPageNumber.value = i;
                            ChaptersController.instance.onPageChanged(i);
                            // استخدم مُحدّث الرابط الخفيف لتفادي إعادة بناء الواجهة
                            UrlHelper.replacePath(
                                '/books/read/$bookNumber?page=${(i + 1).clamp(1, 1 << 20)}');
                          },
                          itemBuilder: (context, index) => ReadPage(
                            page: pages[index],
                            index: index,
                            totalPages: pages.length,
                            bookNumber: bookNumber,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Focus(
                  focusNode: booksCtrl.state.bookRLFocusNode,
                  onKeyEvent: (node, event) =>
                      booksCtrl.controlRLByKeyboard(node, event),
                  child: PageView.builder(
                    controller: booksCtrl.state.bookPageController,
                    itemCount: pages.length,
                    onPageChanged: (i) {
                      booksCtrl.state.currentPageNumber.value = i;
                      ChaptersController.instance.onPageChanged(i);
                      // استخدم مُحدّث الرابط الخفيف لتفادي إعادة بناء الواجهة
                      UrlHelper.replacePath(
                          '/books/read/$bookNumber?page=${(i + 1).clamp(1, 1 << 20)}');
                    },
                    itemBuilder: (context, index) => ReadPage(
                      page: pages[index],
                      index: index,
                      totalPages: pages.length,
                      bookNumber: bookNumber,
                    ),
                  ),
                ),
        ),
        BooksBottomOptionsWidget(
          bookNumber: bookNumber,
          index: booksCtrl.state.currentPageNumber.value - 1,
        ),
      ],
    );
  }
}

/// Widget: صفحة واحدة مع الرأس والمحتوى
class ReadPage extends StatelessWidget {
  final PageContent page;
  final int index;
  final int totalPages;
  final int bookNumber;

  ReadPage({
    super.key,
    required this.page,
    required this.index,
    required this.totalPages,
    required this.bookNumber,
  });

  final booksCtrl = BooksController.instance;

  @override
  Widget build(BuildContext context) {
    _saveLastRead(page, totalPages);
    final size = MediaQuery.of(context).size.width <= 770;
    return GetBuilder<BooksController>(
      init: BooksController.instance,
      builder: (_) {
        return Column(
          children: [
            size
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: PageNumberWidget(
                                    page: page,
                                    totalPages: totalPages,
                                    currentIndex: index,
                                  ),
                                ),
                              ),
                              context.vDivider(
                                color: context.theme.colorScheme.primary
                                    .withValues(alpha: .5),
                                height: 30,
                              ),
                              Expanded(
                                flex: 10,
                                child: ChaptersDropdownWidget(
                                  bookNumber: bookNumber,
                                  pageIndex: index,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : PageNumberWidget(
                    page: page,
                    totalPages: totalPages,
                    currentIndex: index,
                  ),
            Divider(height: 1, color: context.theme.colorScheme.primary),
            Flexible(
              child: PageTextContent(page: page),
            ),
          ],
        );
      },
    );
  }

  void _saveLastRead(PageContent page, int totalPages) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final book = _findCurrentBook();
      booksCtrl.saveLastRead(
        page.pageNumber,
        book.bookName.isNotEmpty ? book.bookName : 'Unknown Book',
        bookNumber,
        totalPages,
      );
    });
  }

  Book _findCurrentBook() {
    return booksCtrl.state.booksList.firstWhere(
      (book) => book.bookNumber == bookNumber,
      orElse: () => booksCtrl.state.booksList.isNotEmpty
          ? booksCtrl.state.booksList.first
          : Book.empty(),
    );
  }
}

class PageNumberWidget extends StatelessWidget {
  const PageNumberWidget({
    super.key,
    required this.page,
    required this.totalPages,
    required this.currentIndex,
  });

  final PageContent page;
  final int totalPages;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final booksCtrl = BooksController.instance;
    final canPrev = currentIndex > 0;
    final canNext = currentIndex < totalPages - 1;
    final color = Theme.of(context).colorScheme.inversePrimary;
    final size = MediaQuery.of(context).size.width <= 770;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // السابق (RTL: سهم لليمين)
        !size
            ? IconButton(
                icon: const Icon(Icons.chevron_left_outlined),
                color: color,
                onPressed: canPrev
                    ? () {
                        final c = booksCtrl.pageController;
                        if (c.hasClients) {
                          final current = (c.page?.round() ?? currentIndex);
                          c.animateToPage(
                            (current - 1).clamp(0, totalPages - 1),
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          );
                        }
                      }
                    : null,
                splashRadius: 22,
                tooltip: null,
              )
            : const SizedBox.shrink(),
        !size ? const Gap(8) : const SizedBox.shrink(),
        Text(
          '${page.pageNumber} / $totalPages'.convertNumbers(),
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'cairo',
            height: 1.7,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
        !size ? const Gap(8) : const SizedBox.shrink(),
        // التالي (RTL: سهم لليسار)
        !size
            ? IconButton(
                icon: const Icon(Icons.chevron_right_outlined),
                color: color,
                onPressed: canNext
                    ? () {
                        final c = booksCtrl.pageController;
                        if (c.hasClients) {
                          final current = (c.page?.round() ?? currentIndex);
                          c.animateToPage(
                            (current + 1).clamp(0, totalPages - 1),
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          );
                        }
                      }
                    : null,
                splashRadius: 22,
                tooltip: null,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

/// Widget: محتوى النصوص (النص والهوامش)
class PageTextContent extends StatelessWidget {
  final PageContent page;
  PageTextContent({super.key, required this.page});

  final booksCtrl = BooksController.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: GetX<GeneralController>(
                builder: (generalCtrl) {
                  final mainText = _getMainText(page.text);
                  final processedText = booksCtrl.state.isTashkil.value
                      ? mainText
                      : mainText.removeDiacritics(mainText);

                  final footnotesRaw = _getFootnotes(page.text);
                  final hasFootnotes = footnotesRaw.isNotEmpty;
                  final footnotesText = _getMainText(footnotesRaw);
                  final processedFootnotes = booksCtrl.state.isTashkil.value
                      ? footnotesText
                      : footnotesText.searchRemoveDiacritics(footnotesText);

                  return Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: processedText.buildTextSpans(
                              context.theme.colorScheme.inversePrimary),
                          style: TextStyle(
                            color: context.theme.colorScheme.inversePrimary,
                            height: 1.5,
                            fontFamily: 'naskh',
                            fontSize: generalCtrl.fontSizeArabic.value,
                          ),
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.justify,
                      ),
                      if (hasFootnotes) ...[
                        const Gap(8),
                        context.hDivider(
                          color: context.theme.colorScheme.inversePrimary
                              .withValues(alpha: .2),
                          width: context.width,
                        ),
                        const Gap(10),
                        Text.rich(
                          TextSpan(
                            text: processedFootnotes,
                            style: TextStyle(
                              color: context.theme.colorScheme.inversePrimary
                                  .withValues(alpha: .8),
                              height: 1.4,
                              fontFamily: 'naskh',
                              fontSize:
                                  (generalCtrl.fontSizeArabic.value * 0.85)
                                      .roundToDouble(),
                            ),
                          ),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                      const Gap(32),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  // أدوات مساعدة لاستخراج النصوص من HTML
  String _getMainText(String htmlText) {
    String mainText = htmlText;
    mainText = mainText.replaceAll(RegExp(r'</?div[^>]*>'), '');
    mainText = mainText.replaceAll(RegExp(r'</?p[^>]*>'), ' ');
    mainText = mainText.replaceAll(RegExp(r'<hr[^>]*>'), '');
    mainText = mainText.replaceAllMapped(
      RegExp(r'<span\s+class="special"[^>]*>(.*?)</span>'),
      (match) => match.group(1) ?? '',
    );
    mainText = mainText.replaceAll(
      RegExp(r'<p\s+class="hamesh"[^>]*>.*?</p>', dotAll: true),
      '',
    );
    mainText = mainText.replaceAll(
      RegExp(r'<span\s+class="hamesh"[^>]*>.*?</span>', dotAll: true),
      '',
    );
    mainText = mainText.replaceAll(RegExp(r'<br[^>]*>'), '\n');
    return mainText.trim();
  }

  String _getFootnotes(String htmlText) {
    String footnotes = '';
    final pHameshRegex =
        RegExp(r'<p\s+class="hamesh"[^>]*>(.*?)</p>', dotAll: true);
    final pMatches = pHameshRegex.allMatches(htmlText);
    for (final match in pMatches) {
      String content = match.group(1) ?? '';
      content = content.replaceAll(RegExp(r'<br[^>]*>'), '\n');
      footnotes += '$content\n\n';
    }
    final spanHameshRegex =
        RegExp(r'<span\s+class="hamesh"[^>]*>(.*?)</span>', dotAll: true);
    final spanMatches = spanHameshRegex.allMatches(htmlText);
    for (final match in spanMatches) {
      String content = match.group(1) ?? '';
      content = content.replaceAll(RegExp(r'<br[^>]*>'), '\n');
      footnotes += '$content\n\n';
    }
    return footnotes.trim();
  }
}
