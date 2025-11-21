part of '../our_apps.dart';

class AppsInfo extends StatelessWidget {
  final OurAppInfo apps;
  const AppsInfo({
    super.key,
    required this.apps,
  });

  @override
  Widget build(BuildContext context) {
    final appInfo = sl<AppsInfoController>();

    List<String> appScreen = [
      apps.banner1,
      apps.banner2,
      apps.banner3,
      apps.banner4,
    ];
    return SizedBox(
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
                    apps.appLogo,
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
                      '| ${apps.appTitle} |',
                      style: TextStyle(
                        color: context.textDarkColor,
                        fontSize: 18,
                        fontFamily: 'cairo',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    height: 450,
                    color: Theme.of(context)
                        .colorScheme
                        .surface
                        .withValues(alpha: .2),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              appInfo.controller.animateToItem(realIndex);
                              MultiImageProvider multiImageProvider =
                                  MultiImageProvider(initialIndex: realIndex, [
                                Image.network(apps.banner1).image,
                                Image.network(apps.banner2).image,
                                Image.network(apps.banner3).image,
                                Image.network(apps.banner4).image
                              ]);
                              showImageViewerPager(context, multiImageProvider,
                                  onPageChanged: (page) {
                                log("page changed to $page");
                              }, onViewerDismissed: (page) {
                                log("dismissed while on page $page");
                              });
                            },
                            child: appScreen[itemIndex] == ''
                                ? const SizedBox.shrink()
                                : Image.network(
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
                            fontFamily: 'cairo',
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
                            apps.aboutApp3.tr,
                            style: TextStyle(
                              color: context.textDarkColor,
                              height: 1.5,
                              fontSize: 14,
                              fontFamily: 'cairo',
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
                          _storeButton(
                            appInfo: appInfo,
                            url: apps.urlAppStore,
                            assetPath: 'assets/images/app_store.png',
                            label: 'appStoreI',
                          ),
                          const Divider(),
                          _storeButton(
                            appInfo: appInfo,
                            url: apps.urlPlayStore,
                            assetPath: 'assets/images/play_store.png',
                            label: 'playStore',
                          ),
                          const Divider(),
                          _storeButton(
                            appInfo: appInfo,
                            url: apps.urlAppGallery,
                            assetPath: 'assets/images/app_gallery.png',
                            label: 'appGallery',
                          ),
                          const Divider(),
                          _storeButton(
                            appInfo: appInfo,
                            url: apps.urlMacAppStore,
                            assetPath: 'assets/images/app_store.png',
                            label: 'appStoreD',
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
    );
  }

  Widget _storeButton({
    required AppsInfoController appInfo,
    required String url,
    required String assetPath,
    required String label,
  }) {
    return Container(
      decoration: const BoxDecoration(
          color: Color(0Xff10c0fa),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: InkWell(
        child: Row(
          children: [
            Image(
              image: AssetImage(
                assetPath,
              ),
              height: 30,
            ),
            Container(
              width: 2,
              height: 20,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: Colors.white,
            ),
            Text(
              label.tr,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'cairo',
                  fontStyle: FontStyle.italic,
                  fontSize: 14),
            ),
          ],
        ),
        onTap: () {
          appInfo.appStoreI(url);
        },
      ),
    );
  }
}
