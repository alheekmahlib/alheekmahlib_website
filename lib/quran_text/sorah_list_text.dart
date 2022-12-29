import 'dart:convert';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theme_provider/theme_provider.dart';
import '../l10n/app_localizations.dart';
import '../shared/widgets/widgets.dart';
import 'model/sorah.dart';
import 'text_page_view.dart';
import 'model/QuranModel.dart';
import 'repository/quranApi.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart' as rootBundle;

class SorahListText extends StatefulWidget {
  const SorahListText({super.key});

  @override
  _SorahListTextState createState() => _SorahListTextState();
}

class _SorahListTextState extends State<SorahListText>
    with SingleTickerProviderStateMixin {
  List<Sorah>? sorahList;
  final ScrollController controller = ScrollController();
  var sorahListKey = GlobalKey<ScaffoldState>();
  Widget? textPage;


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    QuranServer quranServer = QuranServer();
    ArabicNumbers arabicNumber = ArabicNumbers();
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: Stack(
        children: [
          Container(
            color: Theme.of(context).backgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: FutureBuilder(
                        future: quranServer.QuranData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<SurahText> surah = snapshot.data!;
                            return AnimationLimiter(
                              child: Scrollbar(
                                controller: controller,
                                thumbVisibility: true,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: surah.length,
                                    controller: controller,
                                    itemBuilder: (_, index) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 450),
                                        child: SlideAnimation(
                                          verticalOffset: 50.0,
                                          child: FadeInAnimation(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    animatRoute(TextPageView(
                                                  surah: surah[index],
                                                  nomPageF: surah[index]
                                                      .ayahs!
                                                      .first
                                                      .page!,
                                                  nomPageL: surah[index]
                                                      .ayahs!
                                                      .last
                                                      .page!,
                                                )));
                                              },
                                              child: Container(
                                                  height: 90,
                                                  color: (index % 2 == 0
                                                      ? Theme.of(context)
                                                          .backgroundColor
                                                      : Theme.of(context)
                                                          .dividerColor
                                                          .withOpacity(.3)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8),
                                                    child: Row(
                                                      children: [
                                                        Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            SvgPicture
                                                                .asset(
                                                                  'assets/svg/sora_num.svg',
                                                              height: 50,
                                                              width: 50,
                                                                ),
                                                            Text(
                                                              arabicNumber.convert(surah[index].number.toString()),
                                                              style: TextStyle(
                                                                  color: ThemeProvider.themeOf(context)
                                                                              .id ==
                                                                          'dark'
                                                                      ? Theme.of(
                                                                              context)
                                                                          .canvasColor
                                                                      : Theme.of(
                                                                              context)
                                                                          .primaryColorLight,
                                                                  fontFamily:
                                                                      "kufi",
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            width: 100,),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/svg/surah_name/00${index + 1}.svg',
                                                              color: ThemeProvider.themeOf(
                                                                              context)
                                                                          .id ==
                                                                      'dark'
                                                                  ? Theme.of(
                                                                          context)
                                                                      .canvasColor
                                                                  : Theme.of(
                                                                          context)
                                                                      .primaryColorDark,
                                                              width: 150,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          8.0),
                                                              child: Text(
                                                                surah[index].englishName!,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "kufi",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: ThemeProvider.themeOf(context)
                                                                              .id ==
                                                                          'dark'
                                                                      ? Theme.of(
                                                                              context)
                                                                          .canvasColor
                                                                      : Theme.of(
                                                                              context)
                                                                          .primaryColorLight,
                                                                ),
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
                          } else {
                            return Center(
                              child: Lottie.asset('assets/lottie/loading.json',
                                  width: 200, height: 200),
                            );
                          }
                        }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<SurahText>> QuranData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/quran.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => SurahText.fromJson(e)).toList();
  }
}
