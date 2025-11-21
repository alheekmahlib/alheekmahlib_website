import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_library/quran_library.dart';

import '/core/utils/constants/extensions/dimensions.dart';
import '/core/utils/constants/extensions/svg_extensions.dart';
import '../../controllers/theme_controller.dart';
import '../controllers/quran_screen_controller.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<QuranScreenController>()) {
      Get.put(QuranScreenController());
    }
    final isDark = ThemeController.instance.isDarkMode;
    final isLoadedFont = QuranLibrary.quranCtrl.state.loadedFontPages
        .contains(QuranLibrary.quranCtrl.state.currentPageNumber.value);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 48.0),
        child: GetBuilder<QuranCtrl>(
          id: 'clearSelection',
          builder: (quranCtrl) => QuranLibraryScreen(
            parentContext: context,
            withPageView: true,
            useDefaultAppBar: true,
            isShowAudioSlider: true,
            showAyahBookmarkedIcon: false,
            isDark: isDark,
            appLanguageCode: Get.locale!.languageCode,
            backgroundColor: context.theme.colorScheme.surface,
            textColor: context.textDarkColor,
            ayahSelectedBackgroundColor:
                context.theme.colorScheme.primary.withValues(alpha: .2),
            ayahIconColor: context.theme.colorScheme.primary,
            // onPageChanged: (p) =>
            //     QuranScreenController.instance.onPageChanged(p),
            surahInfoStyle:
                SurahInfoStyle.defaults(isDark: isDark, context: context)
                    .copyWith(
              ayahCount: 'aya_count'.tr,
              firstTabText: 'surahNames'.tr,
              secondTabText: 'aboutSurah'.tr,
              bottomSheetWidth: 500,
            ),
            basmalaStyle: BasmalaStyle(
              verticalPadding: 0.0,
              basmalaColor: context.textDarkColor.withValues(alpha: .8),
              basmalaFontSize: isLoadedFont ? 120.0 : 25.0,
            ),
            ayahStyle: AyahAudioStyle.defaults(isDark: isDark, context: context)
                .copyWith(
              dialogWidth: 300,
              readersTabText: 'readers'.tr,
            ),
            topBarStyle:
                QuranTopBarStyle.defaults(isDark: isDark, context: context)
                    .copyWith(
              showAudioButton: false,
              showFontsButton: false,
              tabIndexLabel: 'index'.tr,
              tabBookmarksLabel: 'bookmarks'.tr,
              tabSearchLabel: 'search'.tr,
            ),
            indexTabStyle:
                IndexTabStyle.defaults(isDark: isDark, context: context)
                    .copyWith(
              tabSurahsLabel: 'surahs'.tr,
              tabJozzLabel: 'juzz'.tr,
            ),
            searchTabStyle:
                SearchTabStyle.defaults(isDark: isDark, context: context)
                    .copyWith(
              searchHintText: 'search'.tr,
            ),
            bookmarksTabStyle:
                BookmarksTabStyle.defaults(isDark: isDark, context: context)
                    .copyWith(
              emptyStateText: 'no_bookmarks_yet'.tr,
              greenGroupText: 'greenBookmarks'.tr,
              yellowGroupText: 'yellowBookmarks'.tr,
              redGroupText: 'redBookmarks'.tr,
            ),
            ayahMenuStyle:
                AyahMenuStyle.defaults(isDark: isDark, context: context)
                    .copyWith(
              copySuccessMessage: 'ayah_copied'.tr,
              showPlayAllButton: false,
            ),
            tafsirStyle:
                TafsirStyle.defaults(isDark: isDark, context: context).copyWith(
              widthOfBottomSheet: 500,
              heightOfBottomSheet: MediaQuery.sizeOf(context).height * 0.9,
              changeTafsirDialogHeight: MediaQuery.sizeOf(context).height * 0.9,
              changeTafsirDialogWidth: 400,
              tafsirNameWidget: customSvgWithCustomColor(
                'assets/svg/tafseer_white.svg',
                color: context.theme.colorScheme.primary,
                height: 24,
              ),
              tafsirName: 'tafsir'.tr,
              translateName: 'translate'.tr,
              tafsirIsEmptyNote: 'tafsirIsEmptyNote'.tr,
              footnotesName: 'footnotes'.tr,
            ),
            topBottomQuranStyle: TopBottomQuranStyle.defaults(
              isDark: isDark,
              context: context,
            ).copyWith(
              hizbName: 'hizb'.tr,
              juzName: 'juz'.tr,
              sajdaName: 'sajda'.tr,
            ),
          ),
        ),
      ),
    );
  }
}
