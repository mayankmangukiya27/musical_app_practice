import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 1)
class CartItem {
  @HiveField(0)
  final String songId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String artist;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final double price;

  @HiveField(5)
  int quantity;

  CartItem({
    required this.songId,
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;
}
