import 'package:alheekmahlib_website/core/utils/constants/extensions/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';

import '../../../core/services/services_locator.dart';
import '../controllers/athkar_controller.dart';
import '../models/all_azkar.dart';

class AzkarCategoryGrid extends StatelessWidget {
  const AzkarCategoryGrid({super.key});

  int _crossAxisCountForWidth(double w) {
    if (w < 600) return 2;
    if (w < 900) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    final controller = sl<AthkarController>().controller;
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = _crossAxisCountForWidth(constraints.maxWidth);
        return GridView.builder(
          controller: controller,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 3.4,
          ),
          itemCount: azkarDataList.length,
          itemBuilder: (context, index) {
            final title = azkarDataList[index].toString();
            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => context.go('/athkar/category/${index + 1}'),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(
                    color: Theme.of(context).dividerColor.withValues(alpha: .3),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextRenderer(
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: context.textDarkColor,
                            fontSize: 16,
                            fontFamily: 'cairo',
                            height: 1.3,
                          ),
                        ),
                      ),
                    ),
                    const Gap(8),
                    Icon(
                      Icons.chevron_left,
                      color: context.textDarkColor.withValues(alpha: .8),
                      size: 22,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
