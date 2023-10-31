import 'package:flutter/material.dart';

import '/features/home_screen/widgets/dwaa_daily.dart';
import '/shared/widgets/widgets.dart';
import '../widgets/build_list_item.dart';

class AzkarView extends StatelessWidget {
  const AzkarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              width: 2,
              color: Theme.of(context).colorScheme.surface,
            )),
        margin: const EdgeInsets.only(bottom: 32.0),
        child: widgetScreenSize(
          context,
          const Column(
            children: [
              DwaaDaily(),
              Expanded(child: BuildListItem()),
            ],
          ),
          const Row(
            children: [
              Expanded(
                flex: 4,
                child: BuildListItem(),
              ),
              Expanded(
                flex: 4,
                child: DwaaDaily(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
