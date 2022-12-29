import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:lottie/lottie.dart';
import 'package:theme_provider/theme_provider.dart';

import '../shared/widgets/quran_app.dart';
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
  double? _itemExtent;

  // Get screen width of viewport.
  double get screenWidth => MediaQuery.of(context).size.width;



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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _itemExtent = screenWidth - 200;
  }

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
              opacity: .02,
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
          Positioned(
            top: -190,
            right: -205,
            child: Opacity(
              opacity: .1,
              child: Lottie.asset('assets/lottie/loading.json',
                  width: 500),
              // child: SvgPicture.asset(
              //   'assets/svg/zakhrafa.svg',
              //   width: 500,
              //   color: ThemeProvider.themeOf(context).id ==
              //       'dark'
              //       ? Colors.white.withOpacity(.2)
              //       : Theme.of(context).bottomAppBarColor,
              // ),
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
                    Padding(
                      padding: const EdgeInsets.all(16.0),
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
                                fontSize: 18,
                              height: 1.5
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
                                fontSize: 18,
                                height: 1.5
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
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
                height: MediaQuery.of(context).size.height / 1/2,
                color: Theme.of(context).bottomAppBarColor.withOpacity(.2),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: InfiniteCarousel.builder(
                  itemCount: banner.length,
                  itemExtent: _itemExtent ?? 40,
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
                                    child: QuranApp(),
                                  ),
                                ),
                              ),
                              elevation: 40);
                          _controller.animateToItem(realIndex);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // boxShadow: kElevationToShadow[2],
                            image: DecorationImage(
                              image: AssetImage(banner[itemIndex]),
                              fit: BoxFit.contain,

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
}
