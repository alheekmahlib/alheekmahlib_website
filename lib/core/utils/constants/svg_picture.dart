import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '/core/utils/constants/extensions.dart';

alheekmah_logo(BuildContext context, {double? height, double? width}) {
  return SvgPicture.asset(
    'assets/svg/alheekmah_logo.svg',
    height: height,
    width: width,
    colorFilter: ColorFilter.mode(context.textDarkColor, BlendMode.srcIn),
  );
}

decorations(BuildContext context, {double? height, double? width}) {
  return Opacity(
    opacity: .6,
    child: SvgPicture.asset(
      'assets/svg/decorations.svg',
      width: width,
      height: height ?? 60,
    ),
  );
}

spaceLine(double height, width) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: SvgPicture.asset(
      'assets/svg/space_line.svg',
      height: height,
      width: width,
    ),
  );
}

besmAllah(BuildContext context) {
  return SvgPicture.asset(
    'assets/svg/besmAllah.svg',
    width: 200,
    colorFilter: ColorFilter.mode(
        context.textDarkColor.withOpacity(.8), BlendMode.srcIn),
  );
}
