import 'package:alheekmahlib_website/core/utils/constants/extensions/dimensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../core/services/services_locator.dart';
import '../../controllers/translate_controller.dart';
import '../controllers/audio_controller.dart';
import '../controllers/ayat_controller.dart';
import '../controllers/quranText_controller.dart';
import '../model/QuranModel.dart';
import '../screens/text_page_view.dart';
import 'page_ayah.dart';
import 'single_ayah.dart';
import 'widgets.dart';

class ScrollableList extends StatefulWidget {
  final SurahText surah;
  final int nomPageF;
  final int nomPageL;
  const ScrollableList(
      {super.key,
      required this.surah,
      required this.nomPageF,
      required this.nomPageL});

  @override
  State<ScrollableList> createState() => _ScrollableListState();
}

class _ScrollableListState extends State<ScrollableList> {
  Color? backColor;

  // int? get isHeighlited {
  //   if (sl<AudioController>().ayahSelected.value == -1) return null;
  //
  //   final i = widget.surah.ayahs!
  //       .firstWhereOrNull(
  //           (a) => a == widget.surah.ayahs![audioController.ayahSelected.value])
  //       ?.numberInSurah;
  //   return i;
  // }
  int? get isHeighlited {
    if (sl<AudioController>().ayahSelected.value == -1) return null;
    if (widget.surah.ayahs == null ||
        sl<AudioController>().ayahSelected.value >=
            widget.surah.ayahs!.length ||
        sl<AudioController>().ayahSelected.value < 0) {
      return null;
    }

    final i = widget.surah.ayahs!
        .firstWhereOrNull((a) =>
            a ==
            widget.surah.ayahs![sl<AudioController>().ayahSelected.value - 1])
        ?.numberInSurah;
    sl<AudioController>().update();
    return i;
  }

  // int? get isHeighlited {
  //   if (heighlitedAyah.value == -1) return null;
  //
  //   final i = surahs[currentSurah.number - 1]
  //       .ayahs
  //       .firstWhereOrNull((a) => a == allAyahs[heighlitedAyah.value - 1])
  //       ?.number;
  //   return i ;
  // }

  @override
  Widget build(BuildContext context) {
    backColor = Theme.of(context).highlightColor;
    var textController = sl<QuranTextController>();
    return Obx(() {
      return ScrollablePositionedList.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        addAutomaticKeepAlives: false,
        // controller: sl<QuranTextController>().scrollController,
        itemScrollController: textController.itemScrollController,
        itemPositionsListener: textController.itemPositionsListener,
        itemCount: textController.value.value == 1
            ? widget.surah.ayahs!.length
            : (widget.nomPageL - widget.nomPageF) + 1,
        itemBuilder: (context, index) {
          List<InlineSpan> text = [];
          // int ayahLenght = textController.currentSurahAyahs.length;
          int ayahLenght = widget.surah.ayahs!.length;
          if (textController.value.value == 1) {
            for (int index = 0; index < ayahLenght; index++) {
              if (widget.surah.ayahs![index].text!.length > 1) {
                textController.sajda2 = widget.surah.ayahs![index].sajda;
                sl<AyatController>().surahTextNumber.value =
                    widget.surah.number!.toString();
                sl<AyatController>().ayahTextNumber.value =
                    widget.surah.ayahs![index].numberInSurah.toString();
                // lastAyah = textController.currentSurahAyahs.last.numberInSurah;
              }
            }
          } else {
            // textController.setSurahsPages();
            // textController.surahPagesList
            for (int b = 0; b < ayahLenght; b++) {
              if (widget.surah.ayahs![b].text!.length > 1) {
                if (widget.surah.ayahs![b].page == (index + widget.nomPageF)) {
                  textController.juz = widget.surah.ayahs![b].juz.toString();
                  textController.sajda = widget.surah.ayahs![b].sajda;
                  sl<AudioController>().lastAyah(pageN, widget);
                  // text2 = surah!.ayahs![b].text! as List<String>;
                  text.add(TextSpan(children: <InlineSpan>[
                    TextSpan(
                        text:
                            ' ${widget.surah.ayahs![b].text!} ${arabicNumber.convert(widget.surah.ayahs![b].numberInSurah.toString())}',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'uthmanic2',
                          background: Paint()
                            ..color = widget.surah.ayahs![b].numberInSurah ==
                                    sl<AudioController>().ayahSelected.value
                                ? textController.selected.value
                                    ? backColor!
                                    : Colors.transparent
                                : Colors.transparent
                            ..strokeJoin = StrokeJoin.round
                            ..strokeCap = StrokeCap.round
                            ..style = PaintingStyle.fill,
                          color: context.textDarkColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTapDown = (TapDownDetails details) {
                            pageN = widget.surah.ayahs![b].pageInSurah! - 1;
                            sl<AudioController>().lastAyahInTextPage.value =
                                widget.surah.ayahs!
                                    .firstWhere((e) =>
                                        widget
                                            .surah.ayahs!.last.numberInSurah ==
                                        e.numberInSurah)
                                    .numberInSurah!;
                            textSurahNum = widget.surah.number;
                            menu(
                                context,
                                b,
                                index,
                                details: details,
                                sl<TranslateDataController>().data,
                                widget.surah,
                                widget.nomPageF,
                                widget.nomPageL);
                            textController.selected.value =
                                !textController.selected.value;
                            // backColor = Colors.transparent;
                            sl<AyatController>().surahTextNumber.value =
                                widget.surah.number!.toString();
                            sl<AyatController>().ayahTextNumber.value =
                                widget.surah.ayahs![b].numberInSurah.toString();
                            sl<AudioController>().ayahSelected.value =
                                widget.surah.ayahs![b].numberInSurah!;
                            setState(() {});
                          })
                  ]));
                }
              }
            }
          }
          return Obx(
            () => textController.value.value == 1
                ? SingleAyah(
                    surah: widget.surah,
                    index: index,
                    nomPageF: widget.nomPageF,
                    nomPageL: widget.nomPageL)
                : PageAyah(
                    surah: widget.surah,
                    text: text,
                    index: index,
                    nomPageF: widget.nomPageF),
          );
        },
      );
    });
  }
}

// class CustomTextSpan extends TextSpan {
//   // final TextSpan _textSpan;
//   // CustomTextSpan(this._textSpan);
//   CustomTextSpan view(TextSpan _textSpan) => Obx(() => _textSpan as Widget);
// }
