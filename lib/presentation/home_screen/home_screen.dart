import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/services/services_locator.dart';
import '../contact_us/screens/about_us_section.dart';
import '../controllers/general_controller.dart';
import '../our_apps/our_apps.dart';
import 'widgets/faq_section.dart';
import 'widgets/hero_header.dart';
import 'widgets/services_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: height,
        width: width,
        color: Theme.of(context).colorScheme.surface,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 48.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: HeroHeader(),
                ),
                const Gap(32),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: ServicesSection(),
                ),
                const Gap(32),
                KeyedSubtree(
                    key: sl<GeneralController>().ourAppsKey,
                    child: const OurApps()),
                const Gap(32),
                const AboutUsSection(),
                const Gap(32),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: FaqSection(),
                ),
                const Gap(32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
