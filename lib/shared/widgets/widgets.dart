import 'dart:io';

import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/handler_animation.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:theme_provider/theme_provider.dart';

import '/core/services/controllers/general_controller.dart';
import '/core/utils/constants/extensions.dart';
import '../../services_locator.dart';

Route animatRoute(Widget myWidget) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => myWidget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Widget delete(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.close_outlined,
              color: Colors.white,
              size: 18,
            ),
            Text(
              'delete'.tr,
              style: const TextStyle(
                  color: Colors.white, fontSize: 14, fontFamily: 'kufi'),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.close_outlined,
              color: Colors.white,
              size: 18,
            ),
            Text(
              'delete'.tr,
              style: const TextStyle(
                  color: Colors.white, fontSize: 14, fontFamily: 'kufi'),
            )
          ],
        ),
      ],
    ),
  );
}

void customSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    duration: const Duration(milliseconds: 3000),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Theme.of(context).colorScheme.surface,
    content: SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              'assets/svg/line.svg',
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              text,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontFamily: 'kufi',
                  fontStyle: FontStyle.italic,
                  fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              'assets/svg/line2.svg',
            ),
          ),
        ],
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Widget customContainer(BuildContext context, Widget myWidget) {
  return ClipPath(
      clipper: const ShapeBorderClipper(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)))),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(.2),
            border: Border.symmetric(
                vertical: BorderSide(
                    color: Theme.of(context).colorScheme.surface, width: 2))),
        child: myWidget,
      ));
}

Widget hijriDateLand(BuildContext context) {
  var _today = HijriCalendar.now();
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset(
        'assets/svg/hijri_date.svg',
        height: 32,
      ),
      const VerticalDivider(
        width: 2,
        thickness: 1,
        endIndent: 40,
        indent: 40,
      ),
      SvgPicture.asset(
        'assets/svg/hijri/${_today.hMonth}.svg',
        color: Theme.of(context).colorScheme.surface,
      ),
      const VerticalDivider(
        width: 2,
        thickness: 1,
        endIndent: 40,
        indent: 40,
      ),
      Text(
        '${_today.hDay} / ${_today.hYear}',
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'kufi',
          color: Theme.of(context).colorScheme.surface,
        ),
        textAlign: TextAlign.center,
      ),
      const VerticalDivider(
        width: 2,
        thickness: 1,
        endIndent: 40,
        indent: 40,
      ),
    ],
  );
}

Widget sorahName(String num, context, Color color) {
  return SizedBox(
    height: 50,
    child: Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          'assets/svg/surah_na.svg',
          width: 150,
        ),
        SvgPicture.asset(
          'assets/svg/surah_name/00$num.svg',
          width: 60,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ],
    ),
  );
}

Widget pageNumber(String num, context, Color color) {
  ArabicNumbers arabicNumber = ArabicNumbers();
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          'assets/svg/page_no_bg.svg',
          height: 50,
          width: 50,
        ),
        Text(
          arabicNumber.convert(num),
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'kufi',
              fontWeight: FontWeight.bold,
              color: color),
        ),
      ],
    ),
  );
}

