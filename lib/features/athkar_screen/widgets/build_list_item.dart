import 'package:alheekmahlib_website/core/utils/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';

import '../../../core/services/controllers/athkar_controller.dart';
import '../../../services_locator.dart';
import '../models/all_azkar.dart';

class BuildListItem extends StatelessWidget {
  const BuildListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimationLimiter(
          child: ListView.builder(
            controller: sl<AthkarController>().controller,
            itemCount: azkarDataList.length,
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 450),
                  child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                          child: Container(
                        height: 70,
                        margin: const EdgeInsets.only(top: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: index == 0
                                ? const Radius.circular(20.0)
                                : const Radius.circular(5.0),
                            topRight: index == 0
                                ? const Radius.circular(20.0)
                                : const Radius.circular(5.0),
                            bottomLeft: index == azkarDataList.length - 1
                                ? const Radius.circular(20.0)
                                : const Radius.circular(5.0),
                            bottomRight: index == azkarDataList.length - 1
                                ? const Radius.circular(20.0)
                                : const Radius.circular(5.0),
                          ),
                          color: (index % 2 == 0
                              ? Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withOpacity(.2)
                              : Theme.of(context).colorScheme.background),
                        ),
                        child: InkWell(
                          onTap: () {
                            context.go('/athkar/category/${index + 1}');
                            // Navigator.of(context).push(animatRoute(
                            //   AzkarItem(
                            //     azkar: azkarDataList[index].toString().trim(),
                            //   ),
                            // ));
                          },
                          child: Row(
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: TextRenderer(
                                    child: Text(
                                      azkarDataList[index].toString(),
                                      style: TextStyle(
                                        color: context.textDarkColor,
                                        fontSize: 20,
                                        fontFamily: 'kufi',
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))));
            },
          ),
        ),
      ],
    );
  }
}
