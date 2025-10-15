import 'package:alheekmahlib_website/core/utils/constants/extensions/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';

import '../../../core/services/services_locator.dart';
import '../controllers/athkar_controller.dart';
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
                        margin: const EdgeInsets.only(top: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: index == 0
                                ? const Radius.circular(20.0)
                                : const Radius.circular(8.0),
                            topRight: index == 0
                                ? const Radius.circular(20.0)
                                : const Radius.circular(8.0),
                            bottomLeft: index == azkarDataList.length - 1
                                ? const Radius.circular(20.0)
                                : const Radius.circular(8.0),
                            bottomRight: index == azkarDataList.length - 1
                                ? const Radius.circular(20.0)
                                : const Radius.circular(8.0),
                          ),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            context.go('/athkar/category/${index + 1}');
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  child: TextRenderer(
                                    child: Text(
                                      azkarDataList[index].toString(),
                                      style: TextStyle(
                                        color: context.textDarkColor,
                                        fontSize: 18,
                                        fontFamily: 'cairo',
                                        height: 1.3,
                                      ),
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 12.0),
                                child: Icon(
                                  Icons.chevron_left,
                                  color: context.textDarkColor
                                      .withValues(alpha: .8),
                                  size: 24,
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
