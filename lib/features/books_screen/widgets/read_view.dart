import 'package:alheekmahlib_website/features/books_screen/models/book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';

import '/core/services/controllers/books_controller.dart';
import '/core/utils/constants/extensions.dart';
import '../../../core/services/controllers/general_controller.dart';
import '../../../services_locator.dart';
import 'edit_bar.dart';

class ReadView extends StatelessWidget {
  final String id;
  const ReadView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    sl<BooksController>().loadBooksView(id);
    return Obx(() {
      final BookView? currentBook = sl<BooksController>().booksView.value;
      if (currentBook != null && currentBook.chapters.isNotEmpty) {
        return Column(
          children: [
            const EditBar(),
            Flexible(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView.builder(
                      itemCount: currentBook.chapters.length,
                      itemBuilder: (context, index) => Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0, right: 16.0, left: 16.0),
                                child: Obx(
                                  () => TextRenderer(
                                    child: Text(
                                      currentBook.chapters[index].content,
                                      style: TextStyle(
                                          color: context.textDarkColor,
                                          fontSize: sl<GeneralController>()
                                              .fontSizeArabic
                                              .value,
                                          fontFamily: 'naskh'),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 32.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Container(
                                        height: 2,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width, // Corrected sizeOf to of
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8))),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        currentBook.chapters[index]
                                            .pageNum, // Access the chapters list
                                        style: TextStyle(
                                            color: context.textDarkColor,
                                            fontSize: 18,
                                            fontFamily: 'naskh'),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 2,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width, // Corrected sizeOf to of
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))),
            ),
          ],
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
