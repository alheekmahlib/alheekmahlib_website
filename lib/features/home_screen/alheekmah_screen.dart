import 'package:alheekmahlib_website/core/services/controllers/pageNavigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import '/core/utils/constants/extensions.dart';
import '../../core/services/controllers/general_controller.dart';
import '../../core/utils/constants/svg_picture.dart';
import '../../services_locator.dart';
import '../../shared/widgets/settings_list.dart';
import '../../shared/widgets/tab_bar.dart';
import 'widgets/bottom_bar.dart';

class AlheekmahScreen extends StatelessWidget {
  const AlheekmahScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    sl<PageNavigationController>().itemRouter(context);
    final general = sl<GeneralController>();
    general.screenWidth = MediaQuery.sizeOf(context).width;
    general.screenHeight = MediaQuery.sizeOf(context).height;
    general.topPadding = general.screenHeight * 0.05;
    general.bottomPadding = general.screenHeight * 0.03;
    general.sidePadding = general.screenWidth * 0.05;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SliderDrawer(
          key: sl<GeneralController>().key,
          splashColor: Theme.of(context).primaryColorDark,
          slideDirection: SlideDirection.RIGHT_TO_LEFT,
          sliderOpenSize: general.screenHeight * .35,
          isCupertino: true,
          isDraggable: true,
          appBar: SliderAppBar(
            appBarColor: Theme.of(context).colorScheme.background,
            appBarPadding: const EdgeInsets.symmetric(horizontal: 40.0),
            drawerIconColor: Theme.of(context).primaryColorDark,
            drawerIcon: IconButton(
              icon: Icon(
                Icons.menu,
                size: 24,
                color: context.textDarkColor,
              ),
              onPressed: () =>
                  sl<GeneralController>().key.currentState?.toggle(),
            ),
            appBarHeight: 50,
            title: general.screenWidth <= 770
                ? const SizedBox.shrink()
                : const TabBarUI(),
            trailing: alheekmah_logo(context, height: 30.0),
          ),
          slider: const SettingsList(),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Stack(children: [
              PageView.builder(
                controller: sl<PageNavigationController>().pageController,
                itemCount: general.screensViews.length,
                itemBuilder: (context, index) => general.screensViews[index],
              ),
              const Align(
                  alignment: Alignment.bottomCenter, child: BottomBar()),
            ]),
          ),
        ),
      ),
    );
  }
}
