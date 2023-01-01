import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../shared/widgets/theme_change.dart';
import '../../shared/widgets/animated_stack.dart';
import '../azkar/screens/alzkar_view.dart';
import '../books/books_page.dart';
import '../cubit/alheekmah_cubit.dart';
import '../quran_text/sorah_text_screen.dart';
import 'about_app.dart';
import 'home_screen.dart';

class AlheekmahScreen extends StatefulWidget {
  AlheekmahScreen({Key? key}) : super(key: key);

  @override
  State<AlheekmahScreen> createState() => _AlheekmahScreenState();
}

class _AlheekmahScreenState extends State<AlheekmahScreen> {
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  final pages = [
    HomeScreen(),
    SorahTextScreen(),
    BooksPage(),
    const AzkarView(),
  ];



  @override
  Widget build(BuildContext context) {
    AlheekmahCubit cubit = AlheekmahCubit.get(context);
    return Scaffold(
      body: Stack(
        children: [
          AnimatedStack(
            buttonIcon: Icons.list,
            openAnimationCurve: Curves.easeIn,
            closeAnimationCurve: Curves.easeOut,
            backgroundColor: Theme.of(context).primaryColorDark,
            fabBackgroundColor: Theme.of(context).bottomAppBarColor,
            foregroundWidget: pages[pageIndex],
            columnWidget: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child:
                      SizedBox(height: 150, width: 50, child: MThemeChange()),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Theme.of(context).bottomAppBarColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: SvgPicture.asset(
                        'assets/svg/quran_ic.svg',
                        color: pageIndex == 0
                            ? null
                            : Theme.of(context).backgroundColor,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        pageIndex = 0;
                        cubit.opened = !cubit.opened;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Theme.of(context).bottomAppBarColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: SvgPicture.asset(
                        'assets/svg/quran_ic.svg',
                        color: pageIndex == 1
                            ? null
                            : Theme.of(context).backgroundColor,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        pageIndex = 1;
                        cubit.opened = !cubit.opened;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9.0),
                  child: GestureDetector(
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Theme.of(context).bottomAppBarColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: SvgPicture.asset(
                        'assets/svg/thegarlanded.svg',
                        color: pageIndex == 2
                            ? null
                            : Theme.of(context).backgroundColor,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        pageIndex = 2;
                        cubit.opened = !cubit.opened;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: Theme.of(context).bottomAppBarColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: SvgPicture.asset(
                        'assets/svg/azkar.svg',
                        color: pageIndex == 3
                            ? null
                            : Theme.of(context).backgroundColor,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        pageIndex = 3;
                        cubit.opened = !cubit.opened;
                      });
                    },
                  ),
                ),
              ],
            ),
            bottomWidget: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/svg/alheekmah_logo.svg',
                  color: Theme.of(context).canvasColor,
                  width: 100,
                ),
                // Divider(
                //   thickness: 2,
                //   endIndent: 500,
                //   color: Theme.of(context).canvasColor,
                // ),
                Container(
                  height: 2,
                  margin: EdgeInsets.only(right: 16, left: MediaQuery.of(context).size.width / 3/4, top: 20),
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).canvasColor,
                ),
                Text(
                  'جميع الحقوق محفوظة لمكتبة الحكمة 1444 هـ',
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: 12,
                      fontFamily: 'kufi'
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
