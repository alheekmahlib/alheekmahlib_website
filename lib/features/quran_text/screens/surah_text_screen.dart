import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hijri/hijri_calendar.dart';

import '/core/services/controllers/general_controller.dart';
import '../../../services_locator.dart';
import '../../../shared/widgets/widgets.dart';
import '../Widgets/widgets.dart';
import 'surah_list_text.dart';

class SurahTextScreen extends StatelessWidget {
  const SurahTextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sl<GeneralController>().updateGreeting();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                  width: 2, color: Theme.of(context).colorScheme.surface)),
          child: widgetScreenSize(
              context,
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(child: topBar(context)),
                  ),
                  Expanded(
                    flex: 7,
                    child: SorahListText(),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 5,
                    child: SorahListText(),
                  ),
                  Expanded(
                    flex: 5,
                    child: SizedBox(child: topBar(context)),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget topBar(BuildContext context) {
    var today = HijriCalendar.now();
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: .1,
          child: SvgPicture.asset(
            'assets/svg/hijri/${today.hMonth}.svg',
            width: MediaQuery.sizeOf(context).width,
            colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.surface, BlendMode.srcIn),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            // height: platformView(100.0, 150.0),
            width: 160.0,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                    color: Theme.of(context).colorScheme.surface, width: 1)),
            padding: const EdgeInsets.only(top: 4),
            margin: const EdgeInsets.only(top: 16.0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 75.0,
                  width: 155.0,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      )),
                ),
                hijriDate2(context),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: greeting(context),
        ),
      ],
    );
  }
}
