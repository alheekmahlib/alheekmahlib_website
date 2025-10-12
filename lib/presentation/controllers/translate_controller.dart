import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/services_locator.dart';
import '../../core/services/shared_pref_services.dart';
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
        await sl<SharedPrefServices>().saveString(TRANS, 'en');
      case 1:
        trans.value = 'es';
        await sl<SharedPrefServices>().saveString(TRANS, 'es');
      case 2:
        trans.value = 'be';
        await sl<SharedPrefServices>().saveString(TRANS, 'be');
      case 3:
        trans.value = 'urdu';
        await sl<SharedPrefServices>().saveString(TRANS, 'urdu');
      case 4:
        trans.value = 'so';
        await sl<SharedPrefServices>().saveString(TRANS, 'so');
      case 5:
        trans.value = 'in';
        await sl<SharedPrefServices>().saveString(TRANS, 'in');
      case 6:
        trans.value = 'ku';
        await sl<SharedPrefServices>().saveString(TRANS, 'ku');
      case 7:
        trans.value = 'tr';
        await sl<SharedPrefServices>().saveString(TRANS, 'tr');
      default:
        trans.value = 'en';
    }
  }

  Future<void> loadTranslateValue() async {
    transValue.value = await sl<SharedPrefServices>()
        .getInteger(TRANSLATE_VALUE, defaultValue: 0);
    // String? tValue = await sl<SharedPrefServices>().getString(TRANS);
    // if (tValue == null) {
    //   trans.value = tValue;
    // } else {
    //   trans.value = 'en'; // Setting to a valid default value
    // }
    trans.value =
        await sl<SharedPrefServices>().getString(TRANS, defaultValue: 'en');
  }
}
