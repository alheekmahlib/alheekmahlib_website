import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '/features/home_screen/widgets/dwaa_daily.dart';
import '/shared/widgets/widgets.dart';
import '../widgets/azkar_category_grid.dart';

class AzkarView extends StatelessWidget {
  const AzkarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0, bottom: 48.0),
          child: widgetScreenSize(
            context,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DwaaDaily(),
                  Gap(16),
                  Expanded(child: AzkarCategoryGrid()),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: AzkarCategoryGrid(),
                  ),
                  Gap(16),
                  Expanded(
                    flex: 4,
                    child: DwaaDaily(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
