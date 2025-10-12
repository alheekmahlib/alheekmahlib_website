import 'package:alheekmahlib_website/presentation/athkar_screen/models/azkar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';
import 'package:share_plus/share_plus.dart';

import '/core/utils/constants/extensions.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/widgets/widgets.dart';
import '../../controllers/general_controller.dart';
import '../../quran_text/controllers/quranText_controller.dart';
import '../controllers/athkar_controller.dart';

class AzkarItem extends StatelessWidget {
  final String azkar;
  const AzkarItem({super.key, required this.azkar});

  @override
  Widget build(BuildContext context) {
    final athkar = sl<AthkarController>();
    // تحميل الفئة المختارة عند الدخول
    athkar.ensureAzkarCategoryLoaded(azkar);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          scrolledUnderElevation: 0,
          toolbarHeight: 72,
          title: whiteContainer(
            context,
            Obx(() {
              final title = athkar.azkarList.isNotEmpty
                  ? (athkar.azkarList.first.category ?? azkar)
                  : azkar;
              final count = athkar.azkarList.length;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: TextRenderer(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: context.textDarkColor,
                          fontSize: 16.0,
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: Theme.of(context)
                            .dividerColor
                            .withValues(alpha: .2),
                      ),
                    ),
                    child: Text(
                      '$count',
                      style: TextStyle(
                        color: context.textDarkColor,
                        fontFamily: 'cairo',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              sl<GeneralController>().textWidgetPosition.value = -240.0;
              sl<QuranTextController>().selected.value = false;
            },
            icon: Icon(
              Icons.arrow_back,
              size: 28,
              color: context.textDarkColor,
            ),
          ),
          actions: [
            fontSizeDropDown(context),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Divider(
              height: 1,
              thickness: 0.8,
              color: Theme.of(context).dividerColor.withValues(alpha: .1),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              int crossAxisCount;
              if (w < 700) {
                crossAxisCount = 1;
              } else if (w < 1200) {
                crossAxisCount = 2;
              } else {
                crossAxisCount = 3;
              }
              return Obx(() => MasonryGridView.count(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    itemCount: athkar.azkarList.length,
                    itemBuilder: (context, index) {
                      final item = athkar.azkarList[index];
                      final countText = item.count ?? '-';
                      return whiteContainer(
                        context,
                        ItemBuild(countText: countText, item: item),
                      );
                    },
                  ));
            },
          ),
        ),
      ),
    );
  }
}

class ItemBuild extends StatelessWidget {
  const ItemBuild({
    super.key,
    required this.countText,
    required this.item,
  });

  final String countText;
  final Azkar item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).dividerColor.withValues(alpha: .2),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    countText,
                    style: TextStyle(
                      color: context.textDarkColor,
                      fontSize: 12,
                      fontFamily: 'cairo',
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.repeat,
                    size: 18,
                    color: context.textDarkColor,
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
              tooltip: 'share',
              onPressed: () {
                final shareText = [
                  item.category ?? '',
                  '',
                  item.zekr ?? '',
                  '',
                  if ((item.description ?? '').isNotEmpty)
                    '| ${item.description}.',
                  if ((item.count ?? '').isNotEmpty) '(التكرار: ${item.count})',
                ].join('\n');
                SharePlus.instance.share(ShareParams(text: shareText.trim()));
              },
              icon: Icon(
                Icons.share,
                color: context.textDarkColor,
                size: 20,
              ),
            ),
            IconButton(
              tooltip: 'copy',
              onPressed: () {
                final copyText = [
                  item.category ?? '',
                  '',
                  item.zekr ?? '',
                  '',
                  if ((item.description ?? '').isNotEmpty)
                    '| ${item.description}.',
                  if ((item.count ?? '').isNotEmpty) '(التكرار: ${item.count})',
                ].join('\n');
                Clipboard.setData(ClipboardData(text: copyText.trim()));
                customSnackBar(context, 'copyAzkarText'.tr);
              },
              icon: Icon(
                Icons.copy,
                color: context.textDarkColor,
                size: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Obx(() {
          return TextRenderer(
            child: SelectableText(
              item.zekr ?? '',
              style: TextStyle(
                color: context.textDarkColor,
                height: 1.6,
                fontFamily: 'naskh',
                fontSize: sl<GeneralController>().fontSizeArabic.value,
              ),
              showCursor: true,
              cursorWidth: 3,
              cursorColor: Theme.of(context).dividerColor,
              cursorRadius: const Radius.circular(5),
              scrollPhysics: const ClampingScrollPhysics(),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.justify,
            ),
          );
        }),
        if ((item.description ?? '').isNotEmpty) ...[
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.surface.withValues(alpha: .4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextRenderer(
              child: Text(
                item.description ?? '',
                style: TextStyle(
                  color: context.textDarkColor,
                  fontSize: 14,
                  fontFamily: 'cairo',
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
        const SizedBox(height: 8),
        TextRenderer(
          child: Text(
            item.reference ?? '',
            style: TextStyle(
              color: context.textDarkColor.withValues(alpha: .7),
              fontSize: 12,
              fontFamily: 'cairo',
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
