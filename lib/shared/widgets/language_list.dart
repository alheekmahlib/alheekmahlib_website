import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../core/services/controllers/settings_controller.dart';
import '../../core/services/shared_pref_services.dart';
import '../../core/utils/constants/extensions.dart';
import '../../core/utils/constants/shared_preferences_constants.dart';
import '../../core/utils/helpers/languages/language_controller.dart';
import '../../services_locator.dart';

class LanguageList extends StatelessWidget {
  const LanguageList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (localizationController) => Directionality(
        textDirection: TextDirection.rtl,
        child: PageStorage(
          bucket: PageStorageBucket(),
          child: ExpansionTileCard(
            elevation: 0.0,
            initialElevation: 0.0,
            expandedTextColor: Theme.of(context).primaryColorDark,
            title: SizedBox(
              width: 100.0,
              child: Text(
                sl<SettingsController>().languageName.value,
                style: TextStyle(
                  fontFamily: sl<SettingsController>().languageFont.value,
                  fontSize: 18,
                  color: ThemeProvider.themeOf(context).id == 'dark'
                      ? Colors.white
                      : Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            baseColor: Theme.of(context).colorScheme.background,
            expandedColor: Theme.of(context).colorScheme.background,
            children: <Widget>[
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  buttonHeight: 42.0,
                  buttonMinWidth: 90.0,
                  children: List.generate(
                      sl<SettingsController>().languageList.length, (index) {
                    final lang = sl<SettingsController>().languageList[index];
                    return InkWell(
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width * 0.8),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                                border: Border.all(
                                    color: 'appLang'.tr == lang['appLang']
                                        ? Theme.of(context).dividerColor
                                        : Theme.of(context)
                                            .colorScheme
                                            .background,
                                    width: 3),
                                color: const Color(0xff3C2A21),
                              ),
                              child: 'appLang'.tr == lang['appLang']
                                  ? Icon(Icons.done,
                                      size: 14,
                                      color: Theme.of(context).dividerColor)
                                  : null,
                            ),
                            Text(
                              lang['name'],
                              style: TextStyle(
                                color: 'appLang'.tr == lang['appLang']
                                    ? context.textDarkColor
                                    : context.textDarkColor.withOpacity(.5),
                                fontSize: 18,
                                fontFamily: 'noto',
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () async {
                        // sl<SettingsController>().setLocale(
                        //     Locale.fromSubtags(languageCode: lang['lang']));
                        localizationController
                            .setLanguage(Locale(lang['lang'], ''));
                        await sl<SharedPrefServices>()
                            .saveString(LANG, lang['lang']);
                        await sl<SharedPrefServices>()
                            .saveString(LANG_NAME, lang['name']);
                        await sl<SharedPrefServices>()
                            .saveString(LANGUAGE_FONT, lang['font']);
                        sl<SettingsController>().languageName.value =
                            lang['name'];
                        sl<SettingsController>().languageFont.value =
                            lang['font'];
                      },
                    );
                  })),
            ],
          ),
        ),
      ),
    );
  }
}
