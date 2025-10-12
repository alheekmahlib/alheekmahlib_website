import 'dart:developer';

import 'package:alheekmahlib_website/core/utils/constants/extensions.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/services/shared_pref_services.dart';
import '../../../core/utils/constants/lists.dart';
import '../../../core/utils/constants/shared_preferences_constants.dart';
import '../../../core/widgets/widgets.dart';
import '../../controllers/general_controller.dart';
import '../../controllers/translate_controller.dart';
import '../controllers/ayat_controller.dart';
import '../controllers/quranText_controller.dart';

ArabicNumbers arabicNumber = ArabicNumbers();

menu(BuildContext context, int b, index, translateData, widget, nomPageF,
    nomPageL,
    {var details}) {
  bool? selectedValue;
  if (sl<QuranTextController>().value == 1) {
    selectedValue = true;
  } else if (sl<QuranTextController>().value == 0) {
    selectedValue = false;
  }
  sl<QuranTextController>().selected.value == selectedValue!
      ? BotToast.showAttachedWidget(
          target: details.globalPosition,
          verticalOffset: sl<QuranTextController>().verticalOffset,
          horizontalOffset: sl<QuranTextController>().horizontalOffset,
          preferDirection: sl<QuranTextController>().preferDirection,
          animationDuration: const Duration(microseconds: 700),
          animationReverseDuration: const Duration(microseconds: 700),
          attachedBuilder: (cancel) => Card(
            color: context.textDarkColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                color: Color(0xfff3efdf),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                          Semantics(
                            button: true,
                            enabled: true,
                            label: 'Copy Ayah',
                            child: Icon(
                              Icons.copy_outlined,
                              size: 22,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () async {
                      sl<QuranTextController>().selected.value =
                          !sl<QuranTextController>().selected.value;
                      await Clipboard.setData(ClipboardData(
                              text:
                                  '﴿${widget.ayahs![b].text}﴾ [${widget.name}-${arabicNumber.convert(widget.ayahs![b].numberInSurah.toString())}]'))
                          .then((value) =>
                              customSnackBar(context, 'copyAyah'.tr));
                      cancel();
                    },
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  GestureDetector(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                color: Color(0xfff3efdf),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                          Semantics(
                            button: true,
                            enabled: true,
                            label: 'Play Ayah',
                            child: Icon(
                              Icons.play_arrow_outlined,
                              size: 24,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      sl<GeneralController>().textWidgetPosition.value = 0.0;
                      sl<QuranTextController>().selected.value =
                          !sl<QuranTextController>().selected.value;
                      // sl<GeneralController>().sliderIsShow();
                      // springController.play(motion: Motion.play);
                      // switch (sl<QuranTextController>().controller.status) {
                      //   case AnimationStatus.dismissed:
                      //     sl<QuranTextController>().controller.forward();
                      //     break;
                      //   case AnimationStatus.completed:
                      //     sl<QuranTextController>().controller.reverse();
                      //     break;
                      //   default:
                      // }
                      cancel();
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      : null;
}

singleAyahMenu(BuildContext context, int b, index, translateData, widget,
    nomPageF, nomPageL,
    {var details}) {
  // sl<AyatController>().fetchAyat(sl<GeneralController>().currentPage.value);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          child: SizedBox(
            height: 30,
            width: 30,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      color: Color(0xfff3efdf),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                Semantics(
                  button: true,
                  enabled: true,
                  label: 'Copy Ayah',
                  child: Icon(
                    Icons.copy_outlined,
                    size: 24,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ],
            ),
          ),
          onTap: () async {
            sl<QuranTextController>().selected.value =
                !sl<QuranTextController>().selected.value;
            await Clipboard.setData(ClipboardData(
                    text:
                        '﴿${widget.ayahs![b].text}﴾ [${widget.name}-${arabicNumber.convert(widget.ayahs![b].numberInSurah.toString())}]'))
                .then((value) => customSnackBar(context, 'copyAyah'.tr));
          },
        ),
        const SizedBox(
          width: 8.0,
        ),
        GestureDetector(
          child: SizedBox(
            height: 30,
            width: 30,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      color: Color(0xfff3efdf),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                Semantics(
                  button: true,
                  enabled: true,
                  label: 'Play Ayah',
                  child: Icon(
                    Icons.play_arrow_outlined,
                    size: 24,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            sl<AyatController>().ayahTextNumber.value = (index + 1).toString();
            log('sl<AyatController>().ayahTextNumber.value ${sl<AyatController>().ayahTextNumber.value}');
            sl<AyatController>().surahTextNumber.value =
                widget.number!.toString();
            sl<GeneralController>().textWidgetPosition.value = 0.0;
            sl<QuranTextController>().selected.value =
                !sl<QuranTextController>().selected.value;
          },
        ),
      ],
    ),
  );
}

Widget animatedToggleSwitch(BuildContext context) {
  return GetX<QuranTextController>(
    builder: (controller) {
      return AnimatedToggleSwitch<int>.rolling(
        current: controller.value.value,
        values: const [0, 1],
        onChanged: (i) async {
          controller.value.value = i;
          await sl<SharedPrefServices>().saveInteger(SWITCH_VALUE, i);
          sl<GeneralController>().textWidgetPosition.value = -240.0;
          sl<QuranTextController>().selected.value = false;
        },
        iconBuilder: rollingIconBuilder,
        borderWidth: 1,
        style: ToggleStyle(
          indicatorColor: context.textDarkColor,
          backgroundColor: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          // dif: 2.0,
          borderColor: Theme.of(context).colorScheme.surface,
        ),
        height: 25,
      );
    },
  );
}

Widget rollingIconBuilder(int value, bool foreground) {
  IconData data = Icons.textsms_outlined;
  if (value.isEven) data = Icons.text_snippet_outlined;
  return Semantics(
    button: true,
    enabled: true,
    label:
        'Changing from presenting the Qur’an in the form of pages and in the form of verses',
    child: Icon(
      data,
      size: 20,
      color: const Color(0xffcdba72),
    ),
  );
}

translateDropDown(BuildContext outerContext) {
  dropDownModalBottomSheet(
    outerContext,
    MediaQuery.sizeOf(outerContext).height / 1 / 2,
    screenSize(outerContext, MediaQuery.sizeOf(outerContext).width * .7, 400),
    Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  height: 30,
                  width: 30,
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                          width: 2, color: Theme.of(context).dividerColor)),
                  child: Semantics(
                    button: true,
                    enabled: true,
                    label: 'Close',
                    child: Icon(
                      Icons.close_outlined,
                      color: context.textDarkColor,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Semantics(
                  button: true,
                  enabled: true,
                  label: 'Translate',
                  child: Text(
                    'translation'.tr,
                    style: TextStyle(
                        color: context.textDarkColor,
                        fontSize: 18,
                        fontFamily: "cairo"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: ListView.builder(
                itemCount: translateName.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            border: Border.all(
                                color: Theme.of(context).dividerColor,
                                width: 1)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0),
                        child: Obx(
                          () => ListTile(
                            title: Text(
                              translateName[index],
                              style: TextStyle(
                                  color: sl<TranslateDataController>()
                                              .transValue
                                              .value ==
                                          index
                                      ? context.textDarkColor
                                      : const Color(0xffcdba72),
                                  fontSize: 14,
                                  fontFamily: "cairo"),
                            ),
                            trailing: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(2.0)),
                                border: Border.all(
                                    color: sl<TranslateDataController>()
                                                .transValue
                                                .value ==
                                            index
                                        ? Theme.of(context).primaryColorLight
                                        : const Color(0xffcdba72),
                                    width: 2),
                                color: const Color(0xff39412a),
                              ),
                              child: sl<TranslateDataController>()
                                          .transValue
                                          .value ==
                                      index
                                  ? const Icon(Icons.done,
                                      size: 14, color: Color(0xffcdba72))
                                  : null,
                            ),
                            onTap: () async {
                              sl<TranslateDataController>().transValue.value ==
                                  index;
                              await sl<SharedPrefServices>()
                                  .saveInteger(TRANSLATE_VALUE, index);
                              sl<TranslateDataController>()
                                  .translateHandleRadioValueChanged(index);
                              sl<TranslateDataController>().fetchSura(context);
                              Navigator.pop(context);
                            },
                            leading: Container(
                                height: 85.0,
                                width: 41.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0)),
                                    border: Border.all(
                                        color: Theme.of(context).dividerColor,
                                        width: 2)),
                                child: Opacity(
                                  opacity: sl<TranslateDataController>()
                                              .transValue
                                              .value ==
                                          index
                                      ? 1
                                      : .4,
                                  child: SvgPicture.asset(
                                    'assets/svg/tafseer_book.svg',
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    }),
  );
}

Widget greeting(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Text(
      '| ${sl<GeneralController>().greeting.value} |',
      style: TextStyle(
        fontSize: 16.0,
        fontFamily: 'cairo',
        color: context.textDarkColor,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget hijriDate2(BuildContext context) {
  var today = HijriCalendar.now();
  'appLang'.tr == "لغة التطبيق"
      ? HijriCalendar.setLocal('ar')
      : HijriCalendar.setLocal('en');
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset('assets/svg/hijri/${today.hMonth}.svg',
          height: 70.0,
          colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColorDark, BlendMode.srcIn)),
      const SizedBox(
        height: 8.0,
      ),
      Text(
        '${today.hDay} / ${today.hMonth} / ${today.hYear} هـ \n ${today.dayWeName}',
        style: TextStyle(
          fontSize: 20.0,
          fontFamily: 'cairo',
          color: context.textDarkColor,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget audioContainer(BuildContext context, Widget myWidget,
    {double? height, double? width}) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
        alignment: Alignment.topCenter,
        height: height ?? 124,
        width: width ?? 400,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          // boxShadow: [
          //   BoxShadow(
          //     offset: const Offset(0, -2),
          //     blurRadius: 10,
          //     color: Theme.of(context).colorScheme.surface,
          //   ),
          // ],
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: myWidget,
        )),
  );
}
