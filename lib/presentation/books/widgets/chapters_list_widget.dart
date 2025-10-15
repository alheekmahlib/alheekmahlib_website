part of '../books.dart';

/// قائمة فصول بسيطة (ListView) بدل الـ CustomDropdown
class ChaptersListWidget extends StatelessWidget {
  final int bookNumber;
  final int pageIndex;
  final EdgeInsetsGeometry? padding;
  final double itemHeight;

  const ChaptersListWidget({
    super.key,
    required this.bookNumber,
    required this.pageIndex,
    this.padding,
    this.itemHeight = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    final booksCtrl = BooksController.instance;

    return GetBuilder<ChaptersController>(
      id: 'ChapterName',
      init: ChaptersController.instance,
      builder: (controller) {
        if (controller.isLoading || controller.chapters.isEmpty) {
          return const SizedBox.shrink();
        }

        // تحديث الفصل الحالي بناءً على الصفحة عند البناء الأول فقط
        if (controller.currentChapterName == null &&
            controller.chapters.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.onPageChanged(pageIndex);
          });
        }

        return Scrollbar(
          controller: controller.itemsScrollController,
          thumbVisibility: true,
          child: ListView.builder(
            controller: controller.itemsScrollController,
            padding: padding ?? const EdgeInsets.symmetric(vertical: 4),
            itemExtent: itemHeight, // يطابق حساب الـ controller
            itemCount: controller.chapters.length,
            itemBuilder: (context, index) {
              final item = controller.chapters[index];
              final isSelected = controller.currentChapterName
                      ?.split(',')
                      .contains(item.text) ==
                  true;

              return InkWell(
                onTap: () async {
                  // تأخير بسيط لتحسين تجربة الضغط مع أي تأثيرات
                  await Future.delayed(const Duration(milliseconds: 120));
                  booksCtrl.moveToPage(item.text, bookNumber);
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? context.theme.colorScheme.surface
                            .withValues(alpha: .5)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.centerRight,
                  child: Text(
                    item.text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isSelected
                          ? context.theme.colorScheme.primary
                          : context.theme.colorScheme.onSurface,
                      fontSize: 15,
                      fontFamily: 'cairo',
                      height: .6,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w700,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
