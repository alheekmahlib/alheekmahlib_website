import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_library/quran.dart';

import '/presentation/athkar_screen/controllers/athkar_controller.dart';
import '/presentation/controllers/general_controller.dart';
import '../../../presentation/athkar_screen/models/all_azkar.dart';
import '../../../presentation/athkar_screen/screens/alzkar_view.dart';
import '../../../presentation/athkar_screen/screens/azkar_item.dart';
import '../../../presentation/books/books.dart';
import '../../../presentation/contact_us/screens/contact_us_page.dart';
import '../../../presentation/download_redirect/screens/download_redirect_screen.dart';
import '../../../presentation/home_screen/alheekmah_screen.dart';
import '../../../presentation/home_screen/home_screen.dart';
import '../../../presentation/quran/screens/quran_screen.dart';
import '../../../presentation/quran_sound/screen/quran_sound_screen.dart';
import '../../services/services_locator.dart';
import 'navigation_keys.dart';

export 'navigation_keys.dart';

// المفاتيح مُعلنة الآن في navigation_keys.dart

/// A lightweight navigation manager that owns the app router and page controller.
///
/// Converted from a GetxController to a plain Dart class to reduce coupling and
/// keep responsibilities focused on routing and paging only.
class AppRouter {
  // Centralized route names to avoid magic strings.
  static const String routeHome = '/';
  static const String routeQuran = '/quran';
  static const String routeQuranSound = '/sound';
  static const String routeBooks = '/books';
  static const String routeAthkar = '/athkar';
  static const String routeContactUs = '/contact-us';

  // Keep a single controller instance to avoid losing attachment during rebuilds.
  final PageController pageController = PageController();

