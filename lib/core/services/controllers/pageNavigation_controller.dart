import 'package:alheekmahlib_website/core/services/controllers/athkar_controller.dart';
import 'package:alheekmahlib_website/core/services/controllers/general_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../features/athkar_screen/models/all_azkar.dart';
import '../../../features/athkar_screen/screens/alzkar_view.dart';
import '../../../features/athkar_screen/screens/azkar_item.dart';
import '../../../features/books_screen/models/book_model.dart';
import '../../../features/books_screen/screens/books_page.dart';
import '../../../features/books_screen/screens/details.dart';
import '../../../features/home_screen/alheekmah_screen.dart';
import '../../../features/home_screen/home_screen.dart';
import '../../../features/quran_text/screens/surah_text_screen.dart';
import '../../../features/quran_text/screens/text_page_view.dart';
import '../../../services_locator.dart';
import 'books_controller.dart';
import 'quranText_controller.dart';
import 'surahTextController.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class PageNavigationController extends GetxController {
  PageController pageController = PageController();

  final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      /// Application shell
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return const AlheekmahScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return const HomeScreen();
            },
          ),
          GoRoute(
            path: '/quran',
            builder: (BuildContext context, GoRouterState state) {
              return const SurahTextScreen();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'surah/:surahId',
                parentNavigatorKey: rootNavigatorKey,
                builder: (BuildContext context, GoRouterState state) {
                  final surahId = int.parse(state.pathParameters['surahId']!);
                  print('surahId: $surahId');
                  return FutureBuilder<void>(
                      future: sl<SurahTextController>().loadQuranData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox.shrink();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          sl<QuranTextController>().currentSurahIndex = surahId;
                          return TextPageView(
                            surah:
                                sl<SurahTextController>().surahs[surahId - 1],
                            nomPageF: sl<SurahTextController>()
                                .surahs[surahId - 1]
                                .ayahs!
                                .first
                                .page!,
                            nomPageL: sl<SurahTextController>()
                                .surahs[surahId - 1]
                                .ayahs!
                                .last
                                .page!,
                          );
                        }
                      });
                },
              ),
            ],
          ),
          GoRoute(
            path: '/books',
            builder: (BuildContext context, GoRouterState state) {
              return const BooksPage();
            },
            routes: <RouteBase>[
              // The details screen to display stacked on the inner Navigator.
              // This will cover screen A but not the application shell.
              GoRoute(
                path: 'details/:bookId',
                parentNavigatorKey: rootNavigatorKey,
                builder: (BuildContext context, GoRouterState state) {
                  final books = sl<BooksController>();
                  final bookId = state.pathParameters['bookId'];

                  return FutureBuilder<void>(
                    future: books.loadBooksView(bookId!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox.shrink();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        Book? foundBook;

                        for (var type in books.types) {
                          for (var book in type.books) {
                            if (book.id == bookId) {
                              foundBook = book;
                              break;
                            }
                          }
                          if (foundBook != null) {
                            break;
                          }
                        }

                        if (foundBook == null) {
                          return const Text("Book not found");
                        }

                        return DetailsScreen(
                          id: bookId,
                          title: foundBook.title,
                          bookQuoted: foundBook.bookQuoted,
                          aboutBook: foundBook.aboutBook,
                          bookD: foundBook.bookD,
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/athkar',
            builder: (BuildContext context, GoRouterState state) {
              return const AzkarView();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'category/:categoryId',
                parentNavigatorKey: rootNavigatorKey,
                builder: (BuildContext context, GoRouterState state) {
                  final categoryId =
                      int.parse(state.pathParameters['categoryId']!);
                  print('categoryId: $categoryId');
                  return FutureBuilder<void>(
                      future: sl<AthkarController>().getAzkarByCategory(
                          azkarDataList[categoryId - 1].toString().trim()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox.shrink();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return AzkarItem(
                            azkar:
                                azkarDataList[categoryId - 1].toString().trim(),
                          );
                        }
                      });
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );

  int calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    print('Current Location: $location');
    if (location.startsWith('/')) {
      return 0;
    }
    if (location.startsWith('/quran')) {
      return 1;
    }
    if (location.startsWith('/books')) {
      return 2;
    }
    if (location.startsWith('/athkar')) {
      return 3;
    }
    return 0;
  }

  void onItemTapped(int index, BuildContext context) {
    int? pageIndex;
    switch (index) {
      case 0:
        pageIndex = 0;
        GoRouter.of(context).go('/');
        break;
      case 1:
        pageIndex = 1;
        GoRouter.of(context).go('/quran');
        break;
      case 2:
        pageIndex = 2;
        GoRouter.of(context).go('/books');
        break;
      case 3:
        pageIndex = 3;
        GoRouter.of(context).go('/athkar');
        break;
    }
    if (pageIndex != null) {
      pageController.animateToPage(pageIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void itemRouter(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    int? pageIndex;
    switch (location) {
      case '/':
        pageIndex = 0;
        sl<GeneralController>().tapIndex.value = 0;
        break;
      case '/quran':
        pageIndex = 1;
        sl<GeneralController>().tapIndex.value = 1;
        break;
      case '/books':
        pageIndex = 2;
        sl<GeneralController>().tapIndex.value = 2;
        break;
      case '/athkar':
        pageIndex = 3;
        sl<GeneralController>().tapIndex.value = 3;
        break;
    }
    if (pageIndex != null) {
      pageController = PageController(initialPage: pageIndex);
    }
  }
}
