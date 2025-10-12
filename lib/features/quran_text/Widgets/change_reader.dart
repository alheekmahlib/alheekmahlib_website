import 'package:alheekmahlib_website/core/utils/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/controllers/audio_controller.dart';
import '../../../core/services/shared_pref_services.dart';
import '../../../core/utils/constants/shared_preferences_constants.dart';
import '../../../services_locator.dart';
import '../../../shared/widgets/widgets.dart';

class ChangeReader extends StatelessWidget {
  const ChangeReader({super.key});

  @override
  Widget build(BuildContext context) {
    List ayahReaderInfo = [
      {
        'name': 'reader1'.tr,
        'readerD': 'Abdul_Basit_Murattal_192kbps',
        'readerI': 'basit'
      },
      {
        'name': 'reader2'.tr,
        'readerD': 'Minshawy_Murattal_128kbps',
        'readerI': 'minshawy'
      },
      {'name': 'reader3'.tr, 'readerD': 'Husary_128kbps', 'readerI': 'husary'},
      // {
      //   'name': 'reader4',
      //   'readerD': 'Ahmed_ibn_Ali_al-Ajamy_64kbps_QuranExplorer.Com',
      //   'readerI': 'ajamy'
      // },
      {
        'name': 'reader5'.tr,
        'readerD': 'MaherAlMuaiqly128kbps',
        'readerI': 'muaiqly'
      },
      {'name': 'reader6'.tr, 'readerD': 'Ghamadi_40kbps', 'readerI': 'Ghamadi'}
    ];
    return GestureDetector(
      child: Container(
        height: 35,
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
                width: 1,
                color: Theme.of(context)
                    .colorScheme
                    .surface
                    .withValues(alpha: .5))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 8,
              child: Obx(
                () => FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    ayahReaderInfo[sl<AudioController>().readerIndex.value]
                        ['name'],
                    style: TextStyle(
                        color: context.textDarkColor,
                        fontSize: 14,
                        fontFamily: "cairo"),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Semantics(
                button: true,
                enabled: true,
                label: 'Change Reader',
                child: Icon(Icons.person_search_outlined,
                    size: 20, color: context.textDarkColor),
              ),
            ),
          ],
        ),
      ),
      onTap: () => dropDownModalBottomSheet(
        context,
        MediaQuery.sizeOf(context).height / 1 / 2,
        screenSize(context, MediaQuery.sizeOf(context).width * .7, 400),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: 30,
                    width: 30,
                    margin: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        border: Border.all(
                            width: 2, color: Theme.of(context).dividerColor)),
                    child: Semantics(
                      button: true,
                      enabled: true,
                      label: 'Close',
                      child: Icon(
                        Icons.close_outlined,
                        color: context.textDarkColor,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text(
                    'select_player'.tr,
                    style: TextStyle(
                        color: Theme.of(context).dividerColor,
                        fontSize: 18,
                        fontFamily: "cairo"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: ListView.builder(
                  itemCount: ayahReaderInfo.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              border: Border.all(
                                  color: Theme.of(context).dividerColor,
                                  width: 1)),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4.0),
                          child: ListTile(
                            title: Text(
                              ayahReaderInfo[index]['name'],
                              style: TextStyle(
                                  color: sl<AudioController>().readerValue ==
                                          ayahReaderInfo[index]['readerD']
                                      ? context.textDarkColor
                                      : const Color(0xffcdba72),
                                  fontSize: 14,
                                  fontFamily: "cairo"),
                            ),
                            trailing: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(2.0)),
                                border: Border.all(
                                    color: sl<AudioController>().readerValue ==
                                            ayahReaderInfo[index]['readerD']
                                        ? const Color(0xffcdba72)
                                        : Theme.of(context).primaryColorLight,
                                    width: 2),
                                color: const Color(0xff39412a),
                              ),
                              child: sl<AudioController>().readerValue ==
                                      ayahReaderInfo[index]['readerD']
                                  ? const Icon(Icons.done,
                                      size: 14, color: Color(0xffcdba72))
                                  : null,
                            ),
                            onTap: () async {
                              sl<AudioController>().readerName.value =
                                  ayahReaderInfo[index]['name'];
                              sl<AudioController>().readerValue =
                                  ayahReaderInfo[index]['readerD'];
                              sl<AudioController>().readerIndex.value = index;
                              await sl<SharedPrefServices>().saveString(
                                  AUDIO_PLAYER_SOUND,
                                  ayahReaderInfo[index]['readerD']);
                              await sl<SharedPrefServices>().saveString(
                                  READER_NAME, ayahReaderInfo[index]['name']);
                              await sl<SharedPrefServices>()
                                  .saveInteger(READER_INDEX, index);
                              Navigator.pop(context);
                            },
                            leading: Container(
                              height: 80.0,
                              width: 80.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/${ayahReaderInfo[index]['readerI']}.jpg'),
                                    fit: BoxFit.fitWidth,
                                    opacity:
                                        sl<AudioController>().readerValue ==
                                                ayahReaderInfo[index]['readerD']
                                            ? 1
                                            : .4,
                                  ),
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0)),
                                  border: Border.all(
                                      color: Theme.of(context).dividerColor,
                                      width: 2)),
                            ),
                          ),
                        ),
                        // const Divider(
                        //   endIndent: 16,
                        //   indent: 16,
                        //   height: 3,
                        // ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
