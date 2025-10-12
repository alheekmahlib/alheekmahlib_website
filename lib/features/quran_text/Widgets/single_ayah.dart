import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';

import '/core/utils/constants/extensions.dart';
import '/features/quran_text/Widgets/widgets.dart';
import '../../../core/services/controllers/general_controller.dart';
import '../../../core/services/controllers/quranText_controller.dart';
import '../../../core/services/controllers/settings_controller.dart';
import '../../../core/services/controllers/translate_controller.dart';
import '../../../core/utils/constants/lottie.dart';
import '../../../core/utils/constants/svg_picture.dart';
import '../../../services_locator.dart';
import '../../../shared/widgets/widgets.dart';
import 'text_overflow_detector.dart';

class SingleAyah extends StatelessWidget {
  final surah;
  final int index;
  final int nomPageF;
  final int nomPageL;
  const SingleAyah(
      {super.key,
      required this.surah,
      required this.index,
      required this.nomPageF,
      required this.nomPageL});

  @override
  Widget build(BuildContext context) {
    sl<QuranTextController>().backColor =
        Theme.of(context).colorScheme.surface.withValues(alpha: 0.4);
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            sl<GeneralController>().textWidgetPosition.value = -240;
            sl<QuranTextController>().backColor = Colors.transparent;
          },
          // child: AutoScrollTag(
          //   key: ValueKey(index),
          //   controller: sl<QuranTextController>().scrollController!,
          //   index: index,
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: screenSize(context, 0.0, 16.0), vertical: 4),
            padding: EdgeInsets.only(
                top: 64.0,
                right: screenSize(context, 0.0, 32.0),
                left: screenSize(context, 0.0, 32.0)),
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                surah!.number == 9
                    ? const SizedBox.shrink()
                    : surah!.ayahs![index].numberInSurah == 1
                        ? besmAllah(context)
                        : const SizedBox.shrink(),
                Obx(
                  () => TextRenderer(
                    child: SelectableText.rich(
                      showCursor: true,
                      cursorWidth: 3,
                      cursorColor: Theme.of(context).dividerColor,
                      cursorRadius: const Radius.circular(5),
                      scrollPhysics: const ClampingScrollPhysics(),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.justify,
                      TextSpan(children: [
                        TextSpan(
                          text:
                              '${surah!.ayahs![index].text!} ${arabicNumber.convert(surah!.ayahs![index].numberInSurah.toString())}',
                          style: TextStyle(
                            fontSize:
                                sl<GeneralController>().fontSizeArabic.value,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'uthmanic2',
                            color: context.textDarkColor,
                            // background: Paint()
                            //   ..color =
                            //       index == sl<AudioController>().ayahSelected.value
                            //           ? sl<QuranTextController>().selected.value
                            //               ? backColor
                            //               : Colors.transparent
                            //           : Colors.transparent
                            //   ..strokeJoin = StrokeJoin.round
                            //   ..strokeCap = StrokeCap.round
                            //   ..style = PaintingStyle.fill,
                          ),
                        ),
                      ]),
                      // contextMenuBuilder: buildMyContextMenuText(),
                      // onSelectionChanged: handleSelectionChanged,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Semantics(
                            button: true,
                            enabled: true,
                            label: 'Change The Translate',
                            child: Icon(
                              Icons.translate_rounded,
                              color: context.textDarkColor,
                              size: 24,
                            ),
                          ),
                          onPressed: () => translateDropDown(context),
                        )),
                    spaceLine(
                      15,
                      MediaQuery.sizeOf(context).width * 1 / 2,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: juzNumEn(
                        'Part\n${surah!.ayahs![index].juz}',
                        context,
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Obx(
                    () {
                      if (sl<TranslateDataController>().isLoading.value) {
                        return search(50.0, 50.0);
                      }
                      return TextRenderer(
                        child: ReadMoreLess(
                          text: (surah!.ayahs!.length > index &&
                                  sl<TranslateDataController>().data.length >
                                      surah!.ayahs![index].number - 1)
                              ? sl<TranslateDataController>()
                                          .data[surah!.ayahs![index].number - 1]
                                      ['text'] ??
                                  ''
                              : '',
                          textStyle: TextStyle(
                            fontSize:
                                sl<GeneralController>().fontSizeArabic.value -
                                    10,
                            fontFamily:
                                sl<SettingsController>().languageFont.value,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          readMoreText: 'readMore',
                          readLessText: 'readLess',
                          buttonTextStyle: TextStyle(
                            fontSize: 12,
                            fontFamily: 'cairo',
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Theme.of(context).primaryColorLight,
                          ),
                          iconColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Theme.of(context).primaryColorLight,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  juzNum(
                      '${surah!.ayahs![index].juz}',
                      context,
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      25),
                  singleAyahMenu(
                      context,
                      index,
                      index,
                      // details,
                      sl<TranslateDataController>().data,
                      surah,
                      nomPageF,
                      nomPageL),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
