import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants/lists.dart';
import '../models/azkar.dart';
import '../models/azkar_by_category.dart';
import '../models/azkar_list.dart';

class AthkarController extends GetxController {
  ScrollController controller = ScrollController();
  AzkarByCategory azkarByCategory = AzkarByCategory();
  var azkarList = <Azkar>[].obs;
  Random rnd = Random();
  String? element;
  final RxString dailyDua = ''.obs;
  String? lastCategory;

  @override
  void onInit() {
    // اجعل الدعاء اليومي ثابتًا خلال اليوم ومُتغيرًا يوميًا
    refreshDailyDua();
    // للإبقاء على التوافق مع الشاشات القديمة التي تستخدم element
    element = dailyDua.value;
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  /// تحديث الدعاء اليومي بناءً على التاريخ (افتراضي: تاريخ الآن)
  void refreshDailyDua([DateTime? date]) {
    final now = date ?? DateTime.now();
    dailyDua.value = computeDailyDua(now);
    element = dailyDua.value; // توافق للخلف
  }

  /// تبديل الدعاء اليومي عند طلب المستخدم (يعطي نتيجة مختلفة عن الحالية إن أمكن)
  void shuffleDailyDua() {
    final now = DateTime.now();
    // استخرج الفهرس الحالي بناءً على اليوم
    final dayOfYear = _dayOfYear(now);
    final baseIndex = (now.year * 367 + dayOfYear) % athkarList.length;
    // اختر فهرسًا آخر مختلفًا باستخدام مولّد عشوائي بسيط
    int altIndex = baseIndex;
    if (athkarList.length > 1) {
      altIndex = (baseIndex + 1 + rnd.nextInt(athkarList.length - 1)) %
          athkarList.length;
    }
    dailyDua.value = athkarList[altIndex];
    element = dailyDua.value; // توافق للخلف
  }

  /// حساب دعاء اليوم بشكل حتمي لتجنّب العشوائية عند كل فتح
  String computeDailyDua(DateTime date) {
    final dayOfYear = _dayOfYear(date);
    // ندمج السنة لضمان تغيّر الاختيار بين السنوات مع ثباته خلال اليوم
    final seed = date.year * 367 + dayOfYear;
    final index = seed % athkarList.length;
    return athkarList[index];
  }

  int _dayOfYear(DateTime d) {
    final startOfYear = DateTime(d.year, 1, 1);
    return d.difference(startOfYear).inDays + 1; // 1..366
  }

  /// جلب أذكار الفئة وتحديث الحالة دفعة واحدة
  void getAzkarByCategory(String category) {
    lastCategory = category;
    final list = db
        .where((element) => element.containsValue(category))
        .map((e) => Azkar.fromJson(e))
        .toList(growable: false);
    azkarList.assignAll(list);
  }

  /// تحميل الفئة عند الحاجة فقط لتجنّب إعادة البناء المتكرر
  void ensureAzkarCategoryLoaded(String category) {
    if (azkarList.isNotEmpty && lastCategory == category) return;
    getAzkarByCategory(category);
  }
}
