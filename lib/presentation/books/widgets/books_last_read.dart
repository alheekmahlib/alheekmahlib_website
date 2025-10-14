part of '../books.dart';

class BooksLastRead extends StatelessWidget {
  final double? verticalMargin;
  final double? horizontalMargin;
  final double? horizontalPadding;
  final Color? backgroundColor;
  BooksLastRead({
    super.key,
    this.verticalMargin,
    this.horizontalPadding,
    this.horizontalMargin,
    this.backgroundColor,
  });

  final generalCtrl = GeneralController.instance;
  final bookCtrl = BooksController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var lastReadBooks = bookCtrl.state.booksList.where((book) {
        return bookCtrl.state.lastReadPage.containsKey(book.bookNumber);
      }).toList();
      return Container(
        height: 110,
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0.0),
        margin: EdgeInsets.symmetric(
            vertical: verticalMargin ?? 32.0,
            horizontal: horizontalMargin ?? 32.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.theme.colorScheme.primary.withValues(alpha: .2),
              context.theme.colorScheme.primary.withValues(alpha: .1),
              context.theme.colorScheme.primary.withValues(alpha: .2),
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            stops: const [0.0, 0.5, 1.0],
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.symmetric(
            vertical: BorderSide(
              color: context.theme.colorScheme.surface,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 110,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.theme.colorScheme.primary.withValues(alpha: .4),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: RotatedBox(
                quarterTurns: 3,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(
                    'lastRead'.tr,
                    style: TextStyle(
                        color: context.theme.dividerColor,
                        fontFamily: 'cairo',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            const Gap(8.0),
            Expanded(
              child: SizedBox(
                height: 100,
                width: MediaQuery.sizeOf(context).width,
                child: lastReadBooks.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: lastReadBooks.length,
                        itemBuilder: (context, index) {
                          var book = lastReadBooks[index];
                          var currentPage =
                              bookCtrl.state.lastReadPage[book.bookNumber] ?? 0;
                          var totalPages =
                              bookCtrl.state.bookTotalPages[book.bookNumber] ??
                                  1;
                          var progress = currentPage / totalPages;
                          return Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  bookCtrl.state.currentPageNumber.value =
                                      currentPage - 1;
                                  bookCtrl
                                      .getTocs(book.bookNumber)
                                      .then((tocs) {
                                    ChaptersController.instance
                                      ..currentChapterItem = tocs.firstOrNull
                                      ..chapters = tocs
                                      ..currentChapterName =
                                          tocs.firstOrNull?.text;

                                    return tocs;
                                  });
                                  await bookCtrl.moveToBookPageByNumber(
                                      currentPage - 1, book.bookNumber);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: context
                                          .theme.colorScheme.secondaryContainer,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8.0))),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Text(
                                        _getBookNameBeforeSymbol(book.bookName),
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'naskh',
                                          fontWeight: FontWeight.w500,
                                          color: context.theme.hintColor,
                                          height: 1.5,
                                        ),
                                        textAlign: TextAlign.center,
                                        textDirection: TextDirection.rtl,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: LinearProgressIndicator(
                                          minHeight: 10,
                                          value: progress,
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          ),
                                          backgroundColor: context
                                              .theme.colorScheme.primary
                                              .withValues(alpha: .15),
                                          color: context
                                              .theme.colorScheme.surface
                                              .withValues(alpha: .5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CustomButton(
                                    onPressed: () {
                                      // حذف الكتاب من آخر قراءة - Remove book from last read
                                      bookCtrl
                                          .removeFromLastRead(book.bookNumber);

                                      // إظهار رسالة تأكيد الحذف - Show delete confirmation message
                                      Get.context!.showCustomErrorSnackBar(
                                        'تم حذف الكتاب من آخر قراءة',
                                        isDone: true,
                                      );
                                    },
                                    width: 25,
                                    backgroundColor:
                                        Colors.red.withValues(alpha: .8),
                                    isCustomSvgColor: true,
                                    iconSize: 18,
                                    svgPath: SvgPath.svgDeleteIcon,
                                    svgColor: context.theme.canvasColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'noBooksReadedYet'.tr,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'cairo',
                            fontWeight: FontWeight.w500,
                            color: context.theme.colorScheme.inversePrimary
                                .withValues(alpha: .6),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // Helper method to extract book name before '-' or '=' symbols
  // دالة مساعدة لاستخراج اسم الكتاب قبل رمز '-' أو '='
  String _getBookNameBeforeSymbol(String bookName) {
    // Find the position of '-' or '=' symbols
    // البحث عن موضع رمز '-' أو '='
    int dashIndex = bookName.indexOf('-');
    int equalIndex = bookName.indexOf('=');

    // Determine which symbol comes first (or if only one exists)
    // تحديد أي رمز يأتي أولاً (أو إذا كان هناك رمز واحد فقط)
    int splitIndex = -1;

    if (dashIndex != -1 && equalIndex != -1) {
      // Both symbols exist, take the one that comes first
      // الرمزان موجودان، نأخذ الذي يأتي أولاً
      splitIndex = dashIndex < equalIndex ? dashIndex : equalIndex;
    } else if (dashIndex != -1) {
      // Only dash exists
      // رمز الشرطة فقط موجود
      splitIndex = dashIndex;
    } else if (equalIndex != -1) {
      // Only equal sign exists
      // رمز المساواة فقط موجود
      splitIndex = equalIndex;
    }

    // If no symbols found, return the original name (limited to 3 words)
    // إذا لم يتم العثور على رموز، إرجاع الاسم الأصلي (محدود بـ 3 كلمات)
    if (splitIndex == -1) {
      return _limitToThreeWords(bookName.trim());
    }

    // Return the text before the symbol, trimmed of whitespace
    // إرجاع النص الذي يأتي قبل الرمز، مع إزالة المسافات الزائدة
    String textBeforeSymbol = bookName.substring(0, splitIndex).trim();

    // Limit to maximum 3 words
    // تحديد النص بحد أقصى 3 كلمات
    return _limitToThreeWords(textBeforeSymbol);
  }

  // Helper method to limit text to maximum 3 words
  // دالة مساعدة لتحديد النص بحد أقصى 3 كلمات
  String _limitToThreeWords(String text) {
    if (text.isEmpty) return text;

    // Split the text into words
    // تقسيم النص إلى كلمات
    List<String> words =
        text.split(' ').where((word) => word.isNotEmpty).toList();

    // If 3 words or less, return as is
    // إذا كان 3 كلمات أو أقل، إرجاع النص كما هو
    if (words.length <= 3) {
      return words.join(' ');
    }

    // Return only the first 3 words
    // إرجاع أول 3 كلمات فقط
    return words.take(3).join(' ');
  }
}
