import 'dart:developer';

import 'package:alheekmahlib_website/core/utils/constants/extensions/svg_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_library/quran_library.dart';
import 'package:quran_library/src/audio/audio.dart';

import '/core/utils/constants/extensions/dimensions.dart';
import '../../controllers/theme_controller.dart';
import '../controllers/quran_screen_controller.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<QuranScreenController>()) {
      Get.put(QuranScreenController());
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 48.0),
        child: GetBuilder<QuranCtrl>(
          id: 'clearSelection',
          builder: (quranCtrl) => QuranLibraryScreen(
            parentContext: context,
            juzName: 'juz'.tr,
            sajdaName: 'sajda'.tr,
            withPageView: true,
            useDefaultAppBar: true,
            isShowAudioSlider: true,
            showAyahBookmarkedIcon: false,
            isDark: ThemeController.instance.isDarkMode,
            languageCode: Get.locale!.languageCode,
            backgroundColor: context.theme.colorScheme.surface,
            textColor: context.textDarkColor,
            ayahSelectedBackgroundColor:
                context.theme.colorScheme.primary.withValues(alpha: .2),
            ayahIconColor: context.theme.colorScheme.primary,
            anotherMenuChild: Icon(Icons.play_arrow_outlined,
                size: 28, color: context.theme.colorScheme.primary),
            anotherMenuChildOnTap: (ayah) {
              // SurahAudioController.instance.state.currentAyahUnequeNumber =
              //     ayah.ayahUQNumber;
              AudioCtrl.instance
                  .playAyah(context, ayah.ayahUQNumber, playSingleAyah: true);
              log('Another Menu Child Tapped: ${ayah.ayahUQNumber}');
            },
            surahInfoStyle: SurahInfoStyle(
              ayahCount: 'aya_count'.tr,
              backgroundColor: context.theme.colorScheme.surface,
              closeIconColor: context.textDarkColor,
              firstTabText: 'surahNames'.tr,
              secondTabText: 'aboutSurah'.tr,
              indicatorColor: context.theme.colorScheme.primary,
              primaryColor:
                  context.theme.colorScheme.primary.withValues(alpha: .2),
              surahNameColor: context.textDarkColor,
              surahNumberColor: context.theme.colorScheme.primary,
              textColor: context.textDarkColor,
              titleColor: context.textDarkColor,
              bottomSheetWidth: 500,
            ),
            basmalaStyle: BasmalaStyle(
              basmalaColor: context.textDarkColor.withValues(alpha: .8),
              basmalaFontSize: 120.0,
            ),
            surahNameStyle: SurahNameStyle(),
            ayahStyle: AyahAudioStyle(
              backgroundColor: context.theme.colorScheme.surface,
              dialogBackgroundColor: context.theme.colorScheme.surface,
              playIconColor: context.iconsDarkColor,
              readerNameInItemColor: context.textDarkColor,
              seekBarActiveTrackColor: context.iconsDarkColor,
              seekBarThumbColor: context.theme.colorScheme.primary,
              textColor: context.iconsDarkColor,
              dialogCloseIconColor: context.theme.colorScheme.primary,
              seekBarTimeContainerColor: context.theme.colorScheme.primary,
              dialogHeaderBackgroundGradient: LinearGradient(colors: [
                context.theme.colorScheme.primary.withValues(alpha: .7),
                context.theme.colorScheme.primary.withValues(alpha: .3),
              ]),
              dialogHeaderTitleColor: context.textDarkColor,
              dialogReaderTextColor: context.textDarkColor,
              dialogSelectedReaderColor: context.theme.colorScheme.primary,
              dialogUnSelectedReaderColor: context.textDarkColor,
              dialogWidth: 300,
            ),
            surahStyle: SurahAudioStyle(),
            topBarStyle: QuranTopBarStyle(
              backgroundColor: context.theme.colorScheme.surface,
              iconColor: context.theme.colorScheme.primary,
              accentColor: context.theme.colorScheme.primary,
              textColor: context.textDarkColor,
              showAudioButton: false,
              showFontsButton: false,
            ),
            indexTabStyle: IndexTabStyle(
              accentColor: context.theme.colorScheme.primary,
              textColor: context.textDarkColor,
              unselectedLabelColor: context.textDarkColor.withValues(alpha: .6),
              labelColor: context.textDarkColor,
            ),
            searchTabStyle: SearchTabStyle(
              accentColor: context.theme.colorScheme.primary,
              textColor: context.textDarkColor,
              resultsDividerColor:
                  context.theme.colorScheme.primary.withValues(alpha: .5),
              surahChipBgColor:
                  context.theme.colorScheme.primary.withValues(alpha: .8),
            ),
            ayahLongClickStyle: AyahLongClickStyle(
              backgroundColor: context.theme.colorScheme.surface,
              borderColor:
                  context.theme.colorScheme.primary.withValues(alpha: .5),
              copyIconColor: context.theme.colorScheme.primary,
              dividerColor:
                  context.theme.colorScheme.primary.withValues(alpha: .5),
              tafsirIconColor: context.theme.colorScheme.primary,
              copySuccessMessage: 'ayah_copied'.tr,
            ),
            tafsirStyle: TafsirStyle(
              widthOfBottomSheet: 500,
              heightOfBottomSheet: MediaQuery.sizeOf(context).height * 0.9,
              changeTafsirDialogHeight: MediaQuery.sizeOf(context).height * 0.9,
              changeTafsirDialogWidth: 400,
              backgroundColor: context.theme.colorScheme.surface,
              textColor: context.textDarkColor,
              backgroundTitleColor: context.theme.colorScheme.primary,
              currentTafsirColor: context.theme.colorScheme.primary,
              textTitleColor: Colors.white,
              dividerColor:
                  context.theme.colorScheme.primary.withValues(alpha: .5),
              selectedTafsirBorderColor: context.theme.colorScheme.primary,
              selectedTafsirColor: context.theme.colorScheme.primary,
              selectedTafsirTextColor: context.textDarkColor,
              unSelectedTafsirColor:
                  context.theme.colorScheme.primary.withValues(alpha: .5),
              unSelectedTafsirTextColor:
                  context.textDarkColor.withValues(alpha: .8),
              unSelectedTafsirBorderColor:
                  context.theme.colorScheme.primary.withValues(alpha: .5),
              tafsirNameWidget: customSvgWithCustomColor(
                'assets/svg/tafseer_white.svg',
                color: context.theme.colorScheme.primary,
                height: 24,
              ),
              tafsirName: 'tafsir'.tr,
              translateName: 'translate'.tr,
              tafsirIsEmptyNote: 'tafsirIsEmptyNote'.tr,
              footnotesName: 'footnotes'.tr,
              fontSizeBackgroundColor:
                  context.theme.colorScheme.primary.withValues(alpha: .7),
              fontSizeActiveTrackColor: context.theme.colorScheme.primary,
              fontSizeInactiveTrackColor: context.textDarkColor,
              fontSizeThumbColor: context.theme.colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