Widget fontSizeDropDown(BuildContext context) {
  return PopupMenuButton(
    position: PopupMenuPosition.under,
    icon: Semantics(
      button: true,
      enabled: true,
      label: 'Change Font Size',
      child: Icon(
        Icons.format_size_rounded,
        size: 28,
        color: context.textDarkColor,
      ),
    ),
    color: context.textDarkColor.withOpacity(.8),
    itemBuilder: (context) => [
      PopupMenuItem(
        height: 30,
        child: SizedBox(
          height: 30,
          width: MediaQuery.sizeOf(context).width,
          child: FlutterSlider(
            values: [sl<GeneralController>().fontSizeArabic.value],
            max: 50,
            min: 18,
            rtl: true,
            trackBar: FlutterSliderTrackBar(
              inactiveTrackBarHeight: 5,
              activeTrackBarHeight: 5,
              inactiveTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.surface,
              ),
              activeTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).colorScheme.background),
            ),
            handlerAnimation: const FlutterSliderHandlerAnimation(
                curve: Curves.elasticOut,
                reverseCurve: null,
                duration: Duration(milliseconds: 700),
                scale: 1.4),
            onDragging: (handlerIndex, lowerValue, upperValue) async {
              lowerValue = lowerValue;
              upperValue = upperValue;
              sl<GeneralController>().fontSizeArabic.value = lowerValue;
            },
            handler: FlutterSliderHandler(
              decoration: const BoxDecoration(),
              child: Material(
                type: MaterialType.circle,
                color: Colors.transparent,
                elevation: 3,
                child: SvgPicture.asset('assets/svg/hadith_icon.svg'),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget beigeContainer(BuildContext context, Widget myWidget,
    {double? height, double? width}) {
  return Container(
    height: height,
    width: width,
    padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
    decoration: BoxDecoration(
        color: context.beigeDarkColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        )),
    child: myWidget,
  );
}

Widget whiteContainer(BuildContext context, Widget myWidget,
    {double? height, double? width}) {
  return Container(
    height: height,
    width: width,
    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        )),
    child: myWidget,
  );
}

widgetScreenSize(BuildContext context, Widget n1, Widget n2) {
  final width = MediaQuery.sizeOf(context).width;
  return width <= 770 ? n1 : n2;
}

double screenSize(BuildContext context, double n1, double n2) {
  final width = MediaQuery.sizeOf(context).width;
  return width <= 770 ? n1 : n2;
}

platformView(var p1, p2) {
  return (Platform.isIOS || Platform.isAndroid || Platform.isFuchsia) ? p1 : p2;
}

screenModalBottomSheet(BuildContext context, Widget child) {
  double hei = MediaQuery.sizeOf(context).height;
  double wid = MediaQuery.sizeOf(context).width;
  showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(
          maxWidth: screenSize(context, wid, 500), maxHeight: hei * .9),
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return child;
      });
}

Widget customClose(BuildContext context) {
  return GestureDetector(
    child: Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.close_outlined,
            size: 35, color: Theme.of(context).colorScheme.surface),
        Icon(Icons.close_outlined, size: 20, color: context.surfaceDarkColor),
      ],
    ),
    onTap: () {
      Navigator.of(context).pop();
    },
  );
}

Widget customClose2(BuildContext context, {var close}) {
  return Semantics(
    button: true,
    label: 'Close',
    child: GestureDetector(
      onTap: close ??
          () {
            Navigator.of(context).pop();
          },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.close_outlined,
              size: 40,
              color: Theme.of(context).colorScheme.surface.withOpacity(.5)),
          Icon(Icons.close_outlined,
              size: 24,
              color: ThemeProvider.themeOf(context).id == 'dark'
                  ? Theme.of(context).canvasColor
                  : Theme.of(context).primaryColorDark),
        ],
      ),
    ),
  );
}

dropDownModalBottomSheet(
    BuildContext context, double height, width, Widget child) {
  double hei = MediaQuery.sizeOf(context).height;
  showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(maxWidth: width, maxHeight: hei / 1 / 2),
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return child;
      });
}

Widget juzNum(String num, context, Color color, double svgWidth) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      RotatedBox(
        quarterTurns: 1,
        child: SvgPicture.asset(
          'assets/svg/juz.svg',
          width: 25,
        ),
      ),
      SvgPicture.asset('assets/svg/juz/$num.svg',
          width: svgWidth, colorFilter: ColorFilter.mode(color, BlendMode.srcIn)
          // width: 100,
          ),
    ],
  );
}

Widget topBar(BuildContext context) {
  return SizedBox(
    height: 130.0,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: .1,
          child: SvgPicture.asset('assets/svg/splash_icon.svg'),
        ),
        SvgPicture.asset(
          'assets/svg/Logo_line2.svg',
          height: 80,
          width: MediaQuery.sizeOf(context).width / 1 / 2,
        ),
        Align(
          alignment: Alignment.topRight,
          child: customClose(context),
        ),
      ],
    ),
  );
}

Widget juzNumEn(String num, context, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        num,
        style: TextStyle(
          fontSize: 12,
          fontFamily: 'kufi',
          color: ThemeProvider.themeOf(context).id == 'dark'
              ? Colors.white
              : Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
      RotatedBox(
        quarterTurns: 3,
        child: SvgPicture.asset(
          'assets/svg/juz.svg',
          width: 25,
        ),
      ),
    ],
  );
}
