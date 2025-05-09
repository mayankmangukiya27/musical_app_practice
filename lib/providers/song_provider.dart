import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:musical_app_practice/core/constants/api_path.dart';
import 'package:musical_app_practice/core/database/database_models/song_model.dart';
import 'package:musical_app_practice/core/database/hive_db/hive_service.dart';
import 'package:musical_app_practice/models/song_response_model.dart';
import 'package:musical_app_practice/utils/song_entry_mapper.dart';

class SongProvider extends ChangeNotifier {
  final HiveService _hiveService = HiveService();

  List<Song> _songs = [];
  bool _isLoading = false;
  String? _error;

  List<Song> get songs => _songs;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadSongs() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final localSongs = _hiveService.getAllSongs();
    if (localSongs.isNotEmpty) {
      _songs = localSongs;
      _isLoading = false;
      notifyListeners();
    } else {
      try {
        final response = await http.get(Uri.parse(ApiPath.getAppleTunes));
        if (response.statusCode == 200) {
          final fullModel = songModelFromJson(response.body);
          final entries = fullModel.feed?.entry ?? [];
          final songs = entries.map(mapEntryToSong).toList();
          await _hiveService.saveSongs(songs);
          _songs = songs;
        } else {
          _error = 'Failed to fetch songs.';
        }
      } catch (e) {
        _error = e.toString();
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadSongsFromDb() async {
    _songs = _hiveService.getAllSongs();
    notifyListeners();
  }
}
