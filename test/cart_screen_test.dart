import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:musical_app_practice/core/database/database_models/song_model.dart';
import 'package:musical_app_practice/providers/cart_provider.dart';
import 'package:musical_app_practice/screens/cart_screen.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Displays message when cart is empty', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
        child: const MaterialApp(home: CartScreen()),
      ),
    );

    expect(find.text('No items in the cart.'), findsOneWidget);
    expect(find.text('Checkout'), findsNothing);
  });

  testWidgets('Displays cart items when cart is not empty', (
    WidgetTester tester,
  ) async {
    final cartProvider = CartProvider();
    cartProvider.addToCart(
      Song(
        title: 'Song 1',
        artist: 'Artist A',
        imageUrl:
            'https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/6e/c9/00/6ec900c4-31cd-bde1-2eb1-b47bcfcc9c55/886443650176.jpg/170x170bb.png',
        id: '1',
      ),
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: cartProvider,
          child: const MaterialApp(home: CartScreen()),
        ),
      );
    });

    expect(find.text('Song 1'), findsOneWidget);
    expect(find.text('Artist A'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget); // Checkout button
  });

  testWidgets('Removes item from cart when remove button is tapped', (
    WidgetTester tester,
  ) async {
    final cartProvider = CartProvider();
    final song = Song(
      title: 'Song 2',
      artist: 'Artist B',
      imageUrl:
          'https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/6e/c9/00/6ec900c4-31cd-bde1-2eb1-b47bcfcc9c55/886443650176.jpg/170x170bb.png',
      id: '2',
    );
    cartProvider.addToCart(song);

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: cartProvider,
          child: const MaterialApp(home: CartScreen()),
        ),
      );
    });

    expect(find.text('Song 2'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.remove_circle));
    await tester.pumpAndSettle();
    expect(find.text('Song 2'), findsNothing);
  });

  group('CartScreen ListView.builder Tests', () {
    late CartProvider cartProvider;

    setUp(() {
      cartProvider = CartProvider();
      cartProvider.addToCart(
        Song(
          title: 'Test Song',
          artist: 'Test Artist',
          imageUrl:
              'https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/6e/c9/00/6ec900c4-31cd-bde1-2eb1-b47bcfcc9c55/886443650176.jpg/170x170bb.png',
          id: '1',
        ),
      );
    });

    testWidgets('Displays song details in ListView', (
      WidgetTester tester,
    ) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          ChangeNotifierProvider.value(
            value: cartProvider,
            child: const MaterialApp(home: CartScreen()),
          ),
        );
      });
      // Check song title and artist appear
      expect(find.text('Test Song'), findsOneWidget);
      expect(find.text('Test Artist'), findsOneWidget);

      // Check image is present
      expect(find.byType(Image), findsOneWidget);

      // Check remove icon button is present
      expect(find.byIcon(Icons.remove_circle), findsOneWidget);
    });

    testWidgets('Remove button removes song from cart', (
      WidgetTester tester,
    ) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          ChangeNotifierProvider.value(
            value: cartProvider,
            child: const MaterialApp(home: CartScreen()),
          ),
        );
      });

      // Confirm song is in the cart
      expect(find.text('Test Song'), findsOneWidget);

      // Tap the remove icon
      await tester.tap(find.byIcon(Icons.remove_circle));
      await tester.pumpAndSettle(); // Wait for state update

      // Song should be removed
      expect(find.text('Test Song'), findsNothing);
    });
  });
}
