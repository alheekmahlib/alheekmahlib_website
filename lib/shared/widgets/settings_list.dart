import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/controllers/general_controller.dart';
import '../../core/utils/constants/extensions.dart';
import '../../services_locator.dart';
import 'language_list.dart';
import 'tab_bar.dart';
import 'theme_change.dart';
import 'widgets.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final general = sl<GeneralController>();
    double width = MediaQuery.sizeOf(context).width;
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Column(
        children: [
          MediaQuery.of(context).size.width <= 770
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TabBarUI(),
                ),
          Container(
            constraints: const BoxConstraints(maxWidth: 420),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            decoration: BoxDecoration(
                color: context.beigeDarkColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                )),
            child: Column(
              children: [
                Text(
                  'appLang'.tr,
                  style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 14,
                    color: context.isDark
                        ? Colors.white
                        : Theme.of(context).primaryColorDark,
                  ),
                ),
                const LanguageList(),
              ],
            ),
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 420),
            margin:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
                color: context.beigeDarkColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                )),
            child: Column(
              children: [
                Text(
                  'changeTheme'.tr,
                  style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 14,
                    color: context.isDark
                        ? Colors.white
                        : Theme.of(context).primaryColorDark,
                  ),
                ),
                whiteContainer(context, const ThemeChange(), width: width)
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
