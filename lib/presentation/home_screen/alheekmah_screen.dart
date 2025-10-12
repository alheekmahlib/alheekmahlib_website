import 'package:alheekmahlib_website/core/utils/helpers/app_router.dart';
import 'package:flutter/material.dart';

import '/core/utils/constants/extensions.dart';
import '../../core/services/services_locator.dart';
import '../../core/utils/constants/svg_picture.dart';
// import '../../shared/widgets/settings_list.dart';
import '../../core/widgets/tab_bar.dart';
import '../controllers/general_controller.dart';
import '../controllers/theme_controller.dart';
import 'widgets/bottom_bar.dart';

class AlheekmahScreen extends StatefulWidget {
  const AlheekmahScreen({super.key});

  @override
  State<AlheekmahScreen> createState() => _AlheekmahScreenState();
}

class _AlheekmahScreenState extends State<AlheekmahScreen> {
  @override
  Widget build(BuildContext context) {
    sl<AppRouter>().itemRouter(context);
    final general = sl<GeneralController>();
    general.screenHeight = MediaQuery.sizeOf(context).height;
    general.topPadding = general.screenHeight * 0.05;
    general.bottomPadding = general.screenHeight * 0.03;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MediaQuery.of(context).size.width <= 770
                      ? Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () =>
                                    sl<AppRouter>().onItemTapped(0, context),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0, vertical: 8.0),
                                  child: alheekmah_logo(context, height: 30.0),
                                ),
                              ),
                              TabBarUI(),
                            ],
                          ),
                        )
                      : InkWell(
                          onTap: () => sl<AppRouter>().onItemTapped(0, context),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: alheekmah_logo(context, height: 30.0),
                          ),
                        ),
                  MediaQuery.of(context).size.width <= 770
                      ? const SizedBox.shrink()
                      : TabBarUI(),
                  IconButton(
                    tooltip: 'Theme',
                    icon: Icon(
                      context.isDark ? Icons.dark_mode : Icons.light_mode,
                      color: context.textDarkColor,
                    ),
                    onPressed: () {
                      final theme = sl<ThemeController>();
                      theme.setTheme(
                          theme.themeId.value == 'dark' ? 'brown' : 'dark');
                    },
                  ),
                ],
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
                      itemBuilder: (context, index) =>
                          general.screensViews[index],
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
        ),
      ),
    );
  }
}
