import 'package:another_xlider/another_xlider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import '../books/routing/screenarguments.dart';
import 'dart:convert';
import 'books_page.dart';



class DetailsScreen extends StatefulWidget {
  static const routeName = '/bookspage/detailsscreen';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with WidgetsBindingObserver {
  PageController? controller;
  String text = '';
  bool isShowControl = true;
  double lowerValue = 18;
  double upperValue = 40;
  double fontSize = 18;

  showControl() {
    setState(() {
      isShowControl = !isShowControl;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    controller = PageController(
      viewportFraction: .7,
      initialPage: 0,
    );
    isShowControl = false;
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  final PanelController _pc = PanelController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArgument;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString("assets/json/books/bookName.json"),
            builder: (context, snapshot) {
              var showDetails = json.decode(snapshot.data.toString());
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1 / 2,
                        height: MediaQuery.of(context).size.height,
                        color: Theme.of(context).backgroundColor,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 16),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Opacity(
                                  opacity: 0.1,
                                  child: SizedBox(
                                    width: 360,
                                    child: SvgPicture.asset(
                                      '${showDetails[indexI]['bookD']}',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 260,
                                  child: SvgPicture.asset(
                                    '${showDetails[indexI]['bookD']}',
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 100.0),
                                    child: AutoSizeText(
                                      args.title!,
                                      style: TextStyle(
                                          color: Theme.of(context).canvasColor,
                                          fontSize: 28,
                                          fontFamily: 'kufi'),
                                      textAlign: TextAlign.center,
                                      presetFontSizes: const [
                                        28,
                                        18,
                                        8
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    icon: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          border: Border.all(
                                            width: 1,
                                            color: Theme.of(context)
                                                .bottomAppBarColor,
                                          )),
                                      child: Icon(
                                        Icons.arrow_back,
                                        size: 20,
                                        color:
                                            Theme.of(context).bottomAppBarColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          width: MediaQuery.of(context).size.width / 1 / 2,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 40,
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).bottomAppBarColor,
                                      borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 60, right: 32, bottom: 64),
                                child: ListView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SelectableText(
                                            args.title!,
                                            style: TextStyle(
                                                color: ThemeProvider.themeOf(
                                                    context)
                                                    .id ==
                                                    'dark'
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'kufi'),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          SelectableText(
                                            args.bookQuoted!,
                                            style: TextStyle(
                                                color: ThemeProvider.themeOf(
                                                                context)
                                                            .id ==
                                                        'dark'
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'kufi'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 64,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Text(
                                        'عن الكتاب',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .bottomAppBarColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'kufi'),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Container(
                                      color: Theme.of(context)
                                          .bottomAppBarColor
                                          .withOpacity(.3),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 16),
                                        child: SelectableText(
                                          args.aboutBook!,
                                          style: TextStyle(
                                              color: ThemeProvider.themeOf(
                                                  context)
                                                  .id ==
                                                  'dark'
                                                  ? Colors.white
                                                  : Theme.of(context)
                                                  .primaryColorDark,
                                              fontSize: 22,
                                              fontFamily: 'naskh'),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    SlidingUpPanel(
                      renderPanelSheet: false,
                      controller: _pc,
                      panel: _floatingPanel(),
                      collapsed: _floatingCollapsed(),
                    ),
                    Visibility(
                      visible: isShowControl,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 40.0),
                          child: Container(
                            height: 48,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 32.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).bottomAppBarColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  width: 150,
                                  child: FlutterSlider(
                                    values: [fontSize],
                                    max: 40,
                                    min: 18,
                                    rtl: true,
                                    trackBar: FlutterSliderTrackBar(
                                      inactiveTrackBarHeight: 5,
                                      activeTrackBarHeight: 5,
                                      inactiveTrackBar: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                      activeTrackBar: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Theme.of(context)
                                              .backgroundColor),
                                    ),
                                    handlerAnimation:
                                        const FlutterSliderHandlerAnimation(
                                            curve: Curves.elasticOut,
                                            reverseCurve: null,
                                            duration:
                                                Duration(milliseconds: 700),
                                            scale: 1.4),
                                    onDragging:
                                        (handlerIndex, lowerValue, upperValue) {
                                      lowerValue = lowerValue;
                                      upperValue = upperValue;
                                      fontSize = lowerValue;
                                      setState(() {});
                                    },
                                    handler: FlutterSliderHandler(
                                      decoration: const BoxDecoration(),
                                      child: Material(
                                        type: MaterialType.circle,
                                        color: Colors.transparent,
                                        elevation: 3,
                                        child: SvgPicture.asset(
                                            'assets/svg/slider_ic.svg'),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _pc.close();
                                      showControl();
                                    });
                                  },
                                  icon: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          border: Border.all(
                                            width: 1,
                                            color:
                                                Theme.of(context).canvasColor,
                                          )),
                                      child: Icon(
                                        Icons.close,
                                        color: Theme.of(context).canvasColor,
                                        size: 20,
                                      )),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (controller!.hasClients) {
                                        controller!.previousPage(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                    });
                                  },
                                  icon: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          border: Border.all(
                                            width: 1,
                                            color:
                                                Theme.of(context).canvasColor,
                                          )),
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Theme.of(context).canvasColor,
                                        size: 20,
                                      )),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (controller!.hasClients) {
                                        controller!.nextPage(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                    });
                                  },
                                  icon: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          border: Border.all(
                                            width: 1,
                                            color:
                                                Theme.of(context).canvasColor,
                                          )),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Theme.of(context).canvasColor,
                                        size: 20,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Widget _floatingCollapsed() {
    return GestureDetector(
      onTap: () {
        _pc.open();
        showControl();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
        ),
        margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    width: 1,
                    color: Theme.of(context).canvasColor,
                  )),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "قراءة",
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: 20,
                      fontFamily: 'kufi'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _floatingPanel() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      margin: const EdgeInsets.all(24.0),
      child: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString("assets/json/books/$itemIndex.json"),
          builder: (context, snapshot) {
            var bookView = json.decode(snapshot.data.toString());
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: controller,
                        itemCount: bookView.length,
                        itemBuilder: (BuildContext context, int index) {
                          String text =
                              '${bookView[index]['title']}\n\n${bookView[index]['text']}\n\n${bookView[index]['pageNum']}';
                          return (index % 2 == 0
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).backgroundColor,
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(12),
                                              bottomRight:
                                                  Radius.circular(12))),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 64.0,
                                          right: 16.0,
                                          left: 16.0,
                                          bottom: 32.0,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                                          child: ListView(
                                            children: [
                                              SelectableText(
                                                text,
                                                textDirection: TextDirection.rtl,
                                                style: TextStyle(
                                                  height: 2,
                                                  color: ThemeProvider.themeOf(
                                                      context)
                                                      .id ==
                                                      'dark'
                                                      ? Colors.white
                                                      : Theme.of(context)
                                                      .primaryColorDark,
                                                  fontFamily: 'naskh',
                                                  fontSize: fontSize,
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).backgroundColor,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 64.0,
                                      right: 16.0,
                                      left: 16.0,
                                      bottom: 32.0,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                                      child: ListView(
                                        children: [
                                          SelectableText(
                                            text,
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                              height: 2,
                                              color: ThemeProvider.themeOf(
                                                  context)
                                                  .id ==
                                                  'dark'
                                                  ? Colors.white
                                                  : Theme.of(context)
                                                  .primaryColorDark,
                                              fontFamily: 'naskh',
                                              fontSize: fontSize,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )));
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
