import 'package:alheekmahlib_website/core/utils/constants/extensions/dimensions.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/widgets/font_size_drop_down.dart';
import '../../../core/widgets/widgets.dart';
import '../../controllers/general_controller.dart';
import '../../controllers/translate_controller.dart';
import '../Widgets/audio_text_widget.dart';
import '../Widgets/scrollable_list.dart';
import '../Widgets/widgets.dart';
import '../controllers/quranText_controller.dart';
import '../model/QuranModel.dart';

int? lastAyahInPageA;
int pageN = 1;
int? textSurahNum;

// ignore: must_be_immutable
class TextPageView extends StatelessWidget {
  final SurahText? surah;
  int? nomPageF, nomPageL, pageNum = 1;

  TextPageView({
    super.key,
    // Key? key,
    this.nomPageF,
    this.nomPageL,
    this.pageNum,
    this.surah,
  });
  static int textCurrentPage = 0;
  static String lastTime = '';
  static String sorahTextName = '';

  ArabicNumbers arabicNumber = ArabicNumbers();
  String? translateText;
  Color? backColor;

  @override
  Widget build(BuildContext context) {
    sl<QuranTextController>().loadSwitchValue();
    sl<TranslateDataController>().fetchSura(context);
    sl<TranslateDataController>().loadTranslateValue();

    backColor = const Color(0xff91a57d).withValues(alpha: 0.4);

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => sl<QuranTextController>().jumbToPage(pageNum));
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: sorahName(
              sl<QuranTextController>().currentSurahIndex.toString(),
              context,
              context.textDarkColor,
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
                )),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    const FontSizeDropDown(position: PopupMenuPosition.under),
                    SizedBox(
                      width: 70,
                      child: animatedToggleSwitch(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 16.0, right: 40.0, left: 40.0),
                    child: ScrollableList(
                      surah: surah!,
                      nomPageF: nomPageF!,
                      nomPageL: nomPageL!,
                    ),
                  ),
                ),
                Obx(() => AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    bottom: sl<GeneralController>().textWidgetPosition.value,
                    left: 0,
                    right: 0,
                    child: const AudioTextWidget())),
              ],
            ),
          )),
    );
  }
}
