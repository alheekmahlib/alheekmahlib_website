part of '../books.dart';

class ChaptersPage extends StatelessWidget {
  final Book book;
  final bool isSixthBooks;
  final bool isNinthBooks;

  ChaptersPage({
    super.key,
    required this.book,
    this.isSixthBooks = false,
    this.isNinthBooks = false,
  });

  final booksCtrl = BooksController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            context.theme.colorScheme.surface.withValues(alpha: .1),
        title: Text(
          book.bookName,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'cairo',
            fontWeight: FontWeight.bold,
            color: context.theme.colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: context.theme.colorScheme.primary,
        ),
        actions: [
          CustomButton(
            onPressed: () => showSearchBottomSheet(context,
                onSubmitted: (_) => booksCtrl.searchBooks(
                      booksCtrl.state.searchController.text,
                      bookNumber: book.bookNumber,
                    )),
            width: 50,
            isCustomSvgColor: true,
            svgColor: context.theme.colorScheme.primary,
            backgroundColor: Colors.transparent,
            borderColor: context.theme.canvasColor.withValues(alpha: .2),
            svgPath: SvgPath.svgSearchIcon,
          ),
        ],
      ),
      body: SafeArea(
        child: context.customOrientation(
          ListView(
            children: [
              const Gap(16),
              BookDetails(
                book: book,
                isSixthBooks: isSixthBooks,
                isNinthBooks: isNinthBooks,
              ),
              const Gap(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: BooksChapterBuild(
                    bookNumber: book.bookNumber,
                  ),
                ),
              ),
              const Gap(16),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: context.definePlatform(0.0, 32.0)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: BookDetails(
                      book: book,
                      isSixthBooks: isSixthBooks,
                      isNinthBooks: isNinthBooks,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      child: BooksChapterBuild(
                        bookNumber: book.bookNumber,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
