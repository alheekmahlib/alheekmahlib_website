import 'package:flutter/material.dart';

import '/features/home_screen/widgets/about_lib.dart';
import '/features/home_screen/widgets/our_apps.dart';
import 'widgets/dwaa_daily.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: height,
        width: width,
        color: Theme.of(context).colorScheme.background,
        child: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 64.0, bottom: 32.0),
            child: Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    SizedBox(width: 350, child: AboutLib()),
                    SizedBox(width: 350, child: DwaaDaily()),
                  ],
                ),
                OurApps(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
