import 'dart:async';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class _ClockController {
  final ValueNotifier<String> buttonText = ValueNotifier('Iniciar');
  final ValueNotifier<String> counter = ValueNotifier('Pronto ?');
  final audioPlayer = AssetsAudioPlayer();
  int _timeInMinutes = 2;
  int _timeInSeconds = 0;
  int _interval = 1;
  Timer? clockTimer;

  void _playAudio(String path) async {
    try {
      await audioPlayer.open(Audio(path),
          autoStart: true,
          playInBackground: PlayInBackground.enabled,
          forceOpen: true);
    } catch (e) {
      debugPrint('$e');
    }
  }

  void clock(int time, int interval) {
    _timeInMinutes = time;
    _interval += interval;
    buttonText.value = 'Parar';
    clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_timeInSeconds == 0) {
        playAudio();
        _timeInMinutes--;
        if (_timeInMinutes == -1) return stop();
        _timeInSeconds = 60;
      }
      _timeInSeconds--;
      counter.value = '$_timeInMinutes:$_timeInSeconds';
    });
  }

  void playAudio() {
    if (_timeInMinutes % _interval == 0) {
      _playAudio('assets/descansar.mp3');
    } else {
      _playAudio('assets/treinar.mp3');
    }
  }

  void stop() {
    buttonText.value = 'Iniciar';
    counter.value = 'O Treino Acabou.';
    clockTimer!.cancel();
  }
}

final clockState = _ClockController();
