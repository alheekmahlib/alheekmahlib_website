import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';
import 'package:share_plus/share_plus.dart';

import '/core/utils/constants/extensions.dart';
import '../../../services_locator.dart';
import '../../../shared/widgets/widgets.dart';
import '../../athkar_screen/controllers/athkar_controller.dart';

class DwaaDaily extends StatelessWidget {
  const DwaaDaily({super.key});

  @override
  Widget build(BuildContext context) {
    final athkar = sl<AthkarController>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: beigeContainer(
        context,
        width: 420,
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'dwaaDaily'.tr,
                  style: TextStyle(
                    color: context.textDarkColor,
                    fontFamily: 'cairo',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      tooltip: 'refresh',
                      onPressed: () => athkar.shuffleDailyDua(),
                      icon: Icon(
                        Icons.refresh,
                        color: context.textDarkColor,
                        size: 20,
                      ),
                    ),
                    IconButton(
                      tooltip: 'share',
                      onPressed: () {
                        final text = athkar.dailyDua.value.isNotEmpty
                            ? athkar.dailyDua.value
                            : (athkar.element ?? '');
                        if (text.trim().isEmpty) return;
                        SharePlus.instance
                            .share(ShareParams(text: text.trim()));
                      },
                      icon: Icon(
                        Icons.share,
                        color: context.textDarkColor,
                        size: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
            whiteContainer(
              context,
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Obx(() {
                  final text = athkar.dailyDua.value;
                  return TextRenderer(
                    child: Text(
                      text.isEmpty ? (athkar.element ?? '') : text,
                      style: TextStyle(
                        color: context.textDarkColor,
                        fontFamily: 'naskh',
                        fontSize: 22,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
