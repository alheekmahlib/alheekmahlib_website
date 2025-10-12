import 'package:flutter/material.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';

import '/core/utils/constants/extensions.dart';
import '../../../core/widgets/widgets.dart';
import 'read_view.dart';

class AboutBook extends StatelessWidget {
  final String id;
  final String title;
  final String bookQuoted;
  final String aboutBook;
  const AboutBook(
      {super.key,
      required this.id,
      required this.title,
      required this.bookQuoted,
      required this.aboutBook});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 16),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: TextRenderer(
                                child: SelectableText(
                                  title,
                                  style: TextStyle(
                                      color: context.textDarkColor,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'cairo'),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  screenModalBottomSheet(
                                      context,
                                      ReadView(
                                        id: id,
                                      ));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: context.surfaceDarkColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                  child: Text(
                                    "قراءة",
                                    style: TextStyle(
                                        color: context.iconsLightColor,
                                        fontSize: 20,
                                        fontFamily: 'cairo'),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        TextRenderer(
                          child: SelectableText(
                            bookQuoted,
                            style: TextStyle(
                                color: context.textDarkColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'cairo'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'عن الكتاب',
                      style: TextStyle(
                          color: context.textDarkColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cairo'),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surface
                          .withValues(alpha: .3),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: TextRenderer(
                        child: SelectableText(
                          aboutBook,
                          style: TextStyle(
                              color: context.textDarkColor,
                              fontSize: 22,
                              fontFamily: 'naskh'),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
