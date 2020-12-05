import 'dart:async';
import 'dart:io' show Platform;

import 'package:ancient_hebrew_letters/cons/colors.dart';
import 'package:ancient_hebrew_letters/cons/icons_size.dart';
import 'package:ancient_hebrew_letters/cons/letters_data.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'letter_description_view.dart';

class LetterHomeView extends StatefulWidget {
  static final id = "LetterHomeView";
  final int letterIndex;
  LetterHomeView({this.letterIndex});
  @override
  _LetterHomeViewState createState() => _LetterHomeViewState();
}

class _LetterHomeViewState extends State<LetterHomeView> {
  AudioPlayer audioPlayer;
  AudioCache player = AudioCache(prefix: 'assets/');
  bool isSoundPlaying = false;
  bool isMusicBackgroundView = true;
  double progress = 0;
  Timer positionTimer;

  @override
  void initState() {
    initializeBackgroundSound();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/${Platform.isMacOS ? 'aleph-ios.gif' : 'aleph-android.gif'}"),
                      fit: BoxFit.cover))),
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: kLETTER_ICON_SIZE_LETTER_HOME,
                      width: kLETTER_ICON_SIZE_LETTER_HOME,
                      child: Image.asset(
                          'assets/${kLETTERS_DATA_MAP[widget.letterIndex][kIMAGE]}')),
                  Expanded(
                    child: SizedBox(),
                  ),
                  _bottomRow(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomRow() {
    return isMusicBackgroundView
        ? _getBackgroundMusicBottomRow()
        : _getLetterSoundBottomRow();
  }

  Widget _getLetterSoundBottomRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            iconSize: kICON_SIZE_LETTER_HOME,
            color: Colors.white,
            icon: Icon(
              isSoundPlaying ? Icons.pause : Icons.play_arrow,
            ),
            onPressed: pauseAndResumeBackgroundSound),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: LinearPercentIndicator(
            lineHeight: 14.0,
            percent: progress,
            backgroundColor: kPROGRESS_BAR_WHITE,
            progressColor: kPROGRESS_BAR_GRAY,
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  Widget _getBackgroundMusicBottomRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            iconSize: kICON_SIZE_LETTER_HOME,
            color: Colors.white,
            icon: Icon(
              isSoundPlaying ? Icons.music_off : Icons.music_note,
            ),
            onPressed: pauseAndResumeBackgroundSound),
        IconButton(
            iconSize: kICON_SIZE_BIG_LETTER_HOME,
            color: Colors.white,
            icon: Icon(
              Icons.play_arrow,
            ),
            onPressed: playVoiceRecording),
        IconButton(
            iconSize: kICON_SIZE_LETTER_HOME,
            color: Colors.white,
            icon: Icon(
              Icons.menu_book_outlined,
            ),
            onPressed: letterDescription),
      ],
    );
  }

  void initializeBackgroundSound() async {
    audioPlayer =
        await player.loop(kLETTERS_DATA_MAP[widget.letterIndex][kMUSIC]);
    setState(() {
      isSoundPlaying = true;
    });
  }

  void pauseAndResumeBackgroundSound() async {
    if (isSoundPlaying == true) {
      await pauseBackgroundSound();
    } else {
      int result = await audioPlayer.resume();
      if (result == 1) {
        setState(() {
          isSoundPlaying = true;
          print('play the background music');
        });
      }
    }
  }

  Future<void> pauseBackgroundSound() async {
    if (isSoundPlaying == true) {
      int result = await audioPlayer.pause();
      if (result == 1) {
        setState(() {
          isSoundPlaying = false;
        });
        print('stop the background music');
      }
    }
  }

  Future<void> playVoiceRecording() async {
    print('Voice recording');
    pauseBackgroundSound();
    setState(() {
      isMusicBackgroundView = false;
    });
    audioPlayer =
        await player.loop(kLETTERS_DATA_MAP[widget.letterIndex][kVOICE]);
    updateVoiceDuration();
    setState(() {
      isSoundPlaying = true;
    });
  }

  void updateVoiceDuration() async {
    final audioPlayerTemp = just_audio.AudioPlayer();
    Duration voiceLength = await audioPlayerTemp
        .setAsset('assets/${kLETTERS_DATA_MAP[widget.letterIndex][kVOICE]}');
    int currentPosition;
    positionTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      currentPosition = await audioPlayer.getCurrentPosition();
      currentPosition = currentPosition % voiceLength.inMilliseconds;
      setState(() {
        this.progress = currentPosition / voiceLength.inMilliseconds;
      });
      print(
          'totoal duation $voiceLength, current duration  = $currentPosition, progress = $progress');
    });
  }

  void letterDescription() {
    print('Letter Description');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LetterDescription(
          letterIndex: widget.letterIndex,
        ),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.pause();
    player.clearCache();
    positionTimer?.cancel();
    super.dispose();
  }
}
