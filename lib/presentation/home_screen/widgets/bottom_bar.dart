import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/helpers/app_router.dart';
import '../../../core/widgets/language_list.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width > 820;
    final year = DateTime.now().year.toString();

    return Container(
      height: 50,
      width: width,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
        border: Border(
          top: BorderSide(color: scheme.outlineVariant, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  isWide ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                Gap(isWide ? 6 : 4),
                // CTA + حقوق النشر
                Row(
                  mainAxisAlignment: isWide
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.start,
                  children: [
                    // حقوق النشر
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.copyright,
                            size: 14, color: scheme.onSurfaceVariant),
                        const Gap(6),
                        Text(
                          '${'appName'.tr} • $year',
                          style: TextStyle(
                            color: scheme.onSurfaceVariant,
                            fontFamily: 'cairo',
                            fontSize: 12,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                    const Gap(12),
                    // زر رئيسي لبدء المشروع
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        isWide
                            ? ElevatedButton.icon(
                                onPressed: () =>
                                    sl<AppRouter>().onItemTapped(4, context),
                                icon: const Icon(Icons.send_outlined, size: 16),
                                label: Text(
                                  'cta_start_project'.tr,
                                  style: const TextStyle(fontFamily: 'cairo'),
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  shape: const StadiumBorder(),
                                ),
                              )
                            : const SizedBox.shrink(),
                        const Gap(12),
                        const LanguageList(),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
