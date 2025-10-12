import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/services/controllers/general_controller.dart';
import '../../../core/utils/constants/extensions.dart';
import '../../../core/utils/constants/svg_picture.dart';
import '../../../core/utils/helpers/app_router.dart';
import '../../../services_locator.dart';

class HeroHeader extends StatelessWidget {
  const HeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width <= 770;
    final titleStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontFamily: 'cairo',
          color: context.textDarkColor,
          fontWeight: FontWeight.w700,
        );
    final subtitleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          fontFamily: 'cairo',
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        );

    final content = Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('hero_title'.tr,
            style: titleStyle,
            textAlign: isMobile ? TextAlign.center : TextAlign.start),
        const Gap(12),
        Text('hero_subtitle'.tr,
            style: subtitleStyle,
            textAlign: isMobile ? TextAlign.center : TextAlign.start),
        const Gap(20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            // ابدأ مشروعك -> تبويب التواصل (4)
            _cta(context, Icons.rocket_launch_outlined, 'cta_start_project'.tr,
                () => sl<AppRouter>().onItemTapped(4, context)),
            // تطبيقاتنا -> سكرول داخلي لقسم OurApps ضمن الرئيسية
            _ctaOutlined(context, Icons.apps_outlined, 'cta_our_apps'.tr, () {
              // انتقل للرئيسية ثم مرّر للقسم
              sl<AppRouter>().onItemTapped(0, context);
              // انتظر إطار واحد ليكون الـ Home مبنيًا ثم مرّر
              WidgetsBinding.instance.addPostFrameCallback((_) {
                sl<GeneralController>().scrollToOurApps();
              });
            }),
          ],
        ),
      ],
    );

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.surface.withValues(alpha: 0.96),
          ],
        ),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: LayoutBuilder(
        builder: (context, c) {
          if (isMobile) {
            return Column(
              children: [
                content,
                const Gap(24),
                _heroVisual(context),
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: content),
              const Gap(24),
              SizedBox(width: 380, child: _heroVisual(context)),
            ],
          );
        },
      ),
    );
  }

  Widget _heroVisual(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        alheekmah_logo(context, height: 80.0),
        Container(
          height: 240,
          decoration: BoxDecoration(
            color:
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.15)),
          ),
        ),
      ],
    );
  }

  Widget _cta(
      BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label, style: const TextStyle(fontFamily: 'cairo')),
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
    );
  }

  Widget _ctaOutlined(
      BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label, style: const TextStyle(fontFamily: 'cairo')),
      style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
    );
  }
}
