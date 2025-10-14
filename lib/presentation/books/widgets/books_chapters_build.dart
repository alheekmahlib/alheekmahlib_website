part of '../books.dart';

class BooksChapterBuild extends StatelessWidget {
  final int bookNumber;

  BooksChapterBuild({super.key, required this.bookNumber});

  final booksCtrl = BooksController.instance;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BooksController>(
        id: 'downloadedBooks',
        builder: (booksCtrl) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  // margin:
                  //     EdgeInsets.only(top: context.definePlatform(0.0, 100.0)),
                  decoration: BoxDecoration(
                      color: context.theme.colorScheme.primary
                          .withValues(alpha: .15),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FutureBuilder<List<dynamic>>(
                        future: Future.wait([
                          booksCtrl.getVolumes(bookNumber).then((v) {
                            ChaptersController.instance
                              ..currentChapterName = v.firstOrNull?.name
                              ..volumes = v;

                            return v;
                          }),
                          booksCtrl.getTocs(bookNumber).then((tocs) {
                            ChaptersController.instance
                              ..currentChapterItem = tocs.firstOrNull
                              ..chapters = tocs
                              ..currentChapterName = tocs.firstOrNull?.text;

                            return tocs;
                          }),
                        ]),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }

                          if (snapshot.hasError) {
                            return _errorBuild(context, snapshot);
                          }

                          final volumes =
                              snapshot.data?[0] as List<Volume>? ?? [];
                          final toc = snapshot.data?[1] as List<TocItem>? ?? [];

                          return _juzBuild(volumes, context, toc);
                        },
                      ),
                    ],
                  )),
            ],
          );
        });
  }

  Widget _juzBuild(
      List<Volume> volumes, BuildContext context, List<TocItem> toc) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // عرض الأجزاء مع الأبواب - Display volumes with chapters
        if (volumes.isNotEmpty) ...[
          Container(
            width: MediaQuery.sizeOf(context).width,
            alignment: Alignment.center,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            decoration: BoxDecoration(
                color: context.theme.colorScheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Text(
              'bookJuz'.tr,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'cairo',
                fontWeight: FontWeight.w700,
                color: context.theme.canvasColor,
                height: 1.5,
              ),
            ),
          ),
          const Gap(12),
          ...volumes
              .map((volume) => _buildVolumeExpansionTile(context, volume, toc)),
          const Gap(12),
        ],

        // عرض جدول المحتويات منفصل إذا لم توجد أجزاء - Display separate TOC if no volumes
        if (volumes.isEmpty && toc.isNotEmpty) ...[
          Container(
            width: MediaQuery.sizeOf(context).width,
            alignment: Alignment.center,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            decoration: BoxDecoration(
                color: context.theme.colorScheme.onPrimary,
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Text(
              'chapterBook'.tr,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'cairo',
                fontWeight: FontWeight.w700,
                color: context.theme.colorScheme.secondary,
                height: 1.5,
              ),
            ),
          ),
          const Gap(12),
          ...toc.map((item) => _buildTocItem(context, item)),
        ],

        // إذا لم تكن هناك بيانات، اعرض رسالة - If no data, show message
        if (volumes.isEmpty && toc.isEmpty) ...[
          Container(
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                customSvgWithColor(
                  SvgPath.svgOpenBook,
                  height: 64,
                  color: context.theme.colorScheme.inversePrimary
                      .withValues(alpha: 0.6),
                ),
                const Gap(16),
                Text(
                  'downloadBookFirstToSeeTheContents'.tr,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'cairo',
                    color: context.theme.colorScheme.inversePrimary
                        .withValues(alpha: 0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _errorBuild(
      BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'errorLoadingData'.tr,
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'cairo',
              color: context.theme.colorScheme.inversePrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(8),
          Text(
            'التفاصيل: ${snapshot.error}',
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'cairo',
              color: context.theme.colorScheme.inversePrimary
                  .withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // بناء ExpansionTile للجزء مع الأبواب - Build volume ExpansionTile with chapters
  Widget _buildVolumeExpansionTile(
      BuildContext context, Volume volume, List<TocItem> allToc) {
    // الحصول على الأبواب التي تنتمي لهذا الجزء - Get chapters belonging to this volume
    List<TocItem> volumeChapters = allToc.where((tocItem) {
      return tocItem.page >= volume.startPage && tocItem.page <= volume.endPage;
    }).toList();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        backgroundColor: context.theme.colorScheme.onPrimary,
        collapsedBackgroundColor: context.theme.colorScheme.onPrimary,
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        childrenPadding: const EdgeInsets.symmetric(vertical: 8),
        leading: Icon(
          Icons.menu_book_outlined,
          color: context.theme.colorScheme.secondary,
          size: 24,
        ),
        title: Text(
          volume.name,
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'cairo',
            fontWeight: FontWeight.w600,
            color: context.theme.colorScheme.secondary,
          ),
        ),
        subtitle: Text(
          '${'pages'.tr} ${volume.startPage} - ${volume.endPage} • ${volumeChapters.length} ${'chapter'.tr}'
              .convertNumbers(),
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'cairo',
            color: context.theme.colorScheme.secondary,
          ),
        ),
        iconColor: context.theme.colorScheme.secondary,
        collapsedIconColor: context.theme.colorScheme.secondary,
        children: [
          // زر الذهاب إلى بداية الجزء - Button to go to volume start
          SizedBox(
            height: 55,
            child: InkWell(
              onTap: () async => await booksCtrl.moveToBookPageByNumber(
                  volume.startPage, bookNumber),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color:
                      context.theme.colorScheme.primary.withValues(alpha: .3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'goToStartOfJuz'.tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'naskh',
                      color: context.theme.colorScheme.secondary,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
          ),

          // عرض الأبواب الخاصة بهذا الجزء - Display chapters for this volume
          if (volumeChapters.isNotEmpty) ...[
            const Gap(8.0),
            Container(
              height: 32,
              width: MediaQuery.sizeOf(context).width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.theme.colorScheme.onPrimary,
              ),
              child: Text(
                'chapterBook'.tr,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'cairo',
                  color: context.theme.colorScheme.secondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Gap(8.0),
            ...volumeChapters
                .map((chapter) => _buildChapterListTile(context, chapter)),
          ],

          // إذا لم توجد أبواب في هذا الجزء - If no chapters in this volume
          if (volumeChapters.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'noChaptersInThisJuz'.tr,
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'cairo',
                  color: context.theme.colorScheme.inversePrimary
                      .withValues(alpha: 0.5),
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }

  // بناء عنصر الفصل داخل القائمة - Build chapter list tile
  Widget _buildChapterListTile(BuildContext context, TocItem item) {
    return InkWell(
      onTap: () async {
        await booksCtrl.moveToBookPageByNumber(item.page - 1, bookNumber);
        // await ChaptersController.instance.loadChapters(item.text, bookNumber);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.primary.withValues(alpha: .3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.text,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'naskh',
                  color: context.theme.colorScheme.secondary,
                ),
                textAlign: TextAlign.start,
              ),
              item.page > 0
                  ? Text(
                      '${'page'.tr} ${item.page}',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontFamily: 'cairo',
                        color: context.theme.colorScheme.secondary
                            .withValues(alpha: 0.6),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  // بناء عنصر جدول المحتويات - Build table of contents item
  Widget _buildTocItem(BuildContext context, TocItem item) {
    return InkWell(
      onTap: () async =>
          await booksCtrl.moveToBookPageByNumber(item.page - 1, bookNumber),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.primary.withValues(alpha: .3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.text,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'naskh',
                  color: context.theme.colorScheme.inversePrimary,
                ),
                textAlign: TextAlign.start,
              ),
              item.page > 0
                  ? Text(
                      '${'page'.tr} ${item.page}',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontFamily: 'cairo',
                        color: context.theme.colorScheme.inversePrimary
                            .withValues(alpha: 0.6),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
