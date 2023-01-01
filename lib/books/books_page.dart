import 'package:alheekmahlib_website/books/routing/screenarguments.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'details.dart';

var itemIndex;
var indexI;

class BooksPage extends StatefulWidget {
  static const String routeName = '/booksPage';
  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  ScrollController? _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController!.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController!.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [

              LayoutBuilder(
                  // ignore: missing_return
                  builder: (BuildContext context, BoxConstraints constrains) {
                if (constrains.maxWidth < 600) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
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
                        FutureBuilder(
                            future: DefaultAssetBundle.of(context)
                                .loadString("assets/json/books/bookName.json"),
                            builder: (context, snapshot) {
                              var showBook = json.decode(snapshot.data.toString());
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 90, right: 16, left: 16),
                                  child: GridView.builder(
                                      itemCount: showBook.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 16,
                                              mainAxisSpacing: 16,
                                              childAspectRatio: 1.4 / 2
                                          ),
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .backgroundColor
                                                        .withOpacity(.5),
                                                    borderRadius: const BorderRadius.all(
                                                        Radius.circular(8)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Theme.of(
                                                            context)
                                                            .primaryColorLight.withOpacity(.2),
                                                        offset:
                                                        const Offset(5.0, 5.0),
                                                        blurRadius: 9)
                                                  ],
                                                ),
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      '${showBook[index]['bookD']}',
                                                      fit: BoxFit.contain,
                                                    ),
                                                    SizedBox(
                                                      width: 120,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                top: 48.0),
                                                        child: AutoSizeText(
                                                          '${showBook[index]['title']}',
                                                          style: TextStyle(
                                                              color:
                                                                  Theme.of(context)
                                                                      .canvasColor,
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'kufi'),
                                                          textAlign:
                                                              TextAlign.center,
                                                          presetFontSizes: const [
                                                            26,
                                                            15,
                                                            6
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            onTap: () {
                                              itemIndex = showBook[index]['title'];
                                              indexI = index;
                                              Navigator.pushNamed(
                                                context,
                                                DetailsScreen.routeName,
                                                arguments: ScreenArgument(
                                                  title:
                                                      '${showBook[index]['title']}',
                                                  bookQuoted:
                                                      '${showBook[index]['bookQuoted']}',
                                                  aboutBook:
                                                      '${showBook[index]['aboutBook']}',
                                                  bookD:
                                                      '${showBook[index]['bookD']}',
                                                ),
                                              );
                                            },
                                          )),
                                );
                              } else {
                                return const Center(child: CircularProgressIndicator());
                              }
                            }),
                      ],
                    ),
                  );
                } else if (constrains.maxWidth > 600) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
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
                        FutureBuilder(
                            future: DefaultAssetBundle.of(context)
                                .loadString("assets/json/books/bookName.json"),
                            builder: (context, snapshot) {
                              var showBook = json.decode(snapshot.data.toString());
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 90, right: 16, left: 16),
                                  child: GridView.builder(
                                      itemCount: showBook.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 5,
                                              crossAxisSpacing: 16,
                                              mainAxisSpacing: 16,
                                              childAspectRatio: 1.4 / 2),
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .backgroundColor
                                                      .withOpacity(.5),
                                                  borderRadius: const BorderRadius.all(
                                                      Radius.circular(8)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Theme.of(
                                                            context)
                                                            .primaryColorLight.withOpacity(.2),
                                                        offset:
                                                        const Offset(5.0, 5.0),
                                                        blurRadius: 9)
                                                  ],
                                                ),
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      '${showBook[index]['bookD']}',
                                                      fit: BoxFit.contain,
                                                    ),
                                                    SizedBox(
                                                      width: 120,
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            top: 48.0),
                                                        child: AutoSizeText(
                                                          '${showBook[index]['title']}',
                                                          style: TextStyle(
                                                              color:
                                                              Theme.of(context)
                                                                  .canvasColor,
                                                              fontSize: 18,
                                                              fontFamily:
                                                              'kufi'),
                                                          textAlign:
                                                          TextAlign.center,
                                                          presetFontSizes: const [
                                                            26,
                                                            15,
                                                            6
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            onTap: () {
                                              itemIndex = showBook[index]['title'];
                                              indexI = index;
                                              Navigator.pushNamed(
                                                context,
                                                DetailsScreen.routeName,
                                                arguments: ScreenArgument(
                                                  title:
                                                  '${showBook[index]['title']}',
                                                  bookQuoted:
                                                  '${showBook[index]['bookQuoted']}',
                                                  aboutBook:
                                                  '${showBook[index]['aboutBook']}',
                                                  bookD:
                                                  '${showBook[index]['bookD']}',
                                                ),
                                              );
                                            },
                                          )),
                                );
                              } else {
                                return const Center(child: CircularProgressIndicator());
                              }
                            }),
                      ],
                    ),
                  );
                } return Container();
              }),
            ],
          ),
        ),
      // ),
    );
  }
}
