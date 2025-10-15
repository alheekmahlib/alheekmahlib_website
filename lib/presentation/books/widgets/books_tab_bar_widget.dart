part of '../books.dart';

// كنترولر GetX لإدارة التاب الحالي مع نمط الكائن الوحيد
// GetX controller to manage current tab with singleton pattern
class BooksTabBarController extends GetxController {
  // نمط الكائن الوحيد مع GetX
  // Singleton pattern with GetX
  static BooksTabBarController get instance =>
      Get.isRegistered<BooksTabBarController>()
          ? Get.find<BooksTabBarController>()
          : Get.put(BooksTabBarController());

  RxInt currentIndex = 0.obs;

  // تغيير التاب الحالي
  // Change current tab
  void changeTab(int index) {
    currentIndex.value = index;
    update();
  }
}

class BooksTabBarWidget extends StatelessWidget {
  final Widget firstTabChild;
  final Widget secondTabChild;
  final Widget thirdTabChild;
  final Widget fourthTabChild;
  final Widget? topChild;
  final double? topPadding;

  BooksTabBarWidget({
    super.key,
    required this.firstTabChild,
    required this.secondTabChild,
    this.topChild,
    this.topPadding,
    required this.thirdTabChild,
    required this.fourthTabChild,
  });
  final booksCtrl = BooksController.instance;

  @override
  Widget build(BuildContext context) {
    // شرح: نستخدم init داخل GetBuilder لإنشاء الكنترولر إذا لم يكن مسجلاً
    // Explanation: Use init in GetBuilder to create controller if not registered
    final screens = <Widget>[
      firstTabChild,
      secondTabChild,
      thirdTabChild,
      fourthTabChild,
    ];
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        // alignment: Alignment.topCenter,
        children: [
          const Gap(8),
          Container(
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: context.theme.colorScheme.secondaryContainer
                  .withValues(alpha: .05),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: GetBuilder<BooksTabBarController>(
              // استخدام نمط الكائن الوحيد بدلاً من إنشاء نسخة جديدة في كل مرة
              // Use singleton pattern instead of creating a new instance each time
              init: BooksTabBarController.instance,
              builder: (tabCtrl) => Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.secondaryContainer
                          .withValues(alpha: .1),
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                    ),
                    child: customSvgWithCustomColor(
                      SvgPath.svgBooksIconIslamicLibraryIcon,
                      width: 80,
                      color: context.theme.colorScheme.primary,
                    ),
                  ),
                  const Gap(2),
                  context.vDivider(
                    height: 60,
                    color: context.theme.colorScheme.secondaryContainer
                        .withValues(alpha: .3),
                  ),
                  const Gap(2),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SingleChildScrollView(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              buttomBuild(tabCtrl, context, 0,
                                  SvgPath.svgBooksIconAllBooksIcon, 'allBooks'),
                              const Gap(8),
                              buttomBuild(tabCtrl, context, 2,
                                  SvgPath.svgBooksIconHadithIcon, 'hadiths'),
                              const Gap(8),
                              buttomBuild(tabCtrl, context, 3,
                                  SvgPath.svgBooksIconTafsirIcon, 'tafsir'),
                            ],
                          ),
                        ),
                        CustomButton(
                          onPressed: () => showSearchBottomSheet(context,
                              onSubmitted: (_) => booksCtrl.searchBooks(
                                    booksCtrl.state.searchController.text,
                                  )),
                          width: 50,
                          isCustomSvgColor: true,
                          svgPath: SvgPath.svgSearchIcon,
                          svgColor: context.theme.dividerColor,
                          backgroundColor: Colors.transparent,
                          borderColor:
                              context.theme.canvasColor.withValues(alpha: .2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ), // استخدام GetBuilder لعرض محتوى التاب الحالي مع نمط الكائن الوحيد
          // Use GetBuilder to show current tab content with singleton pattern
          Flexible(
            child: GetBuilder<BooksTabBarController>(
              init: BooksTabBarController.instance,
              builder: (tabCtrl) => screens[tabCtrl.currentIndex.value],
            ),
          ),
        ],
      ),
    );
  }

  Widget buttomBuild(BooksTabBarController tabCtrl, BuildContext context,
      int index, String svgPath, String title) {
    return CustomButton(
      onPressed: () => tabCtrl.changeTab(index),
      width: 95,
      iconSize: 90,
      borderColor:
          context.theme.colorScheme.secondaryContainer.withValues(alpha: .3),
      iconWidget: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            customSvgWithCustomColor(
              svgPath,
              width: 70,
              color: context.theme.colorScheme.primary,
            ),
            const Gap(4),
            context.hDivider(
                width: 70, color: context.theme.colorScheme.primary),
            const Gap(4),
            Text(
              title.tr,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'cairo',
                height: .7,
                fontWeight: FontWeight.bold,
                color: context.theme.colorScheme.primary.withValues(alpha: .7),
              ),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
