import 'package:hive/hive.dart';
import 'package:musical_app_practice/core/database/database_models/song_model.dart';

class HiveBoxes {
  static Box<Song> getSongsBox() => Hive.box<Song>('songsBox');
  static Box<Song> getCartBox() => Hive.box<Song>('cartBox');
}
