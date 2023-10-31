import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theme_provider/theme_provider.dart';

import '/core/utils/constants/extensions.dart';

class ThemeChange extends StatelessWidget {
  const ThemeChange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          color: ThemeProvider.themeOf(context).id == 'brown'
                              ? Theme.of(context).dividerColor
                              : Theme.of(context).colorScheme.background,
                          width: 3),
                      color: const Color(0xff3C2A21),
                    ),
                    child: ThemeProvider.themeOf(context).id == 'brown'
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
                      color: ThemeProvider.themeOf(context).id == 'brown'
                          ? context.textDarkColor
                          : context.textDarkColor.withOpacity(.5),
                      fontSize: 18,
                      fontFamily: 'noto',
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              ThemeProvider.controllerOf(context).setTheme('brown');
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
                          color: ThemeProvider.themeOf(context).id == 'dark'
                              ? Theme.of(context).dividerColor
                              : Theme.of(context).colorScheme.background,
                          width: 3),
                      color: const Color(0xff2d2d2d),
                    ),
                    child: ThemeProvider.themeOf(context).id == 'dark'
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
                      color: ThemeProvider.themeOf(context).id == 'dark'
                          ? context.textDarkColor
                          : context.textDarkColor.withOpacity(.5),
                      fontSize: 18,
                      fontFamily: 'noto',
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              ThemeProvider.controllerOf(context).setTheme('dark');
            },
          ),
        ],
      ),
    );
  }
}
