import 'package:alheekmahlib_website/core/utils/constants/extensions.dart';
import 'package:alheekmahlib_website/features/quran_text/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';

import '../../../core/services/controllers/general_controller.dart';
import '../../../core/services/controllers/quranText_controller.dart';
import '../../../core/utils/constants/svg_picture.dart';
import '../../../services_locator.dart';
import '../../../shared/widgets/widgets.dart';

class PageAyah extends StatelessWidget {
  final surah;
  final List<InlineSpan> text;
  final int index;
  final int nomPageF;
  PageAyah(
      {super.key,
      required this.surah,
      required this.text,
      required this.index,
      required this.nomPageF});

  @override
  Widget build(BuildContext context) {
    sl<QuranTextController>().backColor =
        Theme.of(context).colorScheme.surface.withOpacity(0.4);
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            sl<GeneralController>().textWidgetPosition.value = -240;
          },
          // child: AutoScrollTag(
          //   key: ValueKey(index),
          //   controller: sl<QuranTextController>().scrollController!,
          //   index: index,
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: screenSize(context, 0.0, 16.0), vertical: 4),
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                surah!.number == 9
                    ? const SizedBox.shrink()
                    : surah!.ayahs![index].numberInSurah == 1
                        ? besmAllah(context)
                        : const SizedBox.shrink(),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize(context, 0.0, 32.0)),
                  child: Obx(() {
                    // allText = text.map((e) => e).toString();
                    return TextRenderer(
                      child: SelectableText.rich(
                        showCursor: true,
                        cursorWidth: 3,
                        cursorColor: Theme.of(context).dividerColor,
                        cursorRadius: const Radius.circular(5),
                        scrollPhysics: const ClampingScrollPhysics(),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.justify,
                        TextSpan(
                          style: TextStyle(
                            fontSize:
                                sl<GeneralController>().fontSizeArabic.value,
                            fontFamily: 'uthmanic2',
                            // background: Paint()
                            //   ..color = sl<AudioController>().determineColor(index)
                            //   ..strokeJoin = StrokeJoin.round
                            //   ..strokeCap = StrokeCap.round
                            //   ..style = PaintingStyle.fill,
                            // background: Paint()
                            //   ..color =
                            //       index == sl<AudioController>().ayahSelected.value
                            //           ? sl<QuranTextController>().selected.value
                            //               ? backColor!
                            //               : Colors.transparent
                            //           : Colors.transparent
                            //   ..strokeJoin = StrokeJoin.round
                            //   ..strokeCap = StrokeCap.round
                            //   ..style = PaintingStyle.fill
                          ),
                          // children: pageAyahsUI,
                          children: text.map((e) => e).toList(),
                        ),
                        // contextMenuBuilder: buildMyContextMenuText(),
                        // onSelectionChanged: handleSelectionChangedText,
                      ),
                    );
                  }),
                ),
                Center(
                  child: spaceLine(
                    20,
                    MediaQuery.sizeOf(context).width / 1 / 2,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: pageNumber(
                    arabicNumber.convert(nomPageF + index).toString(),
                    context,
                    Theme.of(context).primaryColorDark,
                  ),
                ),
              ],
            ),
          ),
          // ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
            child: juzNum('${sl<QuranTextController>().juz}', context,
                context.textDarkColor, 25),
          ),
        )
      ],
    );
  }
}
