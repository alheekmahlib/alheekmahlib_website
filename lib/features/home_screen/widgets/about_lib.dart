import 'package:alheekmahlib_website/core/utils/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';

import '../../../core/utils/constants/svg_picture.dart';

class AboutLib extends StatelessWidget {
  const AboutLib({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: alheekmah_logo(context, height: 50),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextRenderer(
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: "مكتبة غير ربحية تختص بعمل التطبيقات الإسلامية.\n",
                    style: TextStyle(
                        color: context.textDarkColor,
                        fontFamily: 'kufi',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        height: 1.5),
                  ),
                  TextSpan(
                    text:
                        "هدفها الأرتقاء بالمسلمين لأعلى درجات الوعي الديني وازالة كل مفاهيم التشوية والتظليل على المسلمين التي تراكمت على مدى عقود.",
                    style: TextStyle(
                        color: context.textDarkColor,
                        fontFamily: 'kufi',
                        fontSize: 16,
                        height: 1.5),
                  )
                ]),
                textAlign: TextAlign.justify,
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
