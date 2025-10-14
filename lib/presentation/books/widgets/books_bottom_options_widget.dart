part of '../books.dart';

class BooksBottomOptionsWidget extends StatelessWidget {
  final int bookNumber;
  final int index;
  final booksCtrl = BooksController.instance;

  BooksBottomOptionsWidget({
    super.key,
    required this.bookNumber,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: .7),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _isTashkilBuild(context),
          ChangeThemeWidget(),
          const FontSizeDropDown(position: PopupMenuPosition.over),
        ],
      ),
    );
  }

  Widget _isTashkilBuild(BuildContext context) {
    return GetX<BooksController>(
      builder: (booksCtrl) => CustomButton(
        width: 40,
        isCustomSvgColor: true,
        svgPath: SvgPath.svgTashkil,
        verticalPadding: 6.0,
        svgColor: booksCtrl.state.isTashkil.value
            ? context.theme.colorScheme.secondary
            : context.theme.colorScheme.secondary.withValues(alpha: .2),
        backgroundColor: Colors.transparent,
        borderColor: context.theme.colorScheme.secondary.withValues(alpha: .2),
        onPressed: () => booksCtrl.isTashkilOnTap(),
      ),
    );
  }

  // Widget _changeBackgroundColor(BuildContext context) {
  //   return Obx(
  //     () => CustomButton(
  //       onPressed: () => showDialog<String>(
  //           context: context,
  //           builder: (BuildContext context) => Dialog(
  //                 alignment: Alignment.center,
  //                 backgroundColor: context.theme.colorScheme.primaryContainer,
  //                 surfaceTintColor: context.theme.colorScheme.primary,
  //                 child: SizedBox(
  //                   height: 240,
  //                   width: 240,
  //                   child: Padding(
  //                     padding: const EdgeInsets.symmetric(
  //                         vertical: 8.0, horizontal: 16.0),
  //                     child: Column(
  //                       children: [
  //                         ColorPicker(
  //                           wheelHasBorder: true,
  //                           wheelDiameter: 300,
  //                           hasBorder: true,
  //                           color: Color(
  //                               booksCtrl.state.backgroundPickerColor.value),
  //                           borderColor: context.theme.colorScheme.surface,
  //                           onColorChanged: (Color color) => booksCtrl.state
  //                               .temporaryBackgroundColor.value = color.value,
  //                           pickersEnabled: const {
  //                             ColorPickerType.wheel: false,
  //                             ColorPickerType.both: false,
  //                             ColorPickerType.primary: false,
  //                             ColorPickerType.accent: false,
  //                             ColorPickerType.custom: true,
  //                           },
  //                           customColorSwatchesAndNames: {
  //                             const MaterialColor(0xffFFFBF8, <int, Color>{
  //                               50: Color(0xffffffff),
  //                               100: Color(0xfffffbfb),
  //                               200: Color(0xffFFFBF8),
  //                               300: Color(0xfffff9f5),
  //                               400: Color(0xfffff7f1),
  //                               500: Color(0xfffff6e2),
  //                               600: Color(0xffefe3d1),
  //                               700: Color(0xffdacdba),
  //                               800: Color(0xffc8bba6),
  //                               900: Color(0xffe3d0ac),
  //                             }): 'Brown',
  //                           },
  //                         ),
  //                         Row(
  //                           children: [
  //                             Expanded(
  //                               flex: 4,
  //                               child: GestureDetector(
  //                                 onTap: () {
  //                                   final ctx = rootNavigatorKey.currentContext;
  //                                   if (ctx != null) {
  //                                     booksCtrl.state.backgroundPickerColor
  //                                         .value = 0xfffaf7f3;
  //                                     booksCtrl.state.box.remove(
  //                                         BACKGROUND_PICKER_COLOR_FOR_BOOK);
  //                                     booksCtrl.update();
  //                                     ctx.pop();
  //                                   }
  //                                 },
  //                                 child: Container(
  //                                   height: 30,
  //                                   alignment: Alignment.center,
  //                                   padding: const EdgeInsets.symmetric(
  //                                       horizontal: 16.0, vertical: 4.0),
  //                                   decoration: BoxDecoration(
  //                                       color: context.theme.colorScheme.primary
  //                                           .withValues(alpha: .1),
  //                                       borderRadius: const BorderRadius.all(
  //                                           Radius.circular(8)),
  //                                       border: Border.all(
  //                                         width: 1,
  //                                         color:
  //                                             context.theme.colorScheme.surface,
  //                                       )),
  //                                   child: FittedBox(
  //                                     fit: BoxFit.scaleDown,
  //                                     child: Text(
  //                                       'reset'.tr,
  //                                       style: TextStyle(
  //                                         color: context
  //                                             .theme.colorScheme.inversePrimary,
  //                                         fontFamily: 'cairo',
  //                                         fontSize: 14,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                             const Spacer(),
  //                             Expanded(
  //                               flex: 3,
  //                               child: GestureDetector(
  //                                 onTap: () {
  //                                   final ctx = rootNavigatorKey.currentContext;
  //                                   if (ctx != null) {
  //                                     ctx.pop();
  //                                   }
  //                                 },
  //                                 child: Container(
  //                                   height: 30,
  //                                   alignment: Alignment.center,
  //                                   padding: const EdgeInsets.symmetric(
  //                                       horizontal: 16.0, vertical: 4.0),
  //                                   decoration: BoxDecoration(
  //                                       color: context.theme.colorScheme.primary
  //                                           .withValues(alpha: .1),
  //                                       borderRadius: const BorderRadius.all(
  //                                           Radius.circular(8)),
  //                                       border: Border.all(
  //                                         width: 1,
  //                                         color:
  //                                             context.theme.colorScheme.surface,
  //                                       )),
  //                                   child: FittedBox(
  //                                     fit: BoxFit.scaleDown,
  //                                     child: Text(
  //                                       'cancel'.tr,
  //                                       style: TextStyle(
  //                                         color: context
  //                                             .theme.colorScheme.inversePrimary,
  //                                         fontFamily: 'cairo',
  //                                         fontSize: 14,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                             const Gap(8),
  //                             Expanded(
  //                               flex: 3,
  //                               child: GestureDetector(
  //                                 onTap: () {
  //                                   final ctx = rootNavigatorKey.currentContext;
  //                                   if (ctx != null) {
  //                                     booksCtrl.state.backgroundPickerColor
  //                                             .value =
  //                                         booksCtrl.state
  //                                             .temporaryBackgroundColor.value;
  //                                     booksCtrl.state.box.write(
  //                                         BACKGROUND_PICKER_COLOR_FOR_BOOK,
  //                                         booksCtrl.state.backgroundPickerColor
  //                                             .value);
  //                                     booksCtrl.update();
  //                                     ctx.pop();
  //                                   }
  //                                 },
  //                                 child: Container(
  //                                   height: 30,
  //                                   alignment: Alignment.center,
  //                                   padding: const EdgeInsets.symmetric(
  //                                       horizontal: 16.0, vertical: 4.0),
  //                                   decoration: BoxDecoration(
  //                                       color: context.theme.colorScheme.primary
  //                                           .withValues(alpha: .1),
  //                                       borderRadius: const BorderRadius.all(
  //                                           Radius.circular(8)),
  //                                       border: Border.all(
  //                                         width: 1,
  //                                         color:
  //                                             context.theme.colorScheme.surface,
  //                                       )),
  //                                   child: FittedBox(
  //                                     fit: BoxFit.scaleDown,
  //                                     child: Text(
  //                                       'ok'.tr,
  //                                       style: TextStyle(
  //                                         color: context
  //                                             .theme.colorScheme.inversePrimary,
  //                                         fontFamily: 'cairo',
  //                                         fontSize: 14,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               )),
  //       width: 40,
  //       isCustomSvgColor: true,
  //       verticalPadding: 6.0,
  //       svgPath: SvgPath.svgBackgroundIcon,
  //       svgColor: Color(booksCtrl.state.backgroundPickerColor.value),
  //       backgroundColor: Colors.transparent,
  //       borderColor: context.theme.colorScheme.secondary.withValues(alpha: .2),
  //     ),
  //   );
  // }
}
