import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants/extensions.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _ServiceItem(
          Icons.phone_iphone_outlined, 'svc_apps'.tr, 'svc_apps_desc'.tr),
      _ServiceItem(Icons.verified_outlined, 'svc_pro'.tr, 'svc_pro_desc'.tr),
      _ServiceItem(
          Icons.devices_other_outlined, 'svc_multi'.tr, 'svc_multi_desc'.tr),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.12),
                borderRadius: const BorderRadius.all(Radius.circular(999)),
              ),
              child: Text('services_title'.tr,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: 'cairo')),
            ),
            const Gap(10),
            Text('services_head'.tr,
                style: TextStyle(
                    fontFamily: 'cairo',
                    color: context.textDarkColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
          ],
        ),
        const Gap(12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: items.map((e) => _ServiceCard(item: e)).toList(),
          ),
        ),
      ],
    );
  }
}

class _ServiceItem {
  final IconData icon;
  final String title;
  final String desc;
  _ServiceItem(this.icon, this.title, this.desc);
}

class _ServiceCard extends StatelessWidget {
  final _ServiceItem item;
  const _ServiceCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.10),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child:
                Icon(item.icon, color: Theme.of(context).colorScheme.primary),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title,
                    style: TextStyle(
                        fontFamily: 'cairo',
                        color: context.textDarkColor,
                        fontWeight: FontWeight.w700)),
                const Gap(4),
                Text(item.desc,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontFamily: 'cairo')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
