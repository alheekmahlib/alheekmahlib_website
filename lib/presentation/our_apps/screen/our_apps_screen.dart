part of '../our_apps.dart';

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
                        TextStyle(color: scheme.primary, fontFamily: 'cairo')),
              ),
              const Gap(10),
              Text(
                'ourApps'.tr,
                style: const TextStyle(
                  fontFamily: 'cairo',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const Gap(12),
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
                  aspect = 1.12; // ارتفاع أكبر
                } else if (crossAxisCount == 2) {
                  aspect = 1.25;
                } else {
                  aspect = 4 / 3.2; // المناسب للشاشات العريضة
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
                        return _AppCard(app);
                      },
                    );
                  },
                );
              }),
            ),
          ),
          const Gap(16),
        ],
      ),
    );
  }
}
