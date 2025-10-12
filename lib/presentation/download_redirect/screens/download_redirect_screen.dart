import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/download_redirect_controller.dart';

class DownloadRedirectScreen extends StatelessWidget {
  const DownloadRedirectScreen({super.key, required this.slug});
  final String slug;

  @override
  Widget build(BuildContext context) {
    Get.put(DownloadRedirectController(slug: slug));
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GetBuilder<DownloadRedirectController>(
              builder: (c) {
                final a = c.app;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (a != null) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            a.appBanner,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: scheme.surfaceContainerHighest,
                              alignment: Alignment.center,
                              child: Icon(Icons.image_not_supported_outlined,
                                  color: scheme.onSurfaceVariant),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    Text(
                      'download_page_title'.tr,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontFamily: 'kufi',
                                fontWeight: FontWeight.w700,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      c.error ??
                          (c.loading
                              ? 'detecting_platform'.tr
                              : 'redirecting_store'.tr),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontFamily: 'cairo',
                            color: c.error != null
                                ? scheme.error
                                : scheme.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 16),
                    if (a != null)
                      FilledButton.icon(
                        onPressed: c.openStoreNow,
                        icon: const Icon(Icons.open_in_new),
                        label: Text('open_store_button'.tr,
                            style: const TextStyle(fontFamily: 'kufi')),
                      ),
                    if (c.error != null) ...[
                      const SizedBox(height: 8),
                      Text('app_not_found'.tr,
                          style: TextStyle(
                              color: scheme.error, fontFamily: 'cairo')),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
