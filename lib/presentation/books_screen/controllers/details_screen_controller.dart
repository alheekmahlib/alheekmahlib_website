import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DetailsScreenController extends GetxController {
  PageController? controller;
  final PanelController pc = PanelController();
  String text = '';
  RxBool isShowControl = true.obs;
  double lowerValue = 18;
  double upperValue = 40;
  RxDouble fontSize = 18.0.obs;

  showControl() {
    isShowControl.value = !isShowControl.value;
  }

  @override
  void onInit() {
    controller = PageController(
      viewportFraction: .7,
      initialPage: 0,
    );
    isShowControl.value = false;
    super.onInit();
  }

  @override
  void onClose() {
    controller!.dispose();
    super.onClose();
  }
}
