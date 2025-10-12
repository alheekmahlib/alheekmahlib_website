import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AyatController extends GetxController {
  String? tableName;
  late int radioValue;
  RxInt numberOfAyahText = 1.obs;
  RxString ayahTextNumber = '1'.obs;
  RxString surahTextNumber = '1'.obs;
  RxInt ayahSelected = (-1).obs;
  RxInt ayahNumber = (-1).obs;
  RxInt surahNumber = 1.obs;
  String tafseerAyah = '';
  String tafseerText = '';
  int? translateIndex;
  RxString currentAyahNumber = '1'.obs;
  var isSelected = (-1.0).obs;
  var currentPageLoading = RxBool(false);
  var currentPageError = RxString('');
  ValueNotifier<int> selectedTafseerIndex = ValueNotifier<int>(0);
}
