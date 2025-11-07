import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../core/utils/constants/shared_preferences_constants.dart';
import '../athkar_screen/screens/alzkar_view.dart';
import '../books/books.dart';
import '../contact_us/screens/contact_us_page.dart';
import '../home_screen/home_screen.dart';
import '../our_apps/data/model/our_app_info_model.dart';
import '../quran/screens/quran_screen.dart';
import '../quran_sound/screen/quran_sound_screen.dart';

class GeneralController extends GetxController {
  static GeneralController get instance =>
      GetInstance().putOrFind(() => GeneralController());
  final _box = GetStorage();

  late double screenHeight;
  late double topPadding;
  late double bottomPadding;
  RxInt tapIndex = 0.obs;

  RxBool isExpanded = false.obs;
  RxString greeting = ''.obs;
  RxDouble fontSizeArabic = 24.0.obs;
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

  @override
  void onInit() {
    super.onInit();
    // تحميل حجم الخط من التخزين وتقييده بين 20 و50
    try {
      final dynamic stored = _box.read(FONT_SIZE);
      double fs;
      if (stored is int) {
        fs = stored.toDouble();
      } else if (stored is double) {
        fs = stored;
      } else {
        fs = fontSizeArabic.value;
      }
      fs = fs.clamp(20.0, 50.0);
      fontSizeArabic.value = fs;
    } catch (_) {}
  }

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

  // ترتيب الصفحات يجب أن يطابق ترتيب التبويبات والمسارات:
  // 0: Home (/)
  // 1: Quran (/quran)
  // 2: Quran Sound (/sound)
  // 3: Books (/books)
  // 4: Athkar (/athkar)
  // 5: Contact Us (/contact-us)
  List screensViews = const [
    HomeScreen(),
    QuranScreen(),
    QuranSoundScreen(),
    BooksScreen(),
    AzkarView(),
    ContactUsPage(),
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
}
