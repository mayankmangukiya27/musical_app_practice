import 'package:musical_app_practice/providers/audio_player_provider.dart';
import 'package:musical_app_practice/providers/cart_provider.dart';
import 'package:musical_app_practice/providers/song_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => SongProvider()),
  ChangeNotifierProvider(create: (_) => CartProvider()),
  ChangeNotifierProvider(create: (_) => AudioPlayerProvider()),
];
