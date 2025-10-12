import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '/core/services/controllers/general_controller.dart';
import '/shared/widgets/widgets.dart';
import '../../../our_app_info_model.dart';
import '../../../services_locator.dart';
import 'apps_info.dart';

class OurApps extends StatelessWidget {
  const OurApps({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.12),
                  borderRadius: const BorderRadius.all(Radius.circular(999)),
                ),
                child: Text('ourApps'.tr,
                    style:
                        TextStyle(color: scheme.primary, fontFamily: 'kufi')),
              ),
              const SizedBox(width: 10),
              Text(
                'ourApps'.tr,
                style: const TextStyle(
                  fontFamily: 'kufi',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 0,
            color: scheme.surfaceContainerHigh,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(builder: (context, c) {
                final w = c.maxWidth;
                int crossAxisCount = 1;
                if (w >= 1100) {
                  crossAxisCount = 3;
                } else if (w >= 700) {
                  crossAxisCount = 2;
                }
                // اختر نسبة أبعاد تمنح ارتفاعًا أكبر على الشاشات الصغيرة لمنع overflow
                double aspect;
                if (crossAxisCount == 1) {
                  aspect = 1.18; // ارتفاع أكبر
                } else if (crossAxisCount == 2) {
                  aspect = 1.25;
                } else {
                  aspect = 4 / 3.1; // المناسب للشاشات العريضة
                }
                return FutureBuilder<List<OurAppInfo>>(
                  future: sl<GeneralController>().fetchApps(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _AppsGridSkeleton(crossAxisCount: crossAxisCount);
                    }
                    if (snapshot.hasError) {
                      return Center(
                          child: Text('Error: ${snapshot.error}',
                              style: TextStyle(
                                  color: scheme.error,
                                  fontFamily: 'cairo',
                                  fontSize: 12)));
                    }
                    final apps = snapshot.data;
                    if (apps == null || apps.isEmpty) {
                      return Center(
                        child: Text(
                          '—',
                          style: TextStyle(color: scheme.onSurfaceVariant),
                        ),
                      );
                    }
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: aspect,
                      ),
                      itemCount: apps.length,
                      itemBuilder: (context, index) {
                        final app = apps[index];
                        return _AppCard(app: app);
                      },
                    );
                  },
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _AppCard extends StatefulWidget {
  const _AppCard({required this.app});
  final OurAppInfo app;

  @override
  State<_AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<_AppCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final app = widget.app;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: scheme.outlineVariant),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: scheme.shadow.withValues(alpha: 0.08),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  )
                ]
              : [],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => screenModalBottomSheet(
            context,
            AppsInfo(
              appLogo: app.appLogo,
              appName: app.appTitle,
              appStoreIUrl: app.urlAppStore,
              playStoreUrl: app.urlPlayStore,
              appGalleryUrl: app.urlAppGallery,
              appStoreDUrl: app.urlMacAppStore,
              banner1: app.banner1,
              banner2: app.banner2,
              banner3: app.banner3,
              banner4: app.banner4,
              aboutApp3: app.aboutApp3,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Banner
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14)),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    app.appBanner,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: scheme.surfaceContainerHighest,
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(scheme.primary),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (_, __, ___) => Container(
                      color: scheme.surfaceContainerHighest,
                      alignment: Alignment.center,
                      child: Icon(Icons.image_not_supported_outlined,
                          color: scheme.onSurfaceVariant),
                    ),
                  ),
                ),
              ),
              // Title/Logo
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
                child: Row(
                  children: [
                    SvgPicture.network(app.appLogo, width: 22, height: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        app.appTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'kufi',
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Description
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Text(
                  app.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 13,
                    height: 1.35,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppsGridSkeleton extends StatelessWidget {
  const _AppsGridSkeleton({required this.crossAxisCount});
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final placeholders =
        List.generate(crossAxisCount * 2, (_) => const SizedBox());
    // نسبة الأبعاد متوافقة مع الشبكة الرئيسية
    double aspect;
    if (crossAxisCount == 1) {
      aspect = 1.18;
    } else if (crossAxisCount == 2) {
      aspect = 1.25;
    } else {
      aspect = 4 / 3;
    }
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: aspect,
      ),
      itemCount: placeholders.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 12,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
