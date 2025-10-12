import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../core/services/controllers/general_controller.dart';
import '../../../services_locator.dart';

class ExpandableText extends StatelessWidget {
  const ExpandableText({
    required this.text,
    super.key,
    this.readLessText,
    this.readMoreText,
    this.animationDuration = const Duration(milliseconds: 200),
    this.maxHeight = 70,
    this.textStyle,
    this.iconCollapsed,
    this.iconExpanded,
    this.textAlign = TextAlign.center,
    this.iconColor = Colors.black,
    this.buttonTextStyle,
  });

  final String text;
  final String? readLessText;
  final String? readMoreText;
  final Duration animationDuration;
  final double maxHeight;
  final TextStyle? textStyle;
  final Widget? iconExpanded;
  final Widget? iconCollapsed;
  final TextAlign textAlign;
  final Color iconColor;
  final TextStyle? buttonTextStyle;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    final baseStyle = (textStyle ?? const TextStyle()).copyWith(
      fontSize: (textStyle?.fontSize ??
          (sl<GeneralController>().fontSizeArabic.value - 8)),
      fontFamily: textStyle?.fontFamily ?? 'cairo',
      color: textStyle?.color ?? textColor,
    );

    return Obx(() {
      final expanded = sl<GeneralController>().isExpanded.value;
      return Column(
        children: <Widget>[
          AnimatedSize(
            duration: animationDuration,
            child: ConstrainedBox(
              constraints: expanded
                  ? const BoxConstraints()
                  : BoxConstraints(maxHeight: maxHeight),
              child: expanded
                  ? SelectableText(
                      text,
                      textAlign: textAlign,
                      style: baseStyle,
                      textDirection: TextDirection.ltr,
                    )
                  : Text(
                      text,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      textAlign: textAlign,
                      style: baseStyle,
                      textDirection: TextDirection.ltr,
                    ),
            ),
          ),
          expanded
              ? ConstrainedBox(
                  constraints: const BoxConstraints(),
                  child: TextButton.icon(
                    icon: Text(
                      readLessText ?? 'Read less',
                      style: buttonTextStyle ??
                          Theme.of(context).textTheme.titleMedium,
                    ),
                    label: iconExpanded ??
                        Icon(
                          Icons.arrow_drop_up,
                          color: iconColor,
                        ),
                    onPressed: () =>
                        sl<GeneralController>().isExpanded.value = false,
                  ),
                )
              : TextButton.icon(
                  icon: Text(
                    readMoreText ?? 'Read more',
                    style: buttonTextStyle ??
                        Theme.of(context).textTheme.titleMedium,
                  ),
                  label: iconCollapsed ??
                      Icon(
                        Icons.arrow_drop_down,
                        color: iconColor,
                      ),
                  onPressed: () =>
                      sl<GeneralController>().isExpanded.value = true,
                ),
        ],
      );
    });
  }
}
