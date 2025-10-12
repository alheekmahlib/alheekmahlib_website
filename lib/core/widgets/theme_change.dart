import 'package:alheekmahlib_website/core/services/services_locator.dart';
import 'package:alheekmahlib_website/presentation/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/utils/constants/extensions.dart';

class ThemeChange extends StatelessWidget {
  const ThemeChange({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = sl<ThemeController>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          InkWell(
            child: Container(
              height: 40,
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.8),
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      border: Border.all(
                          color: theme.themeId.value == 'brown'
                              ? Theme.of(context).dividerColor
                              : Theme.of(context).colorScheme.surface,
                          width: 3),
                      color: const Color(0xff3C2A21),
                    ),
                    child: theme.themeId.value == 'brown'
                        ? Icon(Icons.done,
                            size: 14, color: Theme.of(context).dividerColor)
                        : null,
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Text(
                    'brown'.tr,
                    style: TextStyle(
                      color: theme.themeId.value == 'brown'
                          ? context.textDarkColor
                          : context.textDarkColor.withValues(alpha: .5),
                      fontSize: 18,
                      fontFamily: 'noto',
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              theme.setTheme('brown');
            },
          ),
          InkWell(
            child: Container(
              height: 40,
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.8),
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      border: Border.all(
                          color: theme.themeId.value == 'dark'
                              ? Theme.of(context).dividerColor
                              : Theme.of(context).colorScheme.surface,
                          width: 3),
                      color: const Color(0xff2d2d2d),
                    ),
                    child: theme.themeId.value == 'dark'
                        ? Icon(Icons.done,
                            size: 14, color: Theme.of(context).dividerColor)
                        : null,
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Text(
                    'dark'.tr,
                    style: TextStyle(
                      color: theme.themeId.value == 'dark'
                          ? context.textDarkColor
                          : context.textDarkColor.withValues(alpha: .5),
                      fontSize: 18,
                      fontFamily: 'noto',
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              theme.setTheme('dark');
            },
          ),
        ],
      ),
    );
  }
}
