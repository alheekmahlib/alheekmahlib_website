import 'package:alheekmahlib_website/presentation/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:quran_library/quran_library.dart';

class QuranSoundScreen extends StatelessWidget {
  const QuranSoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48.0),
      child: SurahAudioScreen(
        style: SurahAudioStyle.defaults(
          isDark: ThemeController.instance.isDarkMode,
          context: context,
        ).copyWith(
          withAppBar: false,
          ayahSingularText: 'ayah'.tr,
          ayahPluralText: 'ayahs'.tr,
          lastListenText: 'last_listen'.tr,
        ),
      ),
    );
  }
}
