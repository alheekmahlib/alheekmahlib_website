part of '../books.dart';

class BookDetails extends StatelessWidget {
  final Book book;
  final bool? isSixthBooks;
  final bool? isNinthBooks;

  BookDetails({
    super.key,
    required this.book,
    this.isSixthBooks = false,
    this.isNinthBooks = false,
  });

  final booksCtrl = BooksController.instance;

  @override
  Widget build(BuildContext context) {
    // OverlayTooltipScaffold.of(context)?.controller.start(3);
    return Column(
      children: [
        Container(
          // height: 290,
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
              color: context.theme.colorScheme.primary.withValues(alpha: .15),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Stack(
            alignment: Alignment.center,
            children: [
              customSvgWithColor(
                SvgPath.svgAlheekmahLogo,
                height: MediaQuery.sizeOf(context).width * .3,
                color: context.theme.colorScheme.inversePrimary
                    .withValues(alpha: .03),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Hero(
                      tag: isSixthBooks!
                          ? 'sixthBookCover-${book.bookName}'
                          : isNinthBooks!
                              ? 'ninthBookCover-${book.bookName}'
                              : 'bookCover-${book.bookName}',
                      child: BookCoverWidget(
                        isInDetails: true,
                        book: book,
                      ),
                    ),
                  ),
                  Text(
                    book.bookName,
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'cairo',
                      fontWeight: FontWeight.bold,
                      color: context.theme.colorScheme.inversePrimary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    book.author,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'cairo',
                      color: context.theme.colorScheme.inversePrimary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(16),
                ],
              ),
            ],
          ),
        ),
        const Gap(8),
        Container(
          width: MediaQuery.sizeOf(context).width,
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
              color: context.theme.colorScheme.primary.withValues(alpha: .15),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: ContainerWithTitleWidget(
            title: 'aboutBook',
            height: 140,
            gap: 0,
            containerColor: context.theme.colorScheme.onPrimary,
            child: Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                child: Obx(() => ReadMoreLess(
                      text: book.aboutBook.buildHtmlTextSpans(context.theme
                          .colorScheme.inversePrimary), // .buildTextSpans(),
                      maxLines:
                          booksCtrl.isBookDownloaded(book.bookNumber) ? 1 : 50,
                      collapsedHeight:
                          booksCtrl.collapsedHeight(book.bookNumber).value
                              ? 130
                              : 60,
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontFamily: 'cairo',
                        color: context.theme.colorScheme.inversePrimary,
                      ),
                      textAlign: TextAlign.justify,
                      readMoreText: 'readMore'.tr,
                      readLessText: 'readLess'.tr,
                      buttonTextStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'cairo',
                        fontWeight: FontWeight.bold,
                        color: context.theme.colorScheme.inversePrimary,
                      ),
                      iconColor: context.theme.colorScheme.inversePrimary,
                    )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
