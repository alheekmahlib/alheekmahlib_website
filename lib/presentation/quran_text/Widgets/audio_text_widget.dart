import 'package:alheekmahlib_website/core/utils/constants/extensions.dart';
import 'package:flutter/material.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/constants/svg_picture.dart';
import '../../../core/widgets/widgets.dart';
import '../../controllers/general_controller.dart';
import '../controllers/audio_controller.dart';
import 'change_reader.dart';
import 'seek_bar.dart';
import 'widgets.dart';

class AudioTextWidget extends StatelessWidget {
  const AudioTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return audioContainer(
      context,
      Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: decorations(context),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: RotatedBox(
              quarterTurns: 2,
              child: decorations(context),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 90.0),
              child: customClose2(context,
                  close: () => sl<GeneralController>()
                      .textWidgetPosition
                      .value = -240.0),
            ),
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: ChangeReader(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              sl<AudioController>().isPlay.value
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 24,
                            ),
                            color: context.textDarkColor,
                            onPressed: () {
                              sl<AudioController>().selected.value = true;

                              sl<AudioController>().textPlayAyah(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 250,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withValues(alpha: .4),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: StreamBuilder<PositionData>(
                            stream:
                                sl<AudioController>().textPositionDataStream,
                            builder: (context, snapshot) {
                              final positionData = snapshot.data;
                              return SeekBar(
                                timeShow: true,
                                textColor: context.textDarkColor,
                                duration:
                                    positionData?.duration ?? Duration.zero,
                                position:
                                    positionData?.position ?? Duration.zero,
                                bufferedPosition:
                                    positionData?.bufferedPosition ??
                                        Duration.zero,
                                activeTrackColor:
                                    Theme.of(context).colorScheme.surface,
                                onChangeEnd:
                                    sl<AudioController>().textAudioPlayer.seek,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
