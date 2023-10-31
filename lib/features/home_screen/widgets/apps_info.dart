import 'dart:ui';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

import '/core/utils/constants/extensions.dart';
import '../../../core/services/controllers/apps_info_controller.dart';
import '../../../services_locator.dart';
import '../../../shared/widgets/widgets.dart';

class AppsInfo extends StatelessWidget {
  final String appLogo;
  final String appName;
  final String appStoreIUrl;
  final String playStoreUrl;
  final String appGalleryUrl;
  final String appStoreDUrl;
  final String banner1;
  final String banner2;
  final String banner3;
  final String banner4;
  final String aboutApp3;
  const AppsInfo({
    Key? key,
    required this.appLogo,
    required this.appName,
    required this.appStoreIUrl,
    required this.playStoreUrl,
    required this.appGalleryUrl,
    required this.appStoreDUrl,
    required this.banner1,
    required this.banner2,
    required this.banner3,
    required this.banner4,
    required this.aboutApp3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appInfo = sl<AppsInfoController>();

    List<String> appScreen = [
      banner1,
      banner2,
      banner3,
      banner4,
    ];
    return Directionality(
      textDirection:
          'appLang'.tr == 'لغة التطبيق' ? TextDirection.rtl : TextDirection.ltr,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Stack(
            children: [
              customClose(context),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: ListView(
                  children: [
                    SvgPicture.network(
                      appLogo,
                      width: 80,
                    ),
                    const Divider(
                      height: 58,
                      thickness: 2,
                      endIndent: 16,
                      indent: 16,
                    ),
                    Center(
                      child: Text(
                        '| $appName |',
                        style: TextStyle(
                          color: context.textDarkColor,
                          fontSize: 18,
                          fontFamily: 'kufi',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      height: 450,
                      color:
                          Theme.of(context).colorScheme.surface.withOpacity(.2),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: InfiniteCarousel.builder(
                        itemCount: appScreen.length,
                        itemExtent: 270,
                        center: true,
                        anchor: 0.0,
                        velocityFactor: 0.2,
                        onIndexChanged: (index) {
                          if (appInfo.selectedIndex != index) {
                            appInfo.selectedIndex = index;
                          }
                        },
                        controller: appInfo.controller,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                appInfo.controller.animateToItem(realIndex);
                                MultiImageProvider multiImageProvider =
                                    MultiImageProvider(
                                        initialIndex: realIndex,
                                        [
                                      Image.network(banner1).image,
                                      Image.network(banner2).image,
                                      Image.network(banner3).image,
                                      Image.network(banner4).image
                                    ]);
                                showImageViewerPager(
                                    context, multiImageProvider,
                                    onPageChanged: (page) {
                                  print("page changed to $page");
                                }, onViewerDismissed: (page) {
                                  print("dismissed while on page $page");
                                });
                              },
                              child: Image.network(
                                appScreen[itemIndex],
                                height: 400,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    beigeContainer(
                      context,
                      whiteContainer(
                        context,
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            'about_app2'.tr,
                            style: TextStyle(
                              color: context.textDarkColor,
                              fontSize: 18,
                              fontFamily: 'kufi',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    beigeContainer(
                        context,
                        whiteContainer(
                          context,
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              aboutApp3.tr,
                              style: TextStyle(
                                color: context.textDarkColor,
                                height: 1.5,
                                fontSize: 14,
                                fontFamily: 'kufi',
                              ),
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 16.0,
                    ),
                    beigeContainer(
                      context,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: Color(0Xff10c0fa),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
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
                                      'appStoreI'.tr,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'kufi',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  appInfo.appStoreI(appStoreIUrl);
                                },
                              ),
                            ),
                            const Divider(),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Color(0Xff5ab963),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
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
                                      'playStore'.tr,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'kufi',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  appInfo.playStore(playStoreUrl);
                                },
                              ),
                            ),
                            const Divider(),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Color(0Xffeb5d5c),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
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
                                      'appGallery'.tr,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'kufi',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  appInfo.appGallery(appGalleryUrl);
                                },
                              ),
                            ),
                            const Divider(),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Color(0Xff10c0fa),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
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
                                      'appStoreD'.tr,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'kufi',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  appInfo.appStoreD(appStoreDUrl);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
