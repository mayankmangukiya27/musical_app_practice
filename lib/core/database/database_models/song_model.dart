import 'package:hive/hive.dart';
part 'song_model.g.dart';

@HiveType(typeId: 0)
class Song extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String artist;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final String? audioUrl;

  @HiveField(5)
  final String? album;

  @HiveField(6)
  final String? releaseDate;


  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.imageUrl,
    this.audioUrl,
    this.album,
    this.releaseDate,
  });
  
}
