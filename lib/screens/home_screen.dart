import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:lottie/lottie.dart';
import 'package:theme_provider/theme_provider.dart';

import '../shared/widgets/settings_popUp.dart';
import '../shared/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late InfiniteScrollController _controller;
  int _selectedIndex = 0;



  @override
  void initState() {
    _controller = InfiniteScrollController(initialItem: _selectedIndex);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<String> quranScreen = [
    'assets/apps_images/screen 0.jpg',
    'assets/apps_images/screen 1.jpg',
    'assets/apps_images/screen 2.jpg',
    'assets/apps_images/screen 3.jpg',
    'assets/apps_images/screen 4.jpg',
  ];

  List<String> banner = [
    'assets/apps_banner/feature_graphic.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).backgroundColor,
      child: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: .05,
              child: SvgPicture.asset(
                'assets/svg/alheekmah_logo.svg',
                width: MediaQuery.of(context).size.width,
                color: ThemeProvider.themeOf(context).id ==
                    'dark'
                    ? Colors.white.withOpacity(.2)
                    : Theme.of(context).bottomAppBarColor,
              ),
            ),
          ),
          ListView(
            children: [
              SizedBox(
                // height: 400,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(right: 90.0, left: 90.0, top: 100.0),
                  child: customContainer(
                    context,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Lottie.asset('assets/lottie/loading.json',
                              width: 200, height: 200),
                        ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/alheekmah_logo.svg',
                                width: 100,
                                color: ThemeProvider.themeOf(context).id ==
                                    'dark'
                                    ? Colors.white
                                    : Theme.of(context).bottomAppBarColor,

                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                "مكتبة غير ربحية تختص بعمل التطبيقات الإسلامية.",
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context).id ==
                                        'dark'
                                        ? Colors.white
                                        : Theme.of(context).primaryColorDark,
                                    fontFamily: 'kufi',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                // "مكتبة غير ربحية تختص بعمل التطبيقات الإسلامية.",
                                "هدفها الأرتقاء بالمسلمين لأعلى درجات الوعي الديني وازالة كل مفاهيم التشوية والتظليل على المسلمين التي تراكمت على مدى عقود.",
                                style: TextStyle(
                                    color: ThemeProvider.themeOf(context).id ==
                                        'dark'
                                        ? Colors.white
                                        : Theme.of(context).primaryColorDark,
                                    fontFamily: 'kufi',
                                    fontSize: 18
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).bottomAppBarColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                    )
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: Text(
                      'آخر ما تم نشره',
                      style: TextStyle(
                        color: Theme.of(context).canvasColor,
                        fontFamily: 'kufi',
                        fontSize: 18,
                      )
                  ),
                ),
              ),
              Container(
                height: 450,
                color: Theme.of(context).bottomAppBarColor.withOpacity(.2),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: InfiniteCarousel.builder(
                  itemCount: banner.length,
                  itemExtent: 900,
                  center: true,
                  anchor: 0.0,
                  velocityFactor: 0.2,
                  onIndexChanged: (index) {
                    if (_selectedIndex != index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    }
                  },
                  controller: _controller,
                  axisDirection: Axis.horizontal,
                  scrollBehavior: kIsWeb
                      ? ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      // Allows to swipe in web browsers
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse
                    },
                  )
                      : null,
                  loop: false,
                  itemBuilder: (context, itemIndex, realIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Scaffold.of(context).showBottomSheet<void>(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8))),
                              backgroundColor: Colors.transparent,
                                  (context) => Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 3 / 4 * 1.2,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(12.0),
                                          topLeft: Radius.circular(12.0)),
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                    child: quranApp(),
                                  ),
                                ),
                              ),
                              elevation: 40);
                          _controller.animateToItem(realIndex);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: kElevationToShadow[2],
                            image: DecorationImage(
                              image: AssetImage(banner[itemIndex]),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          )

        ],
      ),
    );
  }

  Widget quranApp() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Container(
            height: 450,
            color: Theme.of(context).bottomAppBarColor.withOpacity(.2),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: InfiniteCarousel.builder(
              itemCount: quranScreen.length,
              itemExtent: 270,
              center: true,
              anchor: 0.0,
              velocityFactor: 0.2,
              onIndexChanged: (index) {
                if (_selectedIndex != index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }
              },
              controller: _controller,
              axisDirection: Axis.horizontal,
              scrollBehavior: kIsWeb
                  ? ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  // Allows to swipe in web browsers
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse
                },
              )
                  : null,
              loop: false,
              itemBuilder: (context, itemIndex, realIndex) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      _controller.animateToItem(realIndex);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: kElevationToShadow[2],
                        image: DecorationImage(
                          image: AssetImage(quranScreen[itemIndex]),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
