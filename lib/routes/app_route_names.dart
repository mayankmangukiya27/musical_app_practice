class NamedRoutes {
  static const AppRoute home = AppRoute(path: "/", name: "home");
  static const AppRoute songDetails = AppRoute(
    path: "/songDetail",
    name: "songDetail",
  );
  static const AppRoute cart = AppRoute(path: "/cart", name: "cart");
}

class AppRoute {
  final String path;
  final String name;
  const AppRoute({required this.path, required this.name});
}
