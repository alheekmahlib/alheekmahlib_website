import 'package:alheekmahlib_website/shared/widgets/theme_change.dart';
import 'package:alheekmahlib_website/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../l10n/app_localizations.dart';
import '../../main.dart';
import '../../screens/about_app.dart';
import '../custom_rect_tween.dart';
import '../hero_dialog_route.dart';



/// {@template add_todo_button}
/// Button to add a new [Todo].
///
/// Opens a [HeroDialogRoute] of [_AddTodoPopupCard].
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class settingsButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const settingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return const _settingsPopupCard();
          }));
        },
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Theme.of(context).backgroundColor,
            elevation: 1,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: const Icon(
              Icons.settings,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}

/// Tag-value used for the add todo popup button.
const String _heroAddTodo = 'add-todo-hero';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class _settingsPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  const _settingsPopupCard({Key? key}) : super(key: key);

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
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 3/4,
        width: 450,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Hero(
            tag: _heroAddTodo,
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: Material(
              color: Theme.of(context).backgroundColor,
              elevation: 1,
              shape:
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                                mainAxisSize: MainAxisSize.min,
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
                                        mainAxisSize: MainAxisSize.min,
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}