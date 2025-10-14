part of '../books.dart';

class BookCoverWidget extends StatelessWidget {
  final Book? book;
  final int? bookNumber;
  final bool isInDetails;
  final bool? isSixthBooks;
  final bool? isNinthBooks;
  const BookCoverWidget({
    super.key,
    this.book,
    this.isInDetails = false,
    this.bookNumber,
    this.isSixthBooks = false,
    this.isNinthBooks = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isInDetails
            ? SizedBox(height: 240, width: 220, child: _heroWidget(context))
            : GestureDetector(
                onTap: isInDetails
                    ? null
                    : () {
                        final ctx = rootNavigatorKey.currentContext;
                        if (ctx != null) {
                          // الآن نفتح صفحة الفصول أولًا
                          ctx.go('/books/details/${book!.bookNumber}');
                        }
                      },
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return AspectRatio(
                      aspectRatio: 0.66, // اتساق نسبة البطاقة داخل الشبكة
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: context.theme.colorScheme.primary
                              .withValues(alpha: .1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: _heroWidget(context),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }

  Widget _heroWidget(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final shortestSide = constraints.maxWidth < constraints.maxHeight
            ? constraints.maxWidth
            : constraints.maxHeight;
        final logoH = isInDetails ? 25.0 : shortestSide * 0.09;
        final decoH = isInDetails ? 45.0 : shortestSide * 0.28;
        final textFont =
            isInDetails ? 22.0 : (shortestSide * 0.16).clamp(10.0, 18.0);

        return Stack(
          alignment: Alignment.center,
          children: [
            customSvgWithCustomColor(SvgPath.svgBooksIconBookBack),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: isInDetails ? 24.0 : 0),
                child: customSvgWithColor(
                  SvgPath.svgAlheekmahLogo,
                  height: logoH,
                  color: context.theme.colorScheme.secondary,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isInDetails ? 16.0 : 2.0, vertical: 2.0),
                child: customSvgWithColor(
                  SvgPath.svgDecorations,
                  height: decoH,
                  color: context.theme.colorScheme.secondary,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isInDetails ? 16.0 : 2.0, vertical: 2.0),
                child: RotatedBox(
                  quarterTurns: 2,
                  child: customSvgWithColor(
                    SvgPath.svgDecorations,
                    height: decoH,
                    color: context.theme.colorScheme.secondary,
                  ),
                ),
              ),
            ),
            Container(
              height: isInDetails ? 170 : double.infinity,
              width: isInDetails ? 110 : double.infinity,
              alignment: Alignment.center,
              child: Text(
                _getBookNameBeforeSymbol(book!.bookName),
                style: TextStyle(
                  fontSize: textFont,
                  fontFamily: 'cairo',
                  fontWeight: FontWeight.bold,
                  color: context.theme.colorScheme.secondary,
                  height: 1.5,
                ),
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
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
