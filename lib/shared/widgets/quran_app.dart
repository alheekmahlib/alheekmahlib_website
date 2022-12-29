import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/app_localizations.dart';

class QuranApp extends StatefulWidget {
  QuranApp({Key? key}) : super(key: key);

  @override
  State<QuranApp> createState() => _QuranAppState();
}

class _QuranAppState extends State<QuranApp> {
  late InfiniteScrollController _controller;
  int _selectedIndex = 0;

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

  List<String> quranScreen = [
    'assets/apps_images/screen 0.jpg',
    'assets/apps_images/screen 1.jpg',
    'assets/apps_images/screen 2.jpg',
    'assets/apps_images/screen 3.jpg',
    'assets/apps_images/screen 4.jpg',
  ];

  _appStoreI() async {
    // ios specification
    String uri = 'https://apps.apple.com/us/app/%D8%A7%D9%84%D9%82%D8%B1%D8%A2%D9%86-%D8%A7%D9%84%D9%83%D8%B1%D9%8A%D9%85-%D9%85%D9%83%D8%AA%D8%A8%D8%A9-%D8%A7%D9%84%D8%AD%D9%83%D9%85%D8%A9/id1500153222';
    if (await canLaunchUrl(Uri.parse(uri))) {
      await launchUrl(Uri.parse(uri));
    } else {
      print("No url client found");
    }
  }
  _playStore() async {
    // ios specification
    String uri = 'https://play.google.com/store/apps/details?id=com.alheekmah.alquranalkareem.alquranalkareem';
    if (await canLaunchUrl(Uri.parse(uri))) {
      await launchUrl(Uri.parse(uri));
    } else {
      print("No url client found");
    }
  }_appGallery() async {
    // ios specification
    String uri = 'https://appgallery.cloud.huawei.com/marketshare/app/C102051725?locale=en_US&source=appshare&subsource=C102051725';
    if (await canLaunchUrl(Uri.parse(uri))) {
      await launchUrl(Uri.parse(uri));
    } else {
      print("No url client found");
    }
  }_appStoreD() async {
    // ios specification
    String uri = 'https://apps.apple.com/us/app/%D8%A7%D9%84%D9%82%D8%B1%D8%A2%D9%86-%D8%A7%D9%84%D9%83%D8%B1%D9%8A%D9%85-%D9%85%D9%83%D8%AA%D8%A8%D8%A9-%D8%A7%D9%84%D8%AD%D9%83%D9%85%D8%A9/id1660688066';
    if (await canLaunchUrl(Uri.parse(uri))) {
      await launchUrl(Uri.parse(uri));
    } else {
      print("No url client found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      ),
                      border: Border.all(
                          width: 2,
                          color: Theme.of(context).dividerColor)),
                  child: Icon(
                    Icons.close_outlined,
                    color: Theme.of(context).bottomAppBarColor,
                  ),
                ),
              ),
            ),
            const Divider(
              height: 58,
              thickness: 2,
              endIndent: 16,
              indent: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: ListView(
                children: [
                  SvgPicture.asset(
                    'assets/svg/splash_icon.svg',
                    width: 80,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: Text(
                      '| القرآن الكريم - مكتبة الحكمة |',
                      style: TextStyle(
                        color: Theme.of(context).bottomAppBarColor,
                        fontSize: 18,
                        fontFamily: 'kufi',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .bottomAppBarColor
                            .withOpacity(.2),
                        border: Border.symmetric(
                            vertical: BorderSide(
                                color:
                                Theme.of(context).bottomAppBarColor,
                                width: 2))),
                    child: Text(
                      AppLocalizations.of(context).about_us,
                      style: TextStyle(
                        color: ThemeProvider.themeOf(context).id == 'dark'
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontFamily: 'kufi',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .bottomAppBarColor
                            .withOpacity(.2),
                        border: Border.symmetric(
                            vertical: BorderSide(
                                color:
                                Theme.of(context).bottomAppBarColor,
                                width: 2))),
                    child: Text(
                      AppLocalizations.of(context).about_app,
                      style: TextStyle(
                        color: ThemeProvider.themeOf(context).id == 'dark'
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        height: 1.5,
                        fontSize: 14,
                        fontFamily: 'kufi',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .bottomAppBarColor
                            .withOpacity(.2),
                        border: Border.symmetric(
                            vertical: BorderSide(
                                color:
                                Theme.of(context).bottomAppBarColor,
                                width: 2))),
                    child: Text(
                      AppLocalizations.of(context).about_app2,
                      style: TextStyle(
                        color: ThemeProvider.themeOf(context).id == 'dark'
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontFamily: 'kufi',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .bottomAppBarColor
                            .withOpacity(.2),
                        border: Border.symmetric(
                            vertical: BorderSide(
                                color:
                                Theme.of(context).bottomAppBarColor,
                                width: 2))),
                    child: Text(
                      AppLocalizations.of(context).about_app3,
                      style: TextStyle(
                        color: ThemeProvider.themeOf(context).id == 'dark'
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        height: 1.5,
                        fontSize: 14,
                        fontFamily: 'kufi',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
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
                  const SizedBox(
                    height: 16.0,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      color: Theme.of(context)
                          .bottomAppBarColor
                          .withOpacity(.2),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0Xff10c0fa),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8)
                                )
                          ),
                              child: InkWell(
                                child: Row(
                                  children: [
                                    const Image(
                                        image: AssetImage(
                                      'assets/images/app_store.png',
                                    ),
                                      height: 30,
                                    ),
                                    Container(
                                      width: 2,
                                      height: 20,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      color: Colors.white,
                                    ),
                                    Text(
                                      AppLocalizations.of(context).appStoreI,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'kufi',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  _appStoreI();
                                },
                              ),
                            ),
                            const Divider(),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Color(0Xff5ab963),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(8)
                                  )
                              ),
                              child: InkWell(
                                child: Row(
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                        'assets/images/play_store.png',
                                      ),
                                      height: 30,
                                    ),
                                    Container(
                                      width: 2,
                                      height: 20,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      color: Colors.white,
                                    ),
                                    Text(
                                      AppLocalizations.of(context).playStore,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'kufi',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  _playStore();
                                },
                              ),
                            ),
                            const Divider(),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Color(0Xffeb5d5c),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(8)
                                  )
                              ),
                              child: InkWell(
                                child: Row(
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                        'assets/images/app_gallery.png',
                                      ),
                                      height: 30,
                                    ),
                                    Container(
                                      width: 2,
                                      height: 20,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      color: Colors.white,
                                    ),
                                    Text(
                                      AppLocalizations.of(context).appGallery,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'kufi',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  _appGallery();
                                },
                              ),
                            ),
                            const Divider(),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Color(0Xff10c0fa),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(8)
                                  )
                              ),
                              child: InkWell(
                                child: Row(
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                        'assets/images/app_store.png',
                                      ),
                                      height: 30,
                                    ),
                                    Container(
                                      width: 2,
                                      height: 20,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      color: Colors.white,
                                    ),
                                    Text(
                                      AppLocalizations.of(context).appStoreD,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'kufi',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  _appStoreD();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
