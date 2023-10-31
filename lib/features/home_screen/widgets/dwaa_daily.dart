import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';

import '/core/utils/constants/extensions.dart';
import '../../../core/services/controllers/athkar_controller.dart';
import '../../../services_locator.dart';
import '../../../shared/widgets/widgets.dart';

class DwaaDaily extends StatelessWidget {
  const DwaaDaily({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: beigeContainer(
          context,
          width: 350,
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'dwaaDaily'.tr,
                  style: TextStyle(
                      color: context.textDarkColor,
                      fontFamily: 'kufi',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      height: 1.5),
                ),
              ),
              whiteContainer(
                context,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextRenderer(
                    child: Text(
                      sl<AthkarController>().element!,
                      style: TextStyle(
                          color: context.textDarkColor,
                          fontFamily: 'naskh',
                          fontSize: 22,
                          height: 1.5),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
