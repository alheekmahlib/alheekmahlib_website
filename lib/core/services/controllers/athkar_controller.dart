import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/athkar_screen/models/azkar.dart';
import '../../../features/athkar_screen/models/azkar_by_category.dart';
import '../../../features/athkar_screen/models/azkar_list.dart';
import '../../utils/constants/lists.dart';

class AthkarController extends GetxController {
  ScrollController controller = ScrollController();
  AzkarByCategory azkarByCategory = AzkarByCategory();
  var azkarList = <Azkar>[].obs;
  Random rnd = Random();
  String? element;

  @override
  void onInit() {
    element = athkar_list[rnd.nextInt(athkar_list.length)];
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  getAzkarByCategory(String category) {
    azkarList.clear();
    db.where((element) => element.containsValue(category)).forEach((element) {
      azkarList.add(Azkar.fromJson(element));
    });
  }
}
