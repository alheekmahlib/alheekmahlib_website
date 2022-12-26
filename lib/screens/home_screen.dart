import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../shared/widgets/settings_popUp.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).backgroundColor,
      child: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: .1,
              child: SvgPicture.asset(
                'assets/svg/alheekmah_logo.svg',
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          const SizedBox(
            width: 100,
            height: 100,
            child: settingsButton(),
          ),
        ],
      ),
    );
  }
}
