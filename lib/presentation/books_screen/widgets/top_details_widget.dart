import 'package:alheekmahlib_website/core/utils/constants/extensions/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopDetails extends StatelessWidget {
  final String title;
  final String bookD;
  const TopDetails({super.key, required this.title, required this.bookD});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: 0.1,
                child: SizedBox(
                  width: 260,
                  child: SvgPicture.asset(
                    bookD,
                  ),
                ),
              ),
              SizedBox(
                width: 160,
                child: SvgPicture.asset(
                  bookD,
                ),
              ),
              FittedBox(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: SizedBox(
                    height: 150,
                    width: 120,
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Theme.of(context).canvasColor,
                          fontSize: 24,
                          fontFamily: 'cairo'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                          width: 1,
                          color: context.textDarkColor,
                        )),
                    child: Icon(
                      Icons.arrow_back,
                      size: 20,
                      color: context.textDarkColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )),
    );
  }
}
