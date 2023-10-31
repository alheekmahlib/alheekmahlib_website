import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '/core/services/controllers/general_controller.dart';
import '/core/utils/constants/extensions.dart';
import '/shared/widgets/widgets.dart';
import '../../../our_app_info_model.dart';
import '../../../services_locator.dart';
import 'apps_info.dart';

class OurApps extends StatelessWidget {
  const OurApps({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      child: beigeContainer(
          context,
          Column(
            children: [
              Text(
                'ourApps'.tr,
                style: TextStyle(
                    color: context.textDarkColor,
                    fontFamily: 'kufi',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    height: 1.5),
              ),
              FutureBuilder<List<OurAppInfo>>(
                  future: sl<GeneralController>().fetchApps(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<OurAppInfo>? apps = snapshot.data;
                      return Wrap(
                        children: List.generate(
                          apps!.length,
                          (index) => GestureDetector(
                            child: whiteContainer(
                                context,
                                Column(
                                  children: [
                                    Image.network(
                                      apps[index].appBanner,
                                      width: 300,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: FittedBox(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.network(
                                              apps[index].appLogo,
                                              width: 20,
                                            ),
                                            const SizedBox(
                                              width: 16.0,
                                            ),
                                            Text(
                                              apps[index].appTitle,
                                              style: TextStyle(
                                                  color: context.textDarkColor,
                                                  fontFamily: 'kufi',
                                                  fontSize: 16,
                                                  height: 1.5),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      apps[index].body,
                                      style: TextStyle(
                                          color: context.textDarkColor,
                                          fontFamily: 'naskh',
                                          fontSize: 16,
                                          height: 1.5),
                                    ),
                                  ],
                                )),
                            onTap: () => screenModalBottomSheet(
                              context,
                              AppsInfo(
                                appLogo: apps[index].appLogo,
                                appName: apps[index].appTitle,
                                appStoreIUrl: apps[index].urlAppStore,
                                playStoreUrl: apps[index].urlPlayStore,
                                appGalleryUrl: apps[index].urlAppGallery,
                                appStoreDUrl: apps[index].urlMacAppStore,
                                banner1: apps[index].banner1,
                                banner2: apps[index].banner2,
                                banner3: apps[index].banner3,
                                banner4: apps[index].banner4,
                                aboutApp3: apps[index].aboutApp3,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
            ],
          )),
    );
  }
}
