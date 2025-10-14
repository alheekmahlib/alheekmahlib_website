import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../presentation/controllers/settings_controller.dart';
import '../services/services_locator.dart';
import '../services/shared_pref_services.dart';
import '../utils/constants/extensions/dimensions.dart';
import '../utils/constants/shared_preferences_constants.dart';
import '../utils/helpers/languages/language_controller.dart';

class LanguageList extends StatelessWidget {
  const LanguageList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (localizationController) => Directionality(
        textDirection: TextDirection.rtl,
        child:
            _LanguageDropdown(localizationController: localizationController),
      ),
    );
  }
}

class _LanguageDropdown extends StatelessWidget {
  const _LanguageDropdown({required this.localizationController});

  final LocalizationController localizationController;

  @override
  Widget build(BuildContext context) {
    final settings = sl<SettingsController>();
    final List languages = settings.languageList;

    // Current language code and name
    final String currentCode =
        settings.initialLang?.languageCode ?? Get.locale?.languageCode ?? 'ar';
    final String currentName = settings.languageName.value;
    final String currentFont = settings.languageFont.value;

    const double buttonHeight = 40;
    const double itemHeight = 40;
    const double maxMenuHeight = 320;
    final int itemsCount = languages.length;
    final double menuHeight = (itemsCount * itemHeight) > maxMenuHeight
        ? maxMenuHeight
        : (itemsCount * itemHeight);
    final double dropdownWidth =
        (MediaQuery.sizeOf(context).width * 0.9).clamp(220.0, 220.0);

    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        value: currentCode,
        // Show only the selected label on the button
        selectedItemBuilder: (ctx) {
          return languages.map<Widget>((_) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  currentName,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: currentFont,
                    fontSize: 16,
                    color: context.isDark
                        ? Colors.white
                        : Theme.of(context).primaryColorDark,
                  ),
                ),
                const Gap(8),
                Icon(
                  Icons.language,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            );
          }).toList();
        },
        items: languages.map<DropdownMenuItem<String>>((dynamic lang) {
          final bool isSelected = currentCode == lang['lang'];
          return DropdownMenuItem<String>(
            value: lang['lang'] as String,
            child: SizedBox(
              width: dropdownWidth,
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: .06)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      margin: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.outlineVariant,
                          width: 2,
                        ),
                        color: context.isDark
                            ? const Color(0xFF2B2B2B)
                            : const Color(0xFFF4F2EE),
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              size: 14,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          : null,
                    ),
                    Expanded(
                      child: Text(
                        lang['name'] as String,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isSelected
                              ? context.textDarkColor
                              : context.textDarkColor.withValues(alpha: .6),
                          fontSize: 16,
                          fontFamily: 'noto',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
        onChanged: (String? code) async {
          if (code == null) return;
          final lang = languages.firstWhere((e) => e['lang'] == code);
          localizationController.setLanguage(Locale(code, ''));
          await sl<SharedPrefServices>().saveString(LANG, code);
          await sl<SharedPrefServices>().saveString(LANG_NAME, lang['name']);
          await sl<SharedPrefServices>()
              .saveString(LANGUAGE_FONT, lang['font']);
          settings.languageName.value = lang['name'];
          settings.languageFont.value = lang['font'];
        },
        style: TextStyle(
          fontFamily: currentFont,
          fontSize: 18,
          color: context.textDarkColor,
        ),
        buttonStyleData: ButtonStyleData(
          height: buttonHeight - 4,
          width: 160,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).dividerColor.withValues(alpha: .4),
            ),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withValues(alpha: context.isDark ? .12 : .06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          elevation: 0,
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.expand_more,
            color: Theme.of(context).colorScheme.primary,
          ),
          openMenuIcon: Icon(
            Icons.expand_less,
            color: Theme.of(context).colorScheme.primary,
          ),
          iconSize: 20,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: maxMenuHeight,
          width: dropdownWidth,
          elevation: 8,
          // Open upwards: place menu over the button with negative offset by its height
          isOverButton: true,
          offset: Offset(0, -(menuHeight + buttonHeight + 80)),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).dividerColor.withValues(alpha: .2),
            ),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withValues(alpha: context.isDark ? .24 : .12),
                blurRadius: 16,
                spreadRadius: 1,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thumbVisibility: WidgetStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: itemHeight,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        ),
      ),
    );
  }
}
