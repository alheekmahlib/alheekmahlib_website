import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as R;

import '../../../features/quran_text/Widgets/seek_bar.dart';
import '../../../services_locator.dart';
import '../../utils/constants/shared_preferences_constants.dart';
import '../shared_pref_services.dart';
import 'ayat_controller.dart';
import 'quranText_controller.dart';

class AudioController extends GetxController {
  AudioPlayer audioPlayer = AudioPlayer();
  // AudioPlayer pageAudioPlayer = AudioPlayer();
  AudioPlayer textAudioPlayer = AudioPlayer();
  RxBool isPlay = false.obs;
  RxBool downloading = false.obs;
  RxString progressString = "0".obs;
  RxBool isPagePlay = false.obs;
  RxDouble progress = 0.0.obs;
  RxBool downloadingPage = false.obs;
  RxString progressPageString = "0".obs;
  RxDouble progressPage = 0.0.obs;
  RxInt ayahSelected = (-1).obs;
  String? currentPlay;
  RxBool autoPlay = false.obs;
  double? sliderValue;
  String? readerValue;
  RxString readerName = 'عبد الباسط عبد الصمد'.obs;
  String? pageAyahNumber;
  // String? pageSurahNumber;

  RxBool isProcessingNextAyah = false.obs;
  Duration? lastPosition;
  Duration? pageLastPosition;
  RxInt pageNumber = 0.obs;
  RxInt lastAyahInPage = 0.obs;
  RxInt lastAyahInTextPage = 0.obs;
  RxInt lastAyahInSurah = 0.obs;
  Color? backColor;
  RxInt currentAyahInPage = 1.obs;
  int? currentSorahInPage;
  int? currentAyah;
  int? currentSorah;
  bool goingToNewSurah = false;
  RxBool selected = false.obs;
  RxInt readerIndex = 1.obs;

  @override
  void onInit() {
    isPlay.value = false;
    sliderValue = 0;
    loadQuranReader();
    super.onInit();
  }

  Stream<PositionData> get textPositionDataStream =>
      R.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          textAudioPlayer.positionStream,
          textAudioPlayer.bufferedPositionStream,
          textAudioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  String formatNumber(int number) {
    if (number < 10) {
      return '00$number';
    } else if (number < 100) {
      return '0$number';
    } else {
      return '$number';
    }
  }

  textPlayAyah(BuildContext context) async {
    currentAyah = int.parse(sl<AyatController>().ayahTextNumber.value);
    currentSorah = int.parse(sl<AyatController>().surahTextNumber.value);
    sl<AyatController>().surahTextNumber.value = formatNumber(currentSorah!);
    sl<AyatController>().ayahTextNumber.value = formatNumber(currentAyah!);

    String reader = readerValue!;
    String fileName =
        "$reader/${sl<AyatController>().surahTextNumber.value}${sl<AyatController>().ayahTextNumber.value}.mp3";
    String url = "https://www.everyayah.com/data/$fileName";

    if (isPlay.value) {
      await textAudioPlayer.pause();
      isPlay.value = false;
      print('audioPlayer: pause');
    } else {
      await textAudioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url)));
      textAudioPlayer.playerStateStream.listen((playerState) async {
        if (playerState.processingState == ProcessingState.completed &&
            !isProcessingNextAyah.value) {
          // isProcessingNextAyah.value = true;

          isPlay.value = false;
          await textAudioPlayer.pause();
          isPlay.value = false;
        }
      });
      isPlay.value = true;
      await textAudioPlayer.play();
    }
  }

  void textPlayNextAyah(BuildContext context) async {
    print('playNextAyah ' * 6);
    ayahSelected.value;
    ayahSelected.value = ayahSelected.value + 1;

    currentAyah = int.parse(sl<AyatController>().ayahTextNumber.value) + 1;
    currentSorah = int.parse(sl<AyatController>().surahTextNumber.value);
    sl<AyatController>().surahTextNumber.value = formatNumber(currentSorah!);
    sl<AyatController>().ayahTextNumber.value = formatNumber(currentAyah!);

    String reader = readerValue!;
    String fileName =
        "$reader/${sl<AyatController>().surahTextNumber.value}${sl<AyatController>().ayahTextNumber.value}.mp3";
    String url = "https://www.everyayah.com/data/$fileName";
    print('nextURL $url');

    print('currentAyah $currentAyah');

    sl<QuranTextController>().itemScrollController.scrollTo(
        index: (currentAyah! - 1),
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut);
    // await textPlayFile(context, url, fileName);
    // if (currentAyah == lastAyahInPage.value) {
    //   audioController.ayahSelected.value = currentAyah!;
    //   print('ayahSelected.value: ${audioController.ayahSelected.value}');
    //   sl<QuranTextController>().itemScrollController.scrollTo(
    //       index: pageNumber.value + 1,
    //       duration: const Duration(seconds: 1),
    //       curve: Curves.easeOut);
    //   await textPlayFile(context, url, fileName);
    // } else {
    //   audioController.ayahSelected.value = currentAyah!;
    //   print('ayahSelected.value: ${audioController.ayahSelected.value}');
    //   await textPlayFile(context, url, fileName);
    // }

    isProcessingNextAyah.value = false;
  }

  int? lastAyah(int pageNamber, var widget) {
    return lastAyahInTextPage.value =
        widget.surah.ayahs![pageNamber].numberInSurah!;
  }

  @override
  void onClose() {
    audioPlayer.pause();
    audioPlayer.dispose();
    super.onClose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      audioPlayer.stop();
      isPlay.value = false;
      isPagePlay.value = false;
    }
  }

  loadQuranReader() async {
    readerValue = await sl<SharedPrefServices>().getString(AUDIO_PLAYER_SOUND,
        defaultValue: "Abdul_Basit_Murattal_192kbps");

    readerName.value = await sl<SharedPrefServices>()
        .getString(READER_NAME, defaultValue: 'عبد الباسط عبد الصمد');

    readerIndex.value = await sl<SharedPrefServices>()
        .getInteger(READER_INDEX, defaultValue: 1);
  }
}
