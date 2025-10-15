import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_utils/get_utils.dart';

class ContainerWithTitleWidget extends StatelessWidget {
  final String title;
  final double? height;
  final Widget child;
  final double? gap;
  final BorderRadiusGeometry? borderRadius;
  final Color? containerColor;
  const ContainerWithTitleWidget(
      {super.key,
      required this.title,
      this.height,
      required this.child,
      this.gap,
      this.borderRadius,
      this.containerColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: height ?? 180,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: containerColor ??
                      context.theme.colorScheme.surface.withValues(alpha: .5),
                  borderRadius: borderRadius ??
                      const BorderRadius.all(Radius.circular(8)),
                ),
                child: RotatedBox(
                  quarterTurns: 3,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: Text(
                      title.tr,
                      style: TextStyle(
                          color: context.theme.colorScheme.secondary,
                          fontFamily: 'cairo',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
              MaxGap(gap ?? 32),
            ]),
        child,
      ],
    );
  }
}
