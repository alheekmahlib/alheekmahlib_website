import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:url_launcher/url_launcher.dart';

class AppsInfoController extends GetxController {
  late InfiniteScrollController controller;
  int selectedIndex = 0;

  @override
  void onInit() {
    controller = InfiniteScrollController(initialItem: selectedIndex);
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  appStoreI(String url) async {
    // ios specification
    String uri = url;
    if (await canLaunchUrl(Uri.parse(uri))) {
      await launchUrl(Uri.parse(uri));
    } else {
      print("No url client found");
    }
  }

  playStore(String url) async {
    // ios specification
    String uri = url;
    if (await canLaunchUrl(Uri.parse(uri))) {
      await launchUrl(Uri.parse(uri));
    } else {
      print("No url client found");
    }
  }

  appGallery(String url) async {
    // ios specification
    String uri = url;
    if (await canLaunchUrl(Uri.parse(uri))) {
      await launchUrl(Uri.parse(uri));
    } else {
      print("No url client found");
    }
  }

  appStoreD(String url) async {
    // ios specification
    String uri = url;
    if (await canLaunchUrl(Uri.parse(uri))) {
      await launchUrl(Uri.parse(uri));
    } else {
      print("No url client found");
    }
  }

  void bannerList(String banner1, String banner2, String banner3,
      String banner4, int initialIndex) {
    MultiImageProvider multiImageProvider =
        MultiImageProvider(initialIndex: initialIndex, [
      Image.network(banner1).image,
      Image.network(banner2).image,
      Image.network(banner3).image,
      Image.network(banner4).image
    ]);
    List<String> quranScreen = [
      banner1,
      banner2,
      banner3,
      banner4,
    ];
  }
}
