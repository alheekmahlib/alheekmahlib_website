import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '/features/athkar_screen/screens/alzkar_view.dart';
import '/features/books_screen/screens/books_page.dart';
import '/features/home_screen/home_screen.dart';
import '/features/quran_text/screens/surah_text_screen.dart';
import '../../../features/home_screen/contact_us_page.dart';
import '../../../our_app_info_model.dart';

class GeneralController extends GetxController {
  static GeneralController get instance =>
      GetInstance().putOrFind(() => GeneralController());

  late double screenHeight;
  late double topPadding;
  late double bottomPadding;
  RxInt tapIndex = 0.obs;

  RxBool isExpanded = false.obs;
  RxString greeting = ''.obs;
  RxDouble fontSizeArabic = 18.0.obs;
  RxDouble textWidgetPosition = (-240.0).obs;
  late ItemScrollController itemScrollController;
  SlidingUpPanelController panelTextController = SlidingUpPanelController();
  final selectedBook = ''.obs;
  // Anchor to OurApps section
  final ourAppsKey = GlobalKey(debugLabel: 'our_apps_section');
  void scrollToOurApps() {
    final ctx = ourAppsKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        alignment: 0.1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    }
  }

  RxInt? hoveredIndex;

  // bool get screenWidth => Get.width <= 770;

  // urlRoute(String name) {
  //   final uri = Uri.parse(Get.currentRoute);
  //   int? pageIndex;
  //
  //   switch (uri.path) {
  //     case '/home':
  //       pageIndex = 0;
  //       break;
  //     case '/quran':
  //       pageIndex = 1;
  //       break;
  //     case '/books':
  //       pageIndex = 2;
  //       final bookId = uri.queryParameters['book_id'];
  //       if (bookId != null) {
  //         openBook(bookId);
  //       }
  //       break;
  //     case '/athkar':
  //       pageIndex = 3;
  //       break;
  //     default:
  //       return const Center(child: Text('404 - Not Found'));
  //   }
  //
  //   if (pageIndex != null) {
  //     pageController.animateToPage(pageIndex,
  //         duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  //   }
  // }

  List screensViews = [
    const HomeScreen(),
    const SurahTextScreen(),
    const BooksPage(),
    const AzkarView(),
    const ContactUsPage(),
  ];

  Future<List<OurAppInfo>> fetchApps() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/alheekmahlib/thegarlanded/master/ourApps.json'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((data) => OurAppInfo.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  /// Greeting
  updateGreeting() {
    final now = DateTime.now();
    final isMorning = now.hour < 12;
    greeting.value = isMorning ? 'صبحكم الله بالخير' : 'مساكم الله بالخير';
  }
}
