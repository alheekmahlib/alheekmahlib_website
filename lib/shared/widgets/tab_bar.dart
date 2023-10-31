import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '/core/utils/constants/extensions.dart';
import '/shared/widgets/widgets.dart';
import '../../core/services/controllers/general_controller.dart';
import '../../core/services/controllers/pageNavigation_controller.dart';
import '../../services_locator.dart';

class TabBarUI extends StatelessWidget {
  const TabBarUI({super.key});

  @override
  Widget build(BuildContext context) {
    List tapViews = [
      'home'.tr,
      'quran'.tr,
      'books'.tr,
      'azkar'.tr,
    ];
    final general = sl<GeneralController>();
    final navigation = sl<PageNavigationController>();
    general.itemScrollController = ItemScrollController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: beigeContainer(
        context,
        height: screenSize(context, 205.0, 40.0),
        width: screenSize(context, 250.0, 600.0),
        whiteContainer(
          context,
          general.screenWidth <= 770
              ? SizedBox(
                  height: 200,
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: List.generate(
                          tapViews.length,
                          (index) => Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                  color: general.tapIndex.value == index
                                      ? context.iconsDarkColor
                                      : Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                              child: ListTile(
                                title: Text(
                                  tapViews[index],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'kufi',
                                      color: index == general.tapIndex.value
                                          ? Theme.of(context).primaryColorDark
                                          : context.textDarkColor),
                                ),
                                onTap: () {
                                  general.tapIndex.value = index;
                                  navigation.calculateSelectedIndex(context);
                                  navigation.onItemTapped(index, context);
                                  general.key.currentState!.openOrClose();
                                },
                              ),
                            ),
                          ),
                        ),
                      )),
                )
              : Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        tapViews.length,
                        (index) => Container(
                          height: 40,
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          child: Obx(
                            () => ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: general.tapIndex.value == index
                                    ? MaterialStateProperty.all(
                                        context.iconsDarkColor)
                                    : MaterialStateProperty.all(
                                        Colors.transparent),
                              ),
                              onPressed: () {
                                general.tapIndex.value = index;
                                navigation.calculateSelectedIndex(context);
                                navigation.onItemTapped(index, context);
                                general.key.currentState!.openOrClose();
                              },
                              child: Text(
                                tapViews[index],
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'kufi',
                                    color: index == general.tapIndex.value
                                        ? Theme.of(context).primaryColorDark
                                        : context.textDarkColor),
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
        ),
      ),
    );
  }
}
