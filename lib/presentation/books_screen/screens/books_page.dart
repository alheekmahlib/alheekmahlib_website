import 'package:alheekmahlib_website/core/utils/constants/extensions/dimensions.dart';
import 'package:alheekmahlib_website/presentation/books_screen/controllers/books_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/widgets/widgets.dart';

class BooksPage extends StatelessWidget {
  static const String routeName = '/booksPage';

  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final books = sl<BooksController>();
    books.loadBooksName();
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            width: 2,
            color: Theme.of(context).colorScheme.surface,
          )),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: Stack(
                children: [
                  Center(
                    child: Opacity(
                      opacity: .05,
                      child: SvgPicture.asset(
                        'assets/svg/thegarlanded.svg',
                      ),
                    ),
                  ),
                  Obx(() {
                    if (books.types.isNotEmpty) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 90, right: 16, left: 16),
                        child: ListView.builder(
                          itemCount: books.types.length,
                          itemBuilder: (context, typesIndex) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    books.types[typesIndex].name,
                                    style: TextStyle(
                                        color: context.textDarkColor,
                                        fontSize: 20,
                                        fontFamily: 'cairo'),
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    height: 5,
                                    width:
                                        MediaQuery.sizeOf(context).width * .7,
                                    margin: const EdgeInsets.only(right: 32.0),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8))),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 280,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      books.types[typesIndex].books.length,
                                  itemBuilder: (context, index) => Wrap(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: GestureDetector(
                                          child: beigeContainer(
                                              context,
                                              height: 210,
                                              width: 150,
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(8)),
                                                    child: SvgPicture.asset(
                                                      books.types[typesIndex]
                                                          .books[index].bookD,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  FittedBox(
                                                    child: SizedBox(
                                                      height: 120,
                                                      width: 120,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 48.0),
                                                        child: Text(
                                                          books
                                                              .types[typesIndex]
                                                              .books[index]
                                                              .title,
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .canvasColor,
                                                              fontSize: 20,
                                                              fontFamily:
                                                                  'cairo'),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          onTap: () {
                                            books.typesNumber = typesIndex;
                                            books.bookNumber = index;
                                            books.bookId = books
                                                .types[typesIndex]
                                                .books[index]
                                                .id;
                                            context.go(
                                                '/books/details/${books.types[typesIndex].books[index].id}');
                                          },
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
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
