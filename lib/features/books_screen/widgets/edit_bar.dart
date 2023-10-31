import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/handler_animation.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/services/controllers/general_controller.dart';
import '../../../services_locator.dart';

class EditBar extends StatelessWidget {
  const EditBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Obx(
              () => FlutterSlider(
                values: [sl<GeneralController>().fontSizeArabic.value],
                max: 50,
                min: 18,
                rtl: true,
                trackBar: FlutterSliderTrackBar(
                  inactiveTrackBarHeight: 5,
                  activeTrackBarHeight: 5,
                  inactiveTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.background,
                  ),
                  activeTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).primaryColorDark),
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
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).primaryColorDark,
                    )),
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).primaryColorDark,
                  size: 22,
                )),
          ),
        ],
      ),
    );
  }
}