  final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      // Download deep-link route (standalone page without shell UI)
      GoRoute(
        path: '/download/:slug',
        parentNavigatorKey: rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          final slug = state.pathParameters['slug'] ?? '';
          return DownloadRedirectScreen(slug: slug);
        },
      ),

      /// Application shell
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          // Note: AlheekmahScreen is used as the shell container. If it needs to
          // render the nested route content, ensure it integrates [child].
          return const AlheekmahScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: routeHome,
            builder: (BuildContext context, GoRouterState state) {
              return const HomeScreen();
            },
          ),
          GoRoute(
            path: routeContactUs,
            builder: (BuildContext context, GoRouterState state) {
              return const ContactUsPage();
            },
          ),
          GoRoute(
            path: routeQuran,
            builder: (BuildContext context, GoRouterState state) {
              return const QuranScreen();
            },
            routes: const <RouteBase>[],
          ),
          GoRoute(
            path: routeQuranSound,
            builder: (BuildContext context, GoRouterState state) {
              return const QuranSoundScreen();
            },
            routes: const <RouteBase>[],
          ),
          GoRoute(
            path: routeBooks,
            builder: (BuildContext context, GoRouterState state) {
              return const BooksScreen();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'details/:id',
                parentNavigatorKey: rootNavigatorKey,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  final raw = state.pathParameters['id'] ?? '';
                  // استخرج أرقام فقط مثل 001 -> 1
                  final digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
                  final number = int.tryParse(digits) ?? 0;

                  // عندما يكون المعرّف غير صالح، أعِد صفحة شاشة الكتب كصفحة انتقال مخصّص
                  if (number <= 0) {
                    return CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const BooksScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    );
                  }

                  // افتح صفحة الفصول/الأجزاء أولًا
                  final ctrl = BooksController.instance;

                  // نُرجع صفحة تحتوي FutureBuilder ضمن child
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                    child: FutureBuilder<void>(
                      future: ctrl.state.booksList.isEmpty
                          ? ctrl.fetchBooks()
                          : Future.value(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox.shrink();
                        }
                        final book = ctrl.state.booksList.firstWhere(
                          (b) => b.bookNumber == number,
                          orElse: () => Book.empty(),
                        );
                        if (book.bookNumber == 0) {
                          return const BooksScreen();
                        }
                        return ChaptersPage(book: book);
                      },
                    ),
                  );
                },
              ),
              GoRoute(
                path: 'read/:id',
                parentNavigatorKey: rootNavigatorKey,
                builder: (BuildContext context, GoRouterState state) {
                  final raw = state.pathParameters['id'] ?? '';
                  final digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
                  final number = int.tryParse(digits) ?? 0;
                  if (number <= 0) {
                    return const BooksScreen();
                  }
                  // Optional page number from query (?page=566)
                  // Treat as 1-based page number and convert to 0-based index for the controller
                  final pageParam = state.uri.queryParameters['page'];
                  final pageNumber = int.tryParse(pageParam ?? '');
                  if (pageNumber != null && pageNumber > 0) {
                    // Store as index; actual clamping to pages length happens on load
                    BooksController.instance.state.currentPageNumber.value =
                        (pageNumber - 1).clamp(0, 1 << 20);
                  }
                  return ReadViewScreen(bookNumber: number);
                },
              ),
            ],
          ),
          GoRoute(
            path: routeAthkar,
            builder: (BuildContext context, GoRouterState state) {
              return const AzkarView();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'category/:categoryId',
                parentNavigatorKey: rootNavigatorKey,
                builder: (BuildContext context, GoRouterState state) {
                  final raw = state.pathParameters['categoryId'];
                  final categoryId = int.tryParse(raw ?? '');
                  log('categoryId: $categoryId');
                  if (categoryId == null || categoryId <= 0) {
                    return const Text('Invalid category id');
                  }
                  final categoryTitle =
                      azkarDataList[categoryId - 1].toString().trim();
                  // تحميل متزامن وخفيف؛ القائمة تُحدّث عبر Obx داخل الشاشة
                  sl<AthkarController>()
                      .ensureAzkarCategoryLoaded(categoryTitle);
                  return AzkarItem(
                    azkar: categoryTitle,
                  );
                },
              ),
            ],
          ),
        ],
      ),
      // (no top-level routes here)
    ],
  );

  int calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    log('Current Location: $location');
    if (location == routeHome) return 0;
    if (location.startsWith(routeQuran)) return 1;
    if (location.startsWith(routeQuranSound)) return 2;
    if (location.startsWith(routeBooks)) return 3;
    if (location.startsWith(routeAthkar)) return 4;
    if (location.startsWith(routeContactUs)) return 5;
    return 0;
  }

  void onItemTapped(int index, BuildContext context) {
    int? pageIndex;
    switch (index) {
      case 0:
        pageIndex = 0;
        GoRouter.of(context).go(routeHome);
        break;
      case 1:
        pageIndex = 1;
        GoRouter.of(context).go(routeQuran);
        break;
      case 2:
        pageIndex = 2;
        GoRouter.of(context).go(routeQuranSound);
        break;
      case 3:
        pageIndex = 3;
        GoRouter.of(context).go(routeBooks);
        break;
      case 4:
        pageIndex = 4;
        GoRouter.of(context).go(routeAthkar);
        break;
      case 5:
        pageIndex = 5;
        GoRouter.of(context).go(routeContactUs);
        break;
    }
    if (pageIndex != null) {
      pageController.animateToPage(pageIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void itemRouter(BuildContext context) {
    // استخدم المسار فقط بدون الاستعلامات للمطابقة، لكن احتفظ بـ uri لقراءة query params
    final uri = GoRouterState.of(context).uri;
    final String path = uri.path; // مثل /quran أو /books
    int? pageIndex;

    if (path == routeHome) {
      pageIndex = 0;
      sl<GeneralController>().tapIndex.value = 0;
    } else if (path.startsWith(routeContactUs)) {
      pageIndex = 5;
      sl<GeneralController>().tapIndex.value = 5;
    } else if (path.startsWith(routeQuran)) {
      pageIndex = 1;
      sl<GeneralController>().tapIndex.value = 1;
      // دعم ?page= للانتقال إلى صفحة معيّنة داخل المصحف عند فتح الرابط مباشرة
      final pageParam = uri.queryParameters['page'];
      final pageNumber = int.tryParse(pageParam ?? '');
      if (pageNumber != null && pageNumber > 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          QuranLibrary().jumpToPage(pageNumber);
        });
      }
    } else if (path.startsWith(routeQuranSound)) {
      pageIndex = 2;
      sl<GeneralController>().tapIndex.value = 2;
    } else if (path.startsWith(routeBooks)) {
      pageIndex = 3;
      sl<GeneralController>().tapIndex.value = 3;
    } else if (path.startsWith(routeAthkar)) {
      pageIndex = 4;
      sl<GeneralController>().tapIndex.value = 4;
    }
    if (pageIndex != null) {
      // Don't recreate controllers in build; just move to the right page.
      if (pageController.hasClients) {
        final current = pageController.page?.round();
        if (current != pageIndex) {
          // Use jumpToPage to avoid animation during initial sync.
          pageController.jumpToPage(pageIndex);
        }
      } else {
        // Attach after first frame when the PageView is built.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (pageController.hasClients) {
            pageController.jumpToPage(pageIndex!);
          }
        });
      }
    }
  }

  /// Dispose the owned [PageController]. Should be called by the owner widget
  /// (e.g., in its dispose()).
  void dispose() {
    try {
      pageController.dispose();
    } catch (_) {}
  }
}
