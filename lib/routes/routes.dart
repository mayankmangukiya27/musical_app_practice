import 'package:go_router/go_router.dart';
import 'package:musical_app_practice/core/database/database_models/song_model.dart';
import 'package:musical_app_practice/routes/app_route_names.dart';
import 'package:musical_app_practice/screens/cart_screen.dart';
import 'package:musical_app_practice/screens/home_screen.dart';
import 'package:musical_app_practice/screens/song_details_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: NamedRoutes.home.path,
      name: NamedRoutes.home.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: NamedRoutes.songDetails.path,
      name: NamedRoutes.songDetails.name,
      builder: (context, state) {
        final song = state.extra as Song;
        return SongDetailScreen(song: song);
      },
    ),
    GoRoute(
      path: NamedRoutes.cart.path,
      name: NamedRoutes.cart.name,
      builder: (context, state) => const CartScreen(),
    ),
  ],
);
