import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/utils/constants/extensions/dimensions.dart';
import '../../presentation/controllers/general_controller.dart';
import '../services/services_locator.dart';
import '../utils/helpers/app_router.dart';

class TabBarUI extends StatelessWidget {
  TabBarUI({super.key});

  final generalCtrl = GeneralController.instance;

  @override
  Widget build(BuildContext context) {
    final tapViews = [
      'home'.tr,
      'quran'.tr,
      'books'.tr,
      'azkar'.tr,
      'contact_title'.tr
    ];

    final general = sl<GeneralController>();
    final navigation = sl<AppRouter>();

    return Container(
      // height: screenSize(context, 240.0, 56.0),
      width: MediaQuery.sizeOf(context).width,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.12),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Obx(() => _WebTabs(
            labels: tapViews,
            selectedIndex: general.tapIndex.value,
            onTap: (i) {
              general.tapIndex.value = i;
              navigation.calculateSelectedIndex(context);
              navigation.onItemTapped(i, context);
            },
            hoveredIndex: generalCtrl.hoveredIndex?.value,
            onHover: (i) => generalCtrl.hoveredIndex?.value = i!,
          )),
    );
  }
}

class _WebTabs extends StatelessWidget {
  const _WebTabs({
    required this.labels,
    required this.selectedIndex,
    required this.onTap,
    required this.hoveredIndex,
    required this.onHover,
  });

  final List<String> labels;
  final int selectedIndex;
  final void Function(int) onTap;
  final int? hoveredIndex;
  final void Function(int?) onHover;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // final totalWidth = constraints.maxWidth;
        // // حشوة داخلية للحاوية لتبدو كـ Segmented Control
        // const inset = 6.0;
        // final n = labels.length;
        // final segmentWidth = (totalWidth - (inset * 2)) / n;

        return Wrap(
          alignment: WrapAlignment.center,
          children: List.generate(labels.length, (i) {
            final selected = selectedIndex == i;

            return SizedBox(
              width: 110,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: MouseRegion(
                  onEnter: (_) => onHover(i),
                  onExit: (_) => onHover(null),
                  cursor: SystemMouseCursors.click,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    curve: Curves.easeOut,
                    height: 40,
                    decoration: BoxDecoration(
                      color: selected
                          ? Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.25)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => onTap(i),
                      child: Center(
                        child: Text(
                          labels[i],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'cairo',
                            color: context.textDarkColor,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
