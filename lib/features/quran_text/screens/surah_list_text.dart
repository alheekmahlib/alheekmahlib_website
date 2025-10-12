import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';

import '/core/utils/constants/extensions.dart';
import '../../../core/services/controllers/quranText_controller.dart';
import '../../../core/services/controllers/surahTextController.dart';
import '../../../core/services/controllers/translate_controller.dart';
import '../../../core/utils/constants/lottie.dart';
import '../../../services_locator.dart';

class SorahListText extends StatelessWidget {
  SorahListText({super.key});

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    sl<TranslateDataController>().loadTranslateValue();
    ArabicNumbers arabicNumber = ArabicNumbers();
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Obx(
                () {
                  if (sl<SurahTextController>().surahs.isEmpty) {
                    return Center(
                      child: loadingLottie(200.0, 200.0),
                    );
                  }
                  return AnimationLimiter(
                    child: Scrollbar(
                      controller: controller,
                      thumbVisibility: true,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: sl<SurahTextController>().surahs.length,
                          controller: controller,
                          padding: EdgeInsets.zero,
                          itemBuilder: (_, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 450),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: GestureDetector(
                                    onTap: () {
                                      sl<QuranTextController>()
                                          .currentSurahIndex = index + 1;
                                      context.go('/quran/surah/${index + 1}');
                                    },
                                    child: Container(
                                        height: 60,
                                        color: (index % 2 == 0
                                            ? Theme.of(context)
                                                .colorScheme
                                                .surface
                                            : Theme.of(context)
                                                .colorScheme
                                                .surface
                                                .withValues(alpha: .3)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  SizedBox(
                                                      height: 40,
                                                      width: 40,
                                                      child: SvgPicture.asset(
                                                        'assets/svg/sora_num.svg',
                                                      )),
                                                  Text(
                                                    arabicNumber.convert(
                                                        sl<SurahTextController>()
                                                            .surahs[index]
                                                            .number
                                                            .toString()),
                                                    style: TextStyle(
                                                        color: context
                                                            .textDarkColor,
                                                        fontFamily: "cairo",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        height: 2),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/svg/surah_name/00${index + 1}.svg',
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            context
                                                                .textDarkColor,
                                                            BlendMode.srcIn),
                                                    width: 100,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: TextRenderer(
                                                      child: Text(
                                                        sl<SurahTextController>()
                                                            .surahs[index]
                                                            .englishName!,
                                                        style: TextStyle(
                                                          fontFamily: "cairo",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 10,
                                                          color: context
                                                              .textDarkColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "| ${'aya_count'.tr} |",
                                                    style: TextStyle(
                                                      fontFamily: "uthman",
                                                      fontSize: 12,
                                                      color:
                                                          context.textDarkColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    "| ${arabicNumber.convert(sl<SurahTextController>().surahs[index].ayahs!.last.numberInSurah)} |",
                                                    style: TextStyle(
                                                      fontFamily: "cairo",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          context.textDarkColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
