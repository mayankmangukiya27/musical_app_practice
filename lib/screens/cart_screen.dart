import 'package:flutter/material.dart';
import 'package:musical_app_practice/core/database/database_models/song_model.dart';
import 'package:musical_app_practice/routes/app_routing.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  void _showCheckoutDialog(BuildContext context, CartProvider cartProvider) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Checkout Summary'),
            content: SizedBox(
              height: 300,
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: cartProvider.cartItems.length,
                itemBuilder: (context, index) {
                  final song = cartProvider.cartItems[index];
                  return ListTile(
                    title: Text(song.title),
                    subtitle: Text(song.artist),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  cartProvider.clearCart();
                  Navigator.pop(context);
                  NavigationService.gotoHome(context);
                },
                child: const Text('DONE'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('CANCEL'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body:
          cartProvider.cartItems.isEmpty
              ? const Center(child: Text('No items in the cart.'))
              : ListView.builder(
                itemCount: cartProvider.cartItems.length,
                itemBuilder: (context, index) {
                  final Song song = cartProvider.cartItems[index];
                  return ListTile(
                    leading: Image.network(
                      song.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(song.title),
                    subtitle: Text(song.artist),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () => cartProvider.removeFromCart(song),
                    ),
                  );
                },
              ),
      bottomNavigationBar:
          cartProvider.cartItems.isNotEmpty
              ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () => _showCheckoutDialog(context, cartProvider),
                  child: const Text('Checkout'),
                ),
              )
              : null,
    );
  }
}
