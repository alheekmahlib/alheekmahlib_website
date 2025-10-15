import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/handler_animation.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

import '/core/utils/constants/extensions/svg_extensions.dart';
import '../../presentation/books/books.dart';
import '../../presentation/controllers/general_controller.dart';
import '../utils/constants/shared_preferences_constants.dart';
import '../utils/constants/svg_constants.dart';

class FontSizeDropDown extends StatelessWidget {
  final PopupMenuPosition position;
  const FontSizeDropDown({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      position: position,
      padding: const EdgeInsets.all(4.0),
      icon: Semantics(
        button: true,
        enabled: true,
        label: 'Change Font Size',
        child: Container(
          height: 40.0,
          width: 40.0,
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: context.theme.colorScheme.secondary.withValues(alpha: .2),
              width: 1,
            ),
          ),
          child: customSvgWithColor(SvgPath.svgFontSize,
              color: context.theme.colorScheme.secondary),
        ),
      ),
      color: context.theme.colorScheme.onPrimary.withValues(alpha: .8),
      itemBuilder: (context) => [
        PopupMenuItem(
          height: 30,
          child: SizedBox(
            height: 30,
            width: MediaQuery.sizeOf(context).width,
            child: FlutterSlider(
              values: [GeneralController.instance.fontSizeArabic.value],
              max: 50,
              min: 18,
              rtl: true,
              trackBar: FlutterSliderTrackBar(
                inactiveTrackBarHeight: 5,
                activeTrackBarHeight: 5,
                inactiveTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                activeTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Theme.of(context).colorScheme.primary),
              ),
              handlerAnimation: const FlutterSliderHandlerAnimation(
                  curve: Curves.elasticOut,
                  reverseCurve: null,
                  duration: Duration(milliseconds: 700),
                  scale: 1.4),
              onDragging: (handlerIndex, lowerValue, upperValue) async {
                final v = (lowerValue as double).clamp(20.0, 50.0);
                GeneralController.instance.fontSizeArabic.value = v;
                BooksController.instance.state.box.write(FONT_SIZE, v);
              },
              handler: FlutterSliderHandler(
                decoration: const BoxDecoration(),
                child: customSvgWithCustomColor(
                  'assets/svg/hadith_icon.svg',
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
