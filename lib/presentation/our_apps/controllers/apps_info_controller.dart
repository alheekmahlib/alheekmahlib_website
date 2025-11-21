part of '../our_apps.dart';

class AppsInfoController extends GetxController {
  static AppsInfoController get instance =>
      GetInstance().putOrFind(() => AppsInfoController());

  late InfiniteScrollController controller;
  int selectedIndex = 0;

  /// معرف البطاقة الحالية التي عليها مؤشر الفأرة
  final RxnInt hoveredId = RxnInt();

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
      log("No url client found");
    }
  }

  playStore(String url) async {
    // ios specification
    String uri = url;
    if (await canLaunchUrl(Uri.parse(uri))) {
      await launchUrl(Uri.parse(uri));
    } else {
      log("No url client found");
    }
  }

  appGallery(String url) async {
    // ios specification
    String uri = url;
    if (await canLaunchUrl(Uri.parse(uri))) {
      await launchUrl(Uri.parse(uri));
    } else {
      log("No url client found");
    }
  }

  appStoreD(String url) async {
    // ios specification
    String uri = url;
    if (await canLaunchUrl(Uri.parse(uri))) {
      await launchUrl(Uri.parse(uri));
    } else {
      log("No url client found");
    }
  }

  void bannerList(String banner1, String banner2, String banner3,
      String banner4, int initialIndex) {
    // Prepare image providers (kept for future use)
    // ignore: unused_local_variable
    final providers = [
      Image.network(banner1).image,
      Image.network(banner2).image,
      Image.network(banner3).image,
      Image.network(banner4).image,
    ];
    // If needed later, use EasyImageViewer with MultiImageProvider.
  }
}
