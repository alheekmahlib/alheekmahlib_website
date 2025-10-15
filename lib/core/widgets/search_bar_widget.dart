import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/utils/constants/extensions/extensions.dart';
import '/core/utils/constants/extensions/svg_extensions.dart';
import '../utils/constants/svg_constants.dart';

class TextFieldBarWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final void Function()? onPressed;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final double? horizontalPadding;
  final bool? boxShadow;
  final Color? fillColor;
  final Color? enabledBorderColor;
  final Color? hintTextColor;
  final Color? iconColor;
  final double? containerHeight;
  const TextFieldBarWidget(
      {super.key,
      this.controller,
      this.hintText,
      this.prefixIcon,
      this.onPressed,
      this.onChanged,
      this.onSubmitted,
      this.horizontalPadding,
      this.boxShadow = true,
      this.fillColor,
      this.enabledBorderColor,
      this.hintTextColor,
      this.iconColor,
      this.containerHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight ?? 40,
      width: MediaQuery.sizeOf(context).width,
      margin: EdgeInsets.symmetric(
          vertical: 8.0, horizontal: horizontalPadding ?? 32.0),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8.0), boxShadow: [
        BoxShadow(
          color: boxShadow!
              ? Colors.grey.withValues(alpha: .5)
              : Colors.transparent,
          blurRadius: 4.0,
          offset: const Offset(0, 0),
        ),
      ]),
      child: SizedBox(
        height: 50,
        width: context.customOrientation(MediaQuery.sizeOf(context).width * .7,
            MediaQuery.sizeOf(context).width * .5),
        child: TextField(
          controller: controller,
          maxLines: 1,
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: 'naskh',
            fontWeight: FontWeight.w600,
            color:
                hintTextColor ?? context.theme.hintColor.withValues(alpha: .7),
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            hintText: hintText ?? 'search_word'.tr,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: enabledBorderColor ?? Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: enabledBorderColor ?? Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: enabledBorderColor ?? Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            hintStyle: TextStyle(
              fontSize: 14.0,
              fontFamily: 'cairo',
              fontWeight: FontWeight.w600,
              color: hintTextColor ??
                  context.theme.colorScheme.surface.withValues(alpha: .3),
            ),
            filled: true,
            fillColor:
                fillColor ?? context.theme.colorScheme.secondaryContainer,
            prefixIcon: prefixIcon ??
                Container(
                  height: 20,
                  padding: const EdgeInsets.all(10.0),
                  child: customSvgWithColor(
                    SvgPath.svgSearchIcon,
                    height: 35,
                    color: iconColor ?? context.theme.colorScheme.primary,
                  ),
                ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.close,
                color: iconColor ?? context.theme.hintColor,
              ),
              onPressed: onPressed,
            ),
            labelText: hintText ?? 'search_word'.tr,
            labelStyle: TextStyle(
              fontSize: 14.0,
              fontFamily: 'cairo',
              color: hintTextColor?.withValues(alpha: .7) ??
                  context.theme.hintColor.withValues(alpha: .7),
            ),
          ),
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ),
    );
  }
}
