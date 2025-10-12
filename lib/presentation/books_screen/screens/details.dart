import 'package:alheekmahlib_website/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../widgets/about_book.dart';
import '../widgets/top_details_widget.dart';

class DetailsScreen extends StatelessWidget {
  final String id;
  final String title;
  final String bookQuoted;
  final String aboutBook;
  final String bookD;

  const DetailsScreen(
      {super.key,
      required this.id,
      required this.title,
      required this.bookQuoted,
      required this.aboutBook,
      required this.bookD});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: widgetScreenSize(
            context,
            Column(
              children: [
                Expanded(
                    flex: 3, child: TopDetails(title: title, bookD: bookD)),
                Expanded(
                  flex: 7,
                  child: AboutBook(
                      id: id,
                      title: title,
                      bookQuoted: bookQuoted,
                      aboutBook: aboutBook),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 3, child: TopDetails(title: title, bookD: bookD)),
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 140.0),
                    child: AboutBook(
                        id: id,
                        title: title,
                        bookQuoted: bookQuoted,
                        aboutBook: aboutBook),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
