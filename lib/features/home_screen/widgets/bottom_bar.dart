import 'package:alheekmahlib_website/core/utils/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          boxShadow: [
            BoxShadow(
                color: context.textDarkColor.withOpacity(.3),
                blurRadius: 20,
                offset: const Offset(0, -2))
          ]),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        '${'appName'.tr} | ١٤٤٥ هـ',
        style: TextStyle(
            color: context.iconsDarkColor,
            fontFamily: 'kufi',
            fontSize: 11,
            height: 1.5),
      ),
    );
  }
}
