import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musical_app_practice/routes/app_route_names.dart';

class NavigationService {
  static goToCart(BuildContext context) {
    context.pushNamed(NamedRoutes.cart.name);
  }

  static goToSongDetails({required BuildContext context, required songId}) {
    context.pushNamed(NamedRoutes.songDetails.name, extra: songId);
  }

  static gotoHome(BuildContext context) {
    context.go(NamedRoutes.home.path);
  }
}
