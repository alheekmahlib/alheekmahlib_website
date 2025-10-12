import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FaqSection extends StatefulWidget {
  const FaqSection({super.key});

  @override
  State<FaqSection> createState() => _FaqSectionState();
}

class _FaqSectionState extends State<FaqSection> {
  final expanded = <int>{0};

  @override
  Widget build(BuildContext context) {
    // نبني القائمة ديناميكيًا حتى 12 عنصرًا ونتجاهل المفاتيح غير المعرّبة
    final faqs = <(String, String)>[];
    for (var i = 1; i <= 12; i++) {
      final qKey = 'faq_q$i';
      final aKey = 'faq_a$i';
      final q = qKey.tr;
      final a = aKey.tr;
      // إذا لم تتوافر ترجمة حقيقية، نتجاهل هذا الإدخال
      if (q != qKey && a != aKey) {
        faqs.add((q, a));
      }
    }
    // حذف أول 3 أسئلة حسب طلبك
    if (faqs.length >= 3) {
      faqs.removeRange(0, 3);
    } else {
      faqs.clear();
    }
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
            Text('faq_title'.tr,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontFamily: 'cairo', fontWeight: FontWeight.w700)),
          ],
        ),
        const Gap(12),
        Material(
          color: Theme.of(context).colorScheme.surface,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          clipBehavior: Clip.antiAlias,
          child: ExpansionPanelList(
            expansionCallback: (i, isOpen) {
              setState(() {
                if (isOpen) {
                  expanded.remove(i);
                } else {
                  expanded.add(i);
                }
              });
            },
            elevation: 0,
            materialGapSize: 0,
            children: [
              for (int i = 0; i < faqs.length; i++)
                () {
                  final index = i; // تثبيت الفهرس داخل الإغلاق
                  return ExpansionPanel(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    canTapOnHeader: false,
                    isExpanded: expanded.contains(index),
                    headerBuilder: (context, isOpen) => InkWell(
                      onTap: () {
                        setState(() {
                          if (expanded.contains(index)) {
                            expanded.remove(index);
                          } else {
                            expanded.add(index);
                          }
                        });
                      },
                      child: ListTile(
                        title: Text(faqs[index].$1,
                            style: const TextStyle(fontFamily: 'cairo')),
                      ),
                    ),
                    body: ListTile(
                      title: Text(faqs[index].$2,
                          style: const TextStyle(fontFamily: 'cairo')),
                    ),
                  );
                }(),
            ],
          ),
        ),
      ],
    );
  }
}
