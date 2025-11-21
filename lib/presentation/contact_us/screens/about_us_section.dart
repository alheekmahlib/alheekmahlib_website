import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants/svg_picture.dart';
import 'contact_section.dart';

class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Gap(32),
          alheekmahLogo(context, height: 100.0),
          const Gap(8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.12),
                  borderRadius: const BorderRadius.all(Radius.circular(999)),
                ),
                child: Text('about_title'.tr,
                    style:
                        TextStyle(color: scheme.primary, fontFamily: 'cairo')),
              ),
              const Gap(10),
              Text('about_head'.tr,
                  style: const TextStyle(
                      fontFamily: 'cairo',
                      fontWeight: FontWeight.w700,
                      fontSize: 18)),
            ],
          ),
          const Gap(12),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: ContactSection(showHeader: true),
          ),
        ],
      ),
    );
  }
}
