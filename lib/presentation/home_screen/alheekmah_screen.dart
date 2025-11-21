import 'package:alheekmahlib_website/core/utils/helpers/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_library/quran_library.dart';

import '../../core/services/services_locator.dart';
import '../../core/utils/constants/svg_picture.dart';
// import '../../shared/widgets/settings_list.dart';
import '../../core/widgets/tab_bar.dart';
import '../books/books.dart';
import '../controllers/general_controller.dart';
import 'widgets/bottom_bar.dart';

class AlheekmahScreen extends StatelessWidget {
  const AlheekmahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sl<AppRouter>().itemRouter(context);
    final general = sl<GeneralController>();
    general.screenHeight = MediaQuery.sizeOf(context).height;
    general.topPadding = general.screenHeight * 0.05;
    general.bottomPadding = general.screenHeight * 0.03;
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width > 820;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          !isWide
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () =>
                                sl<AppRouter>().onItemTapped(0, context),
                            child: alheekmahLogo(context, height: 30.0),
                          ),
                          ChangeThemeWidget(
                            svgColor: context.theme.colorScheme.primary,
                            borderColor: context.theme.colorScheme.primary
                                .withValues(alpha: .2),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => QuranLibrary.quranCtrl.isShowControl.value &&
                              general.tapIndex.value == 1
                          ? TabBarUI()
                          : const SizedBox.shrink(),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => sl<AppRouter>().onItemTapped(0, context),
                        child: alheekmahLogo(context, height: 30.0),
                      ),
                      Flexible(child: TabBarUI()),
                      ChangeThemeWidget(
                        svgColor: context.theme.colorScheme.primary,
                        borderColor: context.theme.colorScheme.primary
                            .withValues(alpha: .2),
                      ),
                    ],
                  ),
                ),
          Expanded(
            child: Stack(
              children: [
                // Soft gradient background for content
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.surface,
                        Theme.of(context)
                            .colorScheme
                            .surface
                            .withValues(alpha: 0.96),
                      ],
                    ),
                  ),
                ),
                PageView.builder(
                  controller: sl<AppRouter>().pageController,
                  itemCount: general.screensViews.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => general.screensViews[index],
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomBar(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
