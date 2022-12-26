import 'dart:io';

import 'package:alheekmahlib_website/cubit/alheekmah_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../shared/widgets/theme_change.dart';
import '../shared/widgets/widgets.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  _launchEmail() async {
    // ios specification
    const String subject = "القرآن الكريم - مكتبة الحكمة";
    const String stringText =
        "يرجى كتابة أي ملاحظة أو إستفسار\n| جزاكم الله خيرًا |";
    String uri =
        'mailto:haozo89@gmail.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(stringText)}';
    if (await canLaunchUrl(Uri.parse(uri))) {
      await launchUrl(Uri.parse(uri));
    } else {
      print("No email client found");
    }
  }

  _launchUrl() async {
    // ios specification
    String uri = 'https://www.facebook.com/alheekmahlib';
    if (await canLaunchUrl(Uri.parse(uri))) {
      await launchUrl(Uri.parse(uri));
    } else {
      print("No url client found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: ListView(
          children: [
            Center(
              child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 3 / 4,
                  child: SvgPicture.asset(
                    'assets/svg/space_line.svg',
                  )),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                color: Theme.of(context)
                    .bottomAppBarColor
                    .withOpacity(.2),
                child: Column(
                  children: [
                    customContainer(
                      context,
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/line.svg',
                            height: 15,
                          ),
                          Text(
                            AppLocalizations.of(context)
                                .langChange,
                            style: TextStyle(
                                color:
                                    ThemeProvider.themeOf(context)
                                                .id ==
                                            'dark'
                                        ? Colors.white
                                        : Theme.of(context)
                                            .primaryColor,
                                fontFamily: 'kufi',
                                fontStyle: FontStyle.italic,
                                fontSize: 16),
                          ),
                          SvgPicture.asset(
                            'assets/svg/line2.svg',
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          InkWell(
                            child: SizedBox(
                              height: 30,
                              width:
                                  MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(2.0)),
                                      border: Border.all(
                                          color: AppLocalizations.of(
                                                          context)
                                                      .appLang ==
                                                  "لغة التطبيق"
                                              ? Theme.of(context)
                                                  .secondaryHeaderColor
                                              : Theme.of(context)
                                                  .bottomAppBarColor
                                                  .withOpacity(.5),
                                          width: 2),
                                      color:
                                          const Color(0xff39412a),
                                    ),
                                    child: AppLocalizations.of(
                                                    context)
                                                .appLang ==
                                            "لغة التطبيق"
                                        ? Icon(Icons.done,
                                            size: 14,
                                            color: Theme.of(context)
                                                .bottomAppBarColor)
                                        : null,
                                  ),
                                  const SizedBox(
                                    width: 16.0,
                                  ),
                                  Text(
                                    'العربية',
                                    style: TextStyle(
                                      color: AppLocalizations.of(
                                                      context)
                                                  .appLang ==
                                              "لغة التطبيق"
                                          ? Theme.of(context)
                                              .secondaryHeaderColor
                                          : Theme.of(context)
                                              .bottomAppBarColor
                                              .withOpacity(.5),
                                      fontSize: 14,
                                      fontFamily: 'kufi',
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              MyApp.of(context)!.setLocale(
                                  const Locale.fromSubtags(
                                      languageCode: "ar"));
                            },
                          ),
                          InkWell(
                            child: SizedBox(
                              height: 30,
                              width:
                                  MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(2.0)),
                                      border: Border.all(
                                          color: AppLocalizations.of(
                                                          context)
                                                      .appLang ==
                                                  "App Language"
                                              ? Theme.of(context)
                                                  .secondaryHeaderColor
                                              : Theme.of(context)
                                                  .bottomAppBarColor
                                                  .withOpacity(.5),
                                          width: 2),
                                      color:
                                          const Color(0xff39412a),
                                    ),
                                    child: AppLocalizations.of(
                                                    context)
                                                .appLang ==
                                            "App Language"
                                        ? Icon(Icons.done,
                                            size: 14,
                                            color: Theme.of(context)
                                                .bottomAppBarColor)
                                        : null,
                                  ),
                                  const SizedBox(
                                    width: 16.0,
                                  ),
                                  Text(
                                    'English',
                                    style: TextStyle(
                                      color: AppLocalizations.of(
                                                      context)
                                                  .appLang ==
                                              "App Language"
                                          ? Theme.of(context)
                                              .secondaryHeaderColor
                                          : Theme.of(context)
                                              .bottomAppBarColor
                                              .withOpacity(.5),
                                      fontSize: 14,
                                      fontFamily: 'kufi',
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              MyApp.of(context)!.setLocale(
                                  const Locale.fromSubtags(
                                      languageCode: "en"));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                color: Theme.of(context)
                    .bottomAppBarColor
                    .withOpacity(.2),
                child: Column(
                  children: [
                    customContainer(
                      context,
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/line.svg',
                            height: 15,
                          ),
                          Text(
                            AppLocalizations.of(context)
                                .themeTitle,
                            style: TextStyle(
                                color:
                                    ThemeProvider.themeOf(context)
                                                .id ==
                                            'dark'
                                        ? Colors.white
                                        : Theme.of(context)
                                            .primaryColor,
                                fontFamily: 'kufi',
                                fontStyle: FontStyle.italic,
                                fontSize: 16),
                          ),
                          SvgPicture.asset(
                            'assets/svg/line2.svg',
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: const [ThemeChange()],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                color: Theme.of(context)
                    .bottomAppBarColor
                    .withOpacity(.2),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      InkWell(
                        child: Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              color: ThemeProvider.themeOf(context)
                                          .id ==
                                      'dark'
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                              size: 22,
                            ),
                            Container(
                              width: 2,
                              height: 20,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8),
                              color: ThemeProvider.themeOf(context)
                                          .id ==
                                      'dark'
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                            ),
                            Text(
                              AppLocalizations.of(context).email,
                              style: TextStyle(
                                  color:
                                      ThemeProvider.themeOf(context)
                                                  .id ==
                                              'dark'
                                          ? Colors.white
                                          : Theme.of(context)
                                              .primaryColor,
                                  fontFamily: 'kufi',
                                  fontStyle: FontStyle.italic,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        onTap: () {
                          _launchEmail();
                        },
                      ),
                      const Divider(),
                      InkWell(
                        child: Row(
                          children: [
                            Icon(
                              Icons.facebook_rounded,
                              color: ThemeProvider.themeOf(context)
                                          .id ==
                                      'dark'
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                              size: 22,
                            ),
                            Container(
                              width: 2,
                              height: 20,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8),
                              color: ThemeProvider.themeOf(context)
                                          .id ==
                                      'dark'
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .facebook,
                              style: TextStyle(
                                  color:
                                      ThemeProvider.themeOf(context)
                                                  .id ==
                                              'dark'
                                          ? Colors.white
                                          : Theme.of(context)
                                              .primaryColor,
                                  fontFamily: 'kufi',
                                  fontStyle: FontStyle.italic,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        onTap: () {
                          _launchUrl();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 3 / 4,
                  child: SvgPicture.asset(
                    'assets/svg/space_line.svg',
                  )),
            ),
          ],
        ),
      );
  }
}
