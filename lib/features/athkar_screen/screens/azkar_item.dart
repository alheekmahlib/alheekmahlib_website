import 'package:alheekmahlib_website/core/services/controllers/athkar_controller.dart';
import 'package:alheekmahlib_website/core/utils/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/services/controllers/general_controller.dart';
import '../../../core/services/controllers/quranText_controller.dart';
import '../../../services_locator.dart';
import '../../../shared/widgets/widgets.dart';

class AzkarItem extends StatelessWidget {
  const AzkarItem({Key? key, required this.azkar}) : super(key: key);
  final String azkar;

  @override
  Widget build(BuildContext context) {
    final athkar = sl<AthkarController>();
    athkar.getAzkarByCategory(azkar);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: beigeContainer(
            context,
            whiteContainer(
              context,
              TextRenderer(
                child: Text(
                  athkar.azkarList.first.category!,
                  style: TextStyle(
                    color: context.surfaceDarkColor,
                    fontSize: 16.0,
                    fontFamily: 'kufi',
                  ),
                ),
              ),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                sl<GeneralController>().textWidgetPosition.value = -240.0;
                sl<QuranTextController>().selected.value = false;
              },
              icon: Icon(
                Icons.arrow_back,
                size: 28,
                color: context.textDarkColor,
              )),
          actions: [
            fontSizeDropDown(context),
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64.0),
              child: Obx(
                () => ListView.builder(
                    itemCount: athkar.azkarList.length,
                    itemBuilder: (context, index) {
                      final azkar = athkar.azkarList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: beigeContainer(
                          context,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: whiteContainer(
                                  context,
                                  width: double.infinity,
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Obx(() {
                                      return TextRenderer(
                                        child: SelectableText(
                                          azkar.zekr!,
                                          style: TextStyle(
                                              color: context.textDarkColor,
                                              height: 1.4,
                                              fontFamily: 'naskh',
                                              fontSize: sl<GeneralController>()
                                                  .fontSizeArabic
                                                  .value),
                                          showCursor: true,
                                          cursorWidth: 3,
                                          cursorColor:
                                              Theme.of(context).dividerColor,
                                          cursorRadius:
                                              const Radius.circular(5),
                                          scrollPhysics:
                                              const ClampingScrollPhysics(),
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.justify,
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: whiteContainer(
                                        context,
                                        TextRenderer(
                                          child: Text(
                                            azkar.reference!,
                                            style: TextStyle(
                                                color: context.textDarkColor,
                                                fontSize: 12,
                                                fontFamily: 'kufi',
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ))),
                              ),
                              azkar.description == ''
                                  ? const SizedBox.shrink()
                                  : Align(
                                      alignment: Alignment.center,
                                      child: whiteContainer(
                                          context,
                                          TextRenderer(
                                            child: Text(
                                              azkar.description!,
                                              style: TextStyle(
                                                  color: context.textDarkColor,
                                                  fontSize: 16,
                                                  fontFamily: 'kufi',
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ))),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: whiteContainer(
                                  context,
                                  width: double.infinity,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Share.share(
                                                  '${azkar.category}\n\n'
                                                  '${azkar.zekr}\n\n'
                                                  '| ${azkar.description}. | (التكرار: ${azkar.count})');
                                            },
                                            icon: Semantics(
                                              button: true,
                                              enabled: true,
                                              label: 'share',
                                              child: Icon(
                                                Icons.share,
                                                color: context.textDarkColor,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              await Clipboard.setData(ClipboardData(
                                                      text:
                                                          '${azkar.category}\n\n${azkar.zekr}\n\n| ${azkar.description}. | (التكرار: ${azkar.count})'))
                                                  .then((value) =>
                                                      customSnackBar(context,
                                                          'copyAzkarText'.tr));
                                            },
                                            icon: Semantics(
                                              button: true,
                                              enabled: true,
                                              label: 'copyAzkarText'.tr,
                                              child: Icon(
                                                Icons.copy,
                                                color: context.textDarkColor,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          ),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              azkar.count!,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColorDark,
                                                  fontSize: 14,
                                                  fontFamily: 'kufi',
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.repeat,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
