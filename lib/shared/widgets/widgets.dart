import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hijri/hijri_calendar.dart';

import '../../l10n/app_localizations.dart';



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
              AppLocalizations.of(context)!.delete,
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
              AppLocalizations.of(context)!.delete,
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
    backgroundColor: Theme.of(context).bottomAppBarColor,
    content: SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              'assets/svg/line.svg',
            ),
          ),
          Container(
            width: 32,
          ),
          Expanded(
            flex: 7,
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'kufi',
                  fontStyle: FontStyle.italic,
                  fontSize: 18),
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
            color: Theme.of(context).bottomAppBarColor.withOpacity(.2),
            border: Border.symmetric(
                vertical: BorderSide(
                    color: Theme.of(context).bottomAppBarColor, width: 2))),
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
        color: Theme.of(context).bottomAppBarColor,
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
          color: Theme.of(context).bottomAppBarColor,
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
    width: 140,
    child: Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          'assets/svg/Sorah_na_bg.svg',
          height: 100,
          width: 100,
        ),
        Text(
          num,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'naskh',
              color: color),
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