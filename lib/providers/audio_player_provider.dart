import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../core/database/database_models/song_model.dart';

class AudioPlayerProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  Song? _currentSong;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isPlaying = false;

  Song? get currentSong => _currentSong;
  Duration get position => _position;
  Duration get duration => _duration;
  bool get isPlaying => _isPlaying;

  AudioPlayer get player => _player;

  AudioPlayerProvider() {
    _player.positionStream.listen((pos) {
      _position = pos;
      notifyListeners();
    });
    _player.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      notifyListeners();
    });
  }

  Future<void> playSong(Song song) async {
    if (_currentSong?.id != song.id) {
      _currentSong = song;
      await _player.setUrl(song.audioUrl ?? '');
    }
    await _player.play();
  }

  void togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }
}
