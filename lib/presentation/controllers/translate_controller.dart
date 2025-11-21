import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/utils/constants/shared_preferences_constants.dart';

class TranslateDataController extends GetxController {
  var data = [].obs;
  var isLoading = false.obs;
  var trans = 'en'.obs;
  RxInt transValue = 1.obs;

  Future<void> fetchSura(BuildContext context) async {
    isLoading.value = true; // Set isLoading to true
    String loadedData = await DefaultAssetBundle.of(context)
        .loadString("assets/json/translate/${trans.value}.json");
    Map<String, dynamic> showData = json.decode(loadedData);
    // List<dynamic> sura = showData[surahNumber];
    data.value = showData['translations'];
    isLoading.value = false; // Set isLoading to false and update the data
  }

  translateHandleRadioValueChanged(int translateVal) async {
    transValue.value = translateVal;
    switch (transValue.value) {
      case 0:
        trans.value = 'en';
        GetStorage().write(TRANS, 'en');
      case 1:
        trans.value = 'es';
        GetStorage().write(TRANS, 'es');
      case 2:
        trans.value = 'be';
        GetStorage().write(TRANS, 'be');
      case 3:
        trans.value = 'urdu';
        GetStorage().write(TRANS, 'urdu');
      case 4:
        trans.value = 'so';
        GetStorage().write(TRANS, 'so');
      case 5:
        trans.value = 'in';
        GetStorage().write(TRANS, 'in');
      case 6:
        trans.value = 'ku';
        GetStorage().write(TRANS, 'ku');
      case 7:
        trans.value = 'tr';
        GetStorage().write(TRANS, 'tr');
      default:
        trans.value = 'en';
    }
  }

  Future<void> loadTranslateValue() async {
    transValue.value = GetStorage().read(TRANSLATE_VALUE) ?? 0;
    // String? tValue = GetStorage().read(TRANS);
    // if (tValue == null) {
    //   trans.value = tValue;
    // } else {
    //   trans.value = 'en'; // Setting to a valid default value
    // }
    trans.value = GetStorage().read(TRANS) ?? 'en';
  }
}
