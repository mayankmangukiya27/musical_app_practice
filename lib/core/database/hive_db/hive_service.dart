import 'package:musical_app_practice/core/database/database_models/song_model.dart';
import 'package:musical_app_practice/core/database/hive_db/hive_boxes.dart';

class HiveService {
  Future<void> saveSongs(List<Song> songs) async {
    final box = HiveBoxes.getSongsBox();
    await box.clear();
    for (var song in songs) {
      await box.put(song.id, song);
    }
  }

  List<Song> getAllSongs() {
    final box = HiveBoxes.getSongsBox();
    return box.values.toList();
  }

  Future<void> addToCart(Song song) async {
    final box = HiveBoxes.getCartBox();
    await box.put(song.id, song);
  }

  List<Song> getCartItems() {
    final box = HiveBoxes.getCartBox();
    return box.values.toList();
  }

  Future<void> removeFromCart(String id) async {
    final box = HiveBoxes.getCartBox();
    await box.delete(id);
  }

  Future<void> clearCart() async {
    final box = HiveBoxes.getCartBox();
    await box.clear();
  }

  bool isInCart(String id) {
    final box = HiveBoxes.getCartBox();
    return box.containsKey(id);
  }
}
